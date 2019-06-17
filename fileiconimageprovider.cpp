#include "fileiconimageprovider.h"
#include <QDebug>

FileIconImageProvider::FileIconImageProvider(): QQuickImageProvider(QQuickImageProvider::Pixmap)
{
}

QPixmap FileIconImageProvider::requestPixmap(const QString &filePath, QSize *size, const QSize &requestedSize)
{
    if(filePath.size() == 0)
    {
        qDebug() << "out";
        QPixmap empty;
        return empty;
    }

    int width = (requestedSize.width() > 0) ? requestedSize.width(): 32;
    int height = (requestedSize.height() > 0) ? requestedSize.height(): 32;
    if (size){
        *size = QSize(width, height);
    }

    QIcon icon =  QFileIconProvider().icon(QFileInfo(filePath));
    return icon.pixmap(width, height);
}
