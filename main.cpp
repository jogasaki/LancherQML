#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "fileiconimageprovider.h"
#include "process.h"
#include "localsettings.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);

    engine.rootContext()->setContextProperty("proc", new Process(&engine));
    engine.rootContext()->setContextProperty("localSettings", new LocalSettings(&engine));

    engine.addImageProvider(QLatin1String("fileicon"), new FileIconImageProvider);
    engine.load(url);

    return app.exec();
}
