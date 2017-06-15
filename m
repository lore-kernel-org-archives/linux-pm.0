From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v7 00/10] Add sbs-manager with smbalert support
Date: Thu, 15 Jun 2017 21:59:28 +0800
Message-ID: <1497535178-12001-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-i2c-owner@vger.kernel.org>
Sender: linux-i2c-owner@vger.kernel.org
To: wsa@the-dreams.de, robh+dt@kernel.org, mark.rutland@arm.com, sre@kernel.org, jdelvare@suse.com, jglauber@cavium.com, david.daney@cavium.com, peda@axentia.se, preid@electromag.com.au, linux-i2c@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org
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

Changes from v5:
- Documentation: Add sbs-manager device tree node documentation
  - Use same style as sbs-charger for compatible property. 
- power: Adds support for Smart Battery System Manager
  - reorder kconfig / makefile
  - remove errouinous le16 to cpu conversions
  - while loops to for loops
  - formating changes to error messages
  - changed sbsm_set_proprty indentation (hopefully I got it right)
  - removed CONFIG_OF conditional around of_device_id table
  - ENODEV -> EINVAL in probe function for mismatched address
  - Use BIT() macro in probe function
  - add of_node assignment in probe function
  - remove owner assignament and set of_match_table
- power: supply: sbs-battery: Add alert callback
  - Removed patch as Sebastian has queued it.
- power: supply: sbs-manager: Add alert callback and battery change notification
  - Use device_property_present instead of of_get_property
  - Add depends on GPIOLIB

Changes from v6
- Add 2 patches to remove incorrect le16_to_cpu calls in bq24735 & sbs-battery
  this was identifed in review of v6
- i2c: i2c-smbus: Use threaded irq for smbalert
  - remove alert_edge_triggered flag, see new description
  - rework the work thread and threaded irq,commit log has more details
  - Update in tree drivers where required (untested)
- i2c: i2c-smbus: add of_i2c_setup_smbus_alert
  - Add Rob's ack for doc binding
  - rework of_i2c_setup_smbus_alert so that it doesn't need to alloc memory
    addressing concern about devres allocation.
    Probe function looks up the irq number if platform data isn't defined.
- i2c: core: call of_i2c_setup_smbus_alert in i2c_register_adapter
  - investigate if the core will release the client
    It looks like it will to me, in i2c_del_adapter it iterates thru all clients
    and calls __unregister_client.
- i2c: mux: pca954x: Call request irq after adding mux segments
  - fix logic in guard for request irq
  - fix identation
  - add check to irq_create_mapping call
- Documentation: Add sbs-manager device tree node documentation
  - Remove leading 0's
  - Add Rob's ack
- power: Adds support for Smart Battery System Manager
  - remove inc header <linux/of_device.h>
  - add macro defines for various bit and masks.
  - refactor loop around i2c_mux_add_adapter 
  - Add ifdef CONFIG_OF around OF device table to save some bytes 
- power: supply: sbs-manager: Add alert callback and battery change notification
  - Add Sebastian's ack for binding
- Added new patch
  - power: supply: sbs-battery: move gpio present detect to sbs_get_property


Karl-Heinz Schneider (2):
  Documentation: Add sbs-manager device tree node documentation
  power: Adds support for Smart Battery System Manager

Phil Reid (8):
  power: supply: sbs-battery: remove incorrect le16_to_cpu calls
  power: supply: bq24735: remove incorrect le16_to_cpu calls
  i2c: i2c-smbus: Use threaded irq for smbalert
  i2c: i2c-smbus: add of_i2c_setup_smbus_alert
  i2c: core: call of_i2c_setup_smbus_alert in i2c_register_adapter
  i2c: mux: pca954x: Call request irq after adding mux segments
  power: supply: sbs-manager: Add alert callback and battery change
    notification
  power: supply: sbs-battery: move gpio present detect to
    sbs_get_property

 Documentation/devicetree/bindings/i2c/i2c.txt      |   4 +-
 .../bindings/power/supply/sbs,sbs-manager.txt      |  66 +++
 drivers/i2c/busses/i2c-parport-light.c             |   1 -
 drivers/i2c/busses/i2c-parport.c                   |   1 -
 drivers/i2c/busses/i2c-thunderx-pcidrv.c           |   6 -
 drivers/i2c/i2c-core.c                             |   4 +
 drivers/i2c/i2c-smbus.c                            |  71 ++--
 drivers/i2c/muxes/i2c-mux-pca954x.c                |  59 +--
 drivers/power/supply/Kconfig                       |  14 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/bq24735-charger.c             |   6 +-
 drivers/power/supply/sbs-battery.c                 |  30 +-
 drivers/power/supply/sbs-manager.c                 | 444 +++++++++++++++++++++
 include/linux/i2c-smbus.h                          |  10 +-
 14 files changed, 634 insertions(+), 83 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
 create mode 100644 drivers/power/supply/sbs-manager.c

-- 
1.8.3.1
