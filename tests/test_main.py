from pytest import LogCaptureFixture

from libs.main import hello_world


def test_hello_world(caplog: LogCaptureFixture) -> None:
    hello_world()
    assert "Hello world" in caplog.text
