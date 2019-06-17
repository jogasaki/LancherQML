#ifndef SETTINGS_H
#define SETTINGS_H

#include <QQuickItem>
#include <QJsonObject>

class LocalSettings : public QObject
{
    Q_OBJECT
public:
    explicit LocalSettings(QObject *parent);

signals:

public slots:
    void setValue(QString name, QVariant value);
    QVariant getValue(QString name);
    bool save();

private:
    //static const char* const _file_name;
    QJsonObject m_json;
    bool load();
};

#endif // SETTINGS_H
