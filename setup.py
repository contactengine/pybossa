from setuptools import setup, find_packages

with open('pybossa/version.txt') as f:
    version = f.readline()
__version__ = version.rstrip()

requirements = [
    "alembic==0.9.10",
    "arrow==0.12.1",
    "asn1crypto==0.24.0",
    "Babel==2.6.0",
    "beautifulsoup4==4.7.0",
    "blinker==1.4",
    "certifi==2018.11.29",
    "cffi>=1.11.5",
    "chardet==3.0.4",
    "Click==7.0",
    "colorama==0.4.1",
    "cov-core==1.15.0",
    "coverage==4.5.2",
    "croniter==0.3.28",
    "cryptography==3.3.2",
    "cssselect==1.0.3",
    "debtcollector==1.20.0",
    "decorator==4.3.0",
    "entrypoints==0.2.3",
    "factory-boy==2.4.1",
    "Faker==1.0.1",
    "feedparser==5.2.1",
    "Flask",
    "Flask-Assets==0.12",
    "Flask-Babel>=0.9",
    "Flask-Cors>=3.0.2",
    "Flask-DebugToolbar==0.10.1",
    "Flask-HTTPAuth>=3.2.4",
    "flask-json-multidict>=1.0.0",
    "Flask-Login>=0.4.1",
    "Flask-Mail>=0.9.1",
    "Flask-Misaka>=1.0.0",
    "Flask-Plugins>=1.6.1",
    "flask-profiler==1.6",
    "Flask-SimpleLDAP>=1.1.2",
    "Flask-SQLAlchemy>=2.3.2",
    "Flask-WTF>=0.9.5,<1.0.0",
    "flatten-json==0.1.6",
    "google-api-python-client==1.5.5",
    "html2text==2014.7.3",
    "httplib2==0.20.1",
    "humanize==0.5.1",
    "idna==2.8",
    "iiif-prezi>=0.2.9",
    "infinity==1.4",
    "intervals==0.8.1",
    "iso8601==0.1.12",
    "itsdangerous==1.1.0",
    "jeepney==0.4",
    "Jinja2>=2.10.1",
    "jsmin==2.2.2",
    "keyring==17.1.1",
    "keystoneauth1==3.11.2",
    "libsass==0.16.1",
    "lxml==4.6.3",
    "Mako==1.0.7",
    "Markdown==2.6.11",
    "MarkupSafe==1.1.0",
    "misaka==2.1.1",
    "mock==2.0.0",
    "msgpack==0.6.0",
    "ndg-httpsclient==0.5.1",
    "netaddr==0.7.19",
    "netifaces==0.10.9",
    "nose==1.3.7",
    "nose-cov==1.6",
    "numpy==1.20.1",
    "oauth2client==4.1.3",
    "oauthlib==2.1.0",
    "os-service-types==1.4.0",
    "oslo.config==6.7.0",
    "oslo.i18n==3.23.0",
    "oslo.serialization==2.28.1",
    "oslo.utils==3.39.0",
    "otpauth==1.0.1",
    "pandas==1.2.3",
    "pbr>=1.10.0",
    "Pillow>=6.2.0",
    "prettytable==0.7.2",
    "psycopg2-binary>=2.7.6.1",
    "pyasn1==0.4.5",
    "pyasn1-modules==0.2.3",
    "pybossa-onesignal==1.1",
    "pycountry",
    "pycparser==2.19",
    "pycryptodome==3.7.2",
    "PyJWT==1.7.1",
    "PyLD==1.0.4",
    "pyldap==3.0.0.post1",
    "pyOpenSSL==18.0.0",
    "pyparsing==2.4.7",
    "python-dateutil==2.7.5",
    "python-editor==1.0.3",
    "python-keystoneclient==3.18.0",
    "python-ldap==3.1.0",
    "python-novaclient>=2.27.0",
    "pytz==2018.7",
    "PyYAML==5.4.1",
    "rackspace-auth-openstack==1.3",
    "rackspace-novaclient>=2.1",
    "raven==6.10.0",
    "readability-lxml==0.7",
    "redis==3.3.6",
    "rednose==1.3.0",
    "requests==2.26.0",
    "requests-oauthlib==1.0.0",
    "rfc3986==1.2.0",
    "rq==0.13.0",
    "rq-dashboard==0.3.12",
    "rq-scheduler==0.9",
    "rsa>=4.0",
    "SecretStorage==3.1.0",
    "simplejson==3.16.0",
    "six==1.12.0",
    "soupsieve==1.6.1",
    "speaklater==1.3",
    "SQLAlchemy>=1.3.0",
    "sqlalchemy-json==0.4.0",
    "stevedore>=1.30.0",
    "termstyle==0.1.11",
    "text-unidecode==1.2",
    "twitter==1.17.1",
    "Unidecode==0.4.21",
    "uritemplate==3.0.0",
    "urllib3==1.26.7",
    "validators==0.12.6",
    "webassets==0.12.1",
    "Werkzeug",
    "wrapt==1.10.11",
    "WTForms>=1.0.5,<3.0.0",
    "WTForms-Components>=0.10.3",
    "yacryptopan==1.0.0",
    "email_validator==1.1.1"
]

setup(
    name='pybossa',
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
    author='Scifabric LTD',
    author_email='info@scifabric.com',
    description='Open Source CrowdSourcing framework',
    long_description='''PYBOSSA is the ultimate crowdsourcing framework to analyze or enrich data that can't be processed by machines alone.''',
    license='AGPLv3',
    url='http://pybossa.com',
    download_url='https://github.com/Scifabric/pybossa',
    include_package_data=True,
    classifiers=[
        'Development Status :: 5 - Production/Stable',
        'Environment :: Console',
        'Intended Audience :: Developers',
        'License :: OSI Approved :: GNU Affero v3',
        'Operating System :: OS Independent',
        'Programming Language :: Python',
        'Topic :: Software Development :: Libraries :: Python Modules'
    ],
    entry_points='''
    '''
)
