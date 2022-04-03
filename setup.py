try:
    from setuptools import setup
except ImportError:
    from distutils.core import setup

setup(
        name='scadat',
        version='0.4.12',
        author='Martin Mohan',
        author_email='martinmohan@yahoo.com',
        packages=['scadat'],
        scripts=['scadat/scadat_test.sh','scadat/assertequal.sh','scadat/assertgrep.sh','scadat/asserttrue.sh','scadat/scadat', 'scadat/scadat.py', 'scadat/scadat_search.sh'],
        url='http://pypi.python.org/pypi/scadat/',
        license='LICENSE.txt',
        description='A shell interface to tango open source scada',
#        long_description=long_description,
        long_description=open('README.rst').read(),
        install_requires=[
            "PyTango",
            ],
        classifiers=[
            'Development Status :: 3 - Alpha',
            'Environment :: Console',
            'Environment :: Web Environment',
            'Intended Audience :: Developers',
            'Intended Audience :: System Administrators',
            'License :: OSI Approved :: GNU General Public License (GPL)',
            'Programming Language :: Python',
            'Topic :: System',
            'Topic :: Software Development',
            ],

        )
