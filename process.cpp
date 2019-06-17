#include "process.h"
#include <QDebug>
#include <QUrl>
#include <QDesktopServices>

Process::Process(QObject *parent) : QObject(parent) {

}

void Process::start(const QString &program) {
    QString path = QStandardPaths :: writableLocation( QStandardPaths :: GenericDataLocation );
    QUrl url = QUrl::fromLocalFile( program );
    QDesktopServices::openUrl( url );
    //qDebug() << "Running" << url;
}
