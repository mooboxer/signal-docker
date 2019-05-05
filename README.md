# signal-docker
Docker image to send and receive signal messages

This image uses **signal-cli** to send or receive signal messages.

See futher documentation on how to use signal-cli look at the [documentation
of signal-cli project](https://github.com/AsamK/signal-cli). 

## Building the Image

```bash
docker build -t mooboxer/signal-docker .
```

## Initialization

### Registration of a New User

Register a new signal user on a phone number per SMS:

```bash
docker run --rm -v signal-data:/signal mooboxer/signald-docker signal-cli register <user-phone-number>
```

or per voice registration:

```bash
docker run --rm -v signal-data:/signal mooboxer/signal-docker signal-cli register --voice <user-phone-number>
```

### Linking to an Existing account

To connect your docker container to an existing setup of signal you need to
link your account to the existing one. Therefore you need to create a link:

```bash
docker run --rm -v signal-data:/signal  mooboxer/signal-docker signal-cli link -n "Name of device"
```

The above generated URI can now being used to add the new divice to the
existing account. In case of ``signal-cli`` the command to add the new
device is:

```bash
signal-cli -u <user-phone-number>  addDevice --uri "tsdevice:/?uuid=sXPft8UswtOKGwUdIwr5Fg&pub_key=BZ8McDvOGunvKJhX9icEmtwVNQpvO%2Fb292E0%2BR63nt46" 
```

## Usage of the Image

After the initalization the image can be used to transmit or receive
messages with the signal messaging service:

### Send messages

Send a normal text message:

```bash
docker run --rm -v signal-data:/signal mooboxer/signald-docker signal-cli -u <user-phone-number> send -m "Message to be sent" <recipient-phone-number>
```

To send an attached file the attachment must be given additional volume to the
container:

```bash
docker run --rm -v signal-data:/signal -v $PWD/<file1>:/signal/<file1> mooboxer/signal-docker signal-cli -u <user-phone-number> send -m "Message to be sent" <recipient-phone-number>
-a <file1>
```

### Receive a Message

```bash
docker run --rm -v signal-data:/signal mooboxer/signal-docker signal-cli -u <user-phone-number> receive