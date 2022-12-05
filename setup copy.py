from setuptools import setup, find_packages

with open("pybossa/version.txt") as f:
    version = f.readline()
__version__ = version.rstrip()

requirements = [
  "alembic==1.7.3",
  "arrow==1.1.1",
  "asn1crypto==1.4.0",
  "Babel==2.9.1",
  "beautifulsoup4==4.10.0",
  "blinker==1.4",
  "certifi==2021.5.30",
  "cffi==1.14.6",
  "chardet==4.0.0",
  "click==8.0.1",
  "colorama==0.4.4",
  "cov-core==1.15.0",
  "coverage==5.5",
  "croniter==1.0.15",
  "cryptography==3.4.8",
  "cssselect==1.1.0",
  "debtcollector==2.3.0",
  "decorator==5.1.0",
  "entrypoints==0.3",
  "factory-boy==3.2.0",
  "Faker==8.14.0",
  "feedparser==6.0.8",
  "Flask==2.0.1",
  "Flask-Assets==2.0",
  "Flask-Babel==2.0.0",
  "Flask-Cors==3.0.10",
  "Flask-DebugToolbar==0.11.0",
  "Flask-HTTPAuth==4.4.0",
  "flask-json-multidict==1.0.0",
  "Flask-Login==0.5.0",
  "Flask-Mail==0.9.1",
  "Flask-Misaka==1.0.0",
  "Flask-Plugins==1.6.1",
  "flask-profiler==1.8.1",
  "Flask-SimpleLDAP==1.4.0",
  "Flask-SQLAlchemy==2.5.1",
  "Flask-WTF==0.15.1",
  "flatten-json==0.1.13",
  "google-api-python-client==2.23.0",
  "html2text==2020.1.16",
  "httplib2==0.19.1",
  "humanize==3.11.0",
  "idna==3.2",
  "iiif-prezi==0.3.0",
  "infinity==1.5",
  "intervals==0.9.2",
  "iso8601==0.1.16",
  "itsdangerous==2.0.1",
  "jeepney==0.7.1",
  "Jinja2==3.0.1",
  "jsmin==3.0.0",
  "keyring==23.2.1",
  "keystoneauth1==4.4.0",
  "libsass==0.21.0",
  "lxml==4.6.3",
  "Mako==1.1.5",
  "Markdown==3.3.4",
  "MarkupSafe==2.0.1",
  "misaka==2.1.1",
  "mock==2.0.0",
  "msgpack==1.0.2",
  "ndg-httpsclient==0.5.1",
  "netaddr==0.8.0",
  "netifaces==0.11.0",
  "nose==1.3.7",
  "nose-cov==1.6",
  "numpy==1.21.2",
  "oauth2client==4.1.3",
  "oauthlib==2.1.0",
  "os-service-types==1.7.0",
  "oslo.config==8.7.1",
  "oslo.i18n==5.1.0",
  "oslo.serialization==4.2.0",
  "oslo.utils==4.10.0",
  "otpauth==1.0.1",
  "pandas==1.3.3",
  "pbr==5.6.0",
  "Pillow==8.3.2",
  "prettytable==2.2.1",
  "psycopg2-binary>=2.7.6.1",
  "pyasn1==0.4.8",
  "pyasn1-modules==0.2.8",
  "pybossa-onesignal==1.1",
  "pycountry",
  "pycparser==2.19",
  "pycryptodome==3.10.4",
  "PyJWT==2.1.0",
  "PyLD==1.0.4",
  "pyldap==3.0.0.post1",
  "pyOpenSSL==21.0.0",
  "pyparsing==2.4.7",
  "python-dateutil==2.8.2",
  "python-editor==1.0.4",
  "python-keystoneclient==4.3.0",
  "python-ldap==3.3.1",
  "python-novaclient==17.6.0",
  "pytz==2021.1",
  "PyYAML==5.4.1",
  "rackspace-auth-openstack==1.3",
  "rackspace-novaclient>=2.1",
  "raven==6.10.0",
  "readability-lxml==0.8.1",
  "redis==3.5.3",
  "rednose==1.3.0",
  "requests==2.26.0",
  "requests-oauthlib==1.1.0",
  "rfc3986==1.5.0",
  "rq==1.10.0",
  "rq-dashboard==0.6.1",
  "rq-scheduler==0.11.0",
  "rsa==4.7.2",
  "SecretStorage==3.3.1",
  "simplejson==3.17.5",
  "six==1.16.0",
  "soupsieve==2.2.1",
  "speaklater==1.3",
  "SQLAlchemy==1.4.25",
  "sqlalchemy-json==0.4.0",
  "stevedore==3.4.0",
  "termstyle==0.1.11",
  "text-unidecode==1.3",
  "twitter==1.19.3",
  "Unidecode==1.3.2",
  "uritemplate==3.0.1",
  "urllib3==1.26.7",
  "validators==0.18.2",
  "webassets==2.0",
  "Werkzeug==2.0.1",
  "wrapt==1.12.1",
  "WTForms==2.3.3",
  "WTForms-Components==0.10.5",
  "yacryptopan==1.0.1",
  "email_validator==1.1.1",
]

setup(
    name="pybossa",
    version=__version__,
    packages=find_packages(),
    install_requires=requirements,
    # only needed when installing directly from setup.py (PyPi, eggs?) and pointing to e.g. a git repo.
    # Keep in mind that dependency_links are not used when installing with requirements.txt
    # and need to be added redundant to requirements.txt in this case!
    # Example:
    # dependency_links = [
    #     'git+git@github.com:Scifabric/pybossa.git@b8ab2ef199e82ca417d470bbed916c7b8dbda4d4#egg=pybossa'
    # ]
    # metadata for upload to PyPI
    author="Scifabric LTD",
    author_email="info@scifabric.com",
    description="Open Source CrowdSourcing framework",
    long_description="""PYBOSSA is the ultimate crowdsourcing framework to analyze or enrich data that can't be processed by machines alone.""",
    license="AGPLv3",
    url="http://pybossa.com",
    download_url="https://github.com/Scifabric/pybossa",
    include_package_data=True,
    classifiers=[
        "Development Status :: 5 - Production/Stable",
        "Environment :: Console",
        "Intended Audience :: Developers",
        "License :: OSI Approved :: GNU Affero v3",
        "Operating System :: OS Independent",
        "Programming Language :: Python",
        "Topic :: Software Development :: Libraries :: Python Modules",
    ],
    entry_points="""
    """,
)
