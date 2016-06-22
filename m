From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Subject: [PATCH 0/2] Add support for Smart Battery System Manager
Date: Wed, 22 Jun 2016 21:07:14 +0200
Message-ID: <1466622436-27963-1-git-send-email-karl-heinz@schneider-inet.de>
Return-path: <linux-i2c-owner@vger.kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Rosin <peda@axentia.se>, Phil Reid <preid@electromag.com.au>, Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
List-Id: linux-pm@vger.kernel.org

This patch series adds support for Smart Battery System Manager.
A SBSM is a device listening at I2C/SMBus address 0x0a and is capable of
communicating up to four I2C smart battery devices. All smart battery
devices are listening at address 0x0b, so the SBSM muliplexes between
them. The driver makes use of the I2C-Mux framework to allow smart
batteries to be bound via device tree, i.e. the sbs-battery driver.

Via sysfs interface the online state and charge type are presented. If
the driver is bound as ltc1760 (a Dual Smart Battery System Manager)
the charge type can also be changed from trickle to fast.

Patch set generated against v4.7rc-4.

Karl-Heinz Schneider (2):
  Documentation: Add sbs-manager device tree node documentation
  power: Adds support for Smart Battery System Manager

 .../devicetree/bindings/power/sbs,sbs-manager.txt  |  57 ++++
 drivers/power/Kconfig                              |  13 +
 drivers/power/Makefile                             |   1 +
 drivers/power/sbs-manager.c                        | 346 +++++++++++++++++++++
 4 files changed, 417 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
 create mode 100644 drivers/power/sbs-manager.c

--
1.9.1
