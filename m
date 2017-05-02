From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: [PATCH v6 0/8] Add sbs-manager with smbalert support
Date: Tue,  2 May 2017 17:12:18 +0800
Message-ID: <1493716346-58517-1-git-send-email-preid@electromag.com.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org
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






Karl-Heinz Schneider (2):
  Documentation: Add sbs-manager device tree node documentation
  power: Adds support for Smart Battery System Manager

Phil Reid (6):
  i2c: i2c-smbus: Support threaded irqs.
  i2c: i2c-smbus: Add null ptr guard in smb_alert_probe
  i2c: i2c-smbus: add of_i2c_setup_smbus_alert
  i2c: core: call of_i2c_setup_smbus_alert in i2c_register_adapter
  i2c: mux: pca954x: Call request irq after adding mux segments
  power: supply: sbs-manager: Add alert callback and battery change
    notification

 Documentation/devicetree/bindings/i2c/i2c.txt      |   4 +-
 .../bindings/power/supply/sbs,sbs-manager.txt      |  66 ++++
 drivers/i2c/i2c-core.c                             |   4 +
 drivers/i2c/i2c-smbus.c                            |  64 ++-
 drivers/i2c/muxes/i2c-mux-pca954x.c                |  52 ++-
 drivers/power/supply/Kconfig                       |  14 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/sbs-manager.c                 | 438 +++++++++++++++++++++
 include/linux/i2c-smbus.h                          |   9 +
 9 files changed, 616 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
 create mode 100644 drivers/power/supply/sbs-manager.c

-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
