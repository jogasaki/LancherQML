#include "localsettings.h"
#include <QVariant>
#include <QFile>
#include <QJsonDocument>
#include <QDebug>

#define SETTINGS_FILE_NAME   "LocalSettings.json"

LocalSettings::LocalSettings(QObject *parent) : QObject(parent)
{
    load();
}

void LocalSettings::setValue(QString name, QVariant value)
{
    switch (value.type()) {
    case QVariant::Bool:
        m_json[name] = value.toBool();
        break;
    case QVariant::Double:
    case QVariant::Int:
        m_json[name] = value.toDouble();
        break;
    default:
        m_json[name] = value.toString();
        break;
    }
}

QVariant LocalSettings::getValue(QString name)
{
    QVariant value;
    switch (m_json[name].type()) {
    case QJsonValue::Bool:
        value = m_json[name].toBool();
        break;
    case QJsonValue::Double:
        value = m_json[name].toDouble();
        break;
    case QJsonValue::Null:
    case QJsonValue::Undefined:
        value.clear();
        // no break;
    default:
        value = m_json[name].toString();
        break;
    }
    return value;
}

bool LocalSettings::save()
{
    QFile saveFile(QStringLiteral(SETTINGS_FILE_NAME));
    if(!saveFile.open(QIODevice::WriteOnly)){
        qWarning("Couldn't open save file.");
        return false;
    }
    qDebug() << "open save file is succeeded.";
    QJsonDocument saveDoc(m_json);
    saveFile.write(saveDoc.toJson());
    return true;
}

bool LocalSettings::load()
{
    QFile loadFile(QStringLiteral(SETTINGS_FILE_NAME));
    if(!loadFile.open(QIODevice::ReadOnly)){
        qWarning("Couldn't open setting file.");
        return false;
    }
    qDebug() << "open setting file is succeeded.";
    QByteArray saveData = loadFile.readAll();
    QJsonDocument loadDoc(QJsonDocument::fromJson(saveData));
    m_json = loadDoc.object();
    return true;
}
