## docker-generatedata

This installs the standalone version of generatedata.com, using Docker.

### Requirements

- docker
- docker-compose

### Usage

- Clone this repository **recursively** and enter the directory
```bash
git clone --recursive https://github.com/mvisonneau/docker-generatedata.git generatedata && cd generatedata
```
- Copy the settings.php file into the submodule :
```bash
cp settings.php app/
```
- Set full access rights onto the /cache folder
```bash
chmod 777 app/cache
```
- Run it !
```bash
docker-compose up
```