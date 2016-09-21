From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v5 0/6] power: supply: sbs-manager add driver.
Date: Wed, 21 Sep 2016 16:41:08 +0800
Message-ID: <1474447274-90821-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, andrea.merello@gmail.com, preid@electromag.com.au, karl-heinz@schneider-inet.de, arnd@arndb.de, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The sbs-manager driver was written by Karl-Heinz and I've added irq
support to the driver to generate power_supply_change notices.
Hope I'm not violating etticate too much with this series

I've include Andrea's smb_alert driver changes here primarily to allow
testing of the alert callback. It looks like those changes stalled.
I'd be keen to implement necessary changes to this to get dt support
for the smbus_alert driver into mainline. Just need some guidance on
how.

Patches are applied against linux-power-supply/for-next


This patch series adds support for Smart Battery System Manager.
A SBSM is a device listening at I2C/SMBus address 0x0a and is capable of
communicating up to four I2C smart battery devices. All smart battery
devices are listening at address 0x0b, so the SBSM muliplexes between
them. The driver makes use of the I2C-Mux framework to allow smart
batteries to be bound via device tree, i.e. the sbs-battery driver.

Via sysfs interface the online state and charge type are presented. If
the driver is bound as ltc1760 (a Dual Smart Battery System Manager)
the charge type can also be changed from trickle to fast.

Changes:
V2:
* Fixed sample node names and compatible strings in binding documentaton.
* Removed optional property "sbsm,i2c-retry-count"
* Retry count hardcoded. Removed no longer needed OF readout function
* Rebased onto v4.7rc-5

V3:
* Changed enumeration sheme
* Rebased onto v4.7rc-7

V4:
* removed .owner field as advised by kbuild test robot
* removed print on ENOMEM
* added reference to i2c-mux documentation in binding doc

V5: v2 of my (Phil) Add irq support and battery detect gpios.
* update karl's sbs-manager binding to include gpio defintions.
* rebase onto linux-power-supply/for-next
* Add alert callback to sbs-manager.
* Expose battery presence via gpio to maintain compatiblity with
  sbs-battery driver.
* Notify attached batteries of state change via alert callback.
  This was done to avoid the need for the driver to become an irq
  source. This reduces the code a fair bit.
  Hopefully the implementation meets with approval.


Andrea Merello (1):
  I2C: i2c-smbus: add device tree support

Karl-Heinz Schneider (2):
  Documentation: Add sbs-manager device tree node documentation
  power: Adds support for Smart Battery System Manager

Phil Reid (3):
  i2c: i2c-smbus: Support threaded irq.
  power: supply: sbs-battery: Add alert callback.
  power: supply: sbs-manager: Add alert callback and battery change
    notification.

 .../devicetree/bindings/i2c/i2c-smbus.txt          |  20 +
 .../bindings/power/supply/sbs,sbs-manager.txt      |  62 +++
 drivers/i2c/i2c-smbus.c                            |  41 +-
 drivers/power/supply/Kconfig                       |  13 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/sbs-battery.c                 |  16 +-
 drivers/power/supply/sbs-manager.c                 | 451 +++++++++++++++++++++
 7 files changed, 591 insertions(+), 13 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/i2c/i2c-smbus.txt
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
 create mode 100644 drivers/power/supply/sbs-manager.c

-- 
1.8.3.1
