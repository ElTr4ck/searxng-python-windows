# SPDX-License-Identifier: AGPL-3.0-or-later
"""ASGI entry point to run SearXNG with uvicorn (no Docker needed)::

    uvicorn asgi:app --host 127.0.0.1 --port 8888

SearXNG is a Flask (WSGI) app, a2wsgi wraps it so an ASGI server can serve it.
"""

import os
from pathlib import Path

# must be set before searx is imported: settings are loaded at import time
os.environ.setdefault("SEARXNG_SETTINGS_PATH", str(Path(__file__).parent / "local" / "settings.yml"))

from a2wsgi import WSGIMiddleware  # noqa: E402

from searx.webapp import app as flask_app  # noqa: E402

app = WSGIMiddleware(flask_app, workers=20)
