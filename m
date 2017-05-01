From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v5 0/9] Add sbs-manager with smbalert support
Date: Mon,  1 May 2017 16:49:50 +0800
Message-ID: <1493628599-30552-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, peda@axentia.se, preid@electromag.com.au, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This is another go of the sbs-manager driver using smbalert for
irq support from a while ago. 

Enables the existing smbalert driver to be loaded via the device tree.
Only need to add smbus_alert interrupt to the i2c bus segement in the
devicetree and the core will then enable the alert driver.

Reorders the rquest irq call in the pca954x driver to ensure each
muxed i2c segment can handle service smbalerts on that segment before
irq's are enabled. The pca954x can't mask individual irq's routed thru
them.

Add the sbs-manager from Karl-Heinz.
Add the alert call back and gpio interface to allow the battery detect
logic in the existing sbs-battery driver to work.



Karl-Heinz Schneider (2):
  Documentation: Add sbs-manager device tree node documentation
  power: Adds support for Smart Battery System Manager

Phil Reid (7):
  i2c: i2c-smbus: Support threaded irqs.
  i2c: i2c-smbus: Add null ptr guard in smb_alert_probe
  i2c: i2c-smbus: add of_i2c_setup_smbus_alert
  i2c: core: call of_i2c_setup_smbus_alert in i2c_register_adapter
  i2c: mux: pca954x: Call request irq after adding mux segments
  power: supply: sbs-battery: Add alert callback
  power: supply: sbs-manager: Add alert callback and battery change
    notification

 Documentation/devicetree/bindings/i2c/i2c.txt      |   4 +-
 .../bindings/power/supply/sbs,sbs-manager.txt      |  64 +++
 drivers/i2c/i2c-core.c                             |   4 +
 drivers/i2c/i2c-smbus.c                            |  64 ++-
 drivers/i2c/muxes/i2c-mux-pca954x.c                |  52 ++-
 drivers/power/supply/Kconfig                       |  14 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/sbs-battery.c                 |  16 +-
 drivers/power/supply/sbs-manager.c                 | 448 +++++++++++++++++++++
 include/linux/i2c-smbus.h                          |   9 +
 10 files changed, 637 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
 create mode 100644 drivers/power/supply/sbs-manager.c

-- 
1.8.3.1
