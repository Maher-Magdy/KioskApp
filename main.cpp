#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQuickWindow>

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("KioskApp", "Main");

    // show full screen
    auto *window = qobject_cast<QQuickWindow *>(engine.rootObjects().first());

    if (window)
        window->showFullScreen();

    return QGuiApplication::exec();
}
