From: Phil Reid <preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org>
Subject: [PATCH v11 00/10]  Add sbs-manager with smbalert support
Date: Thu, 24 Aug 2017 17:31:00 +0800
Message-ID: <1503567070-115646-1-git-send-email-preid@electromag.com.au>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: wsa-z923LK4zBo2bacvFa/9K2g@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, jdelvare-IBi9RG/b67k@public.gmane.org, jglauber-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, david.daney-YGCgFSpz5w/QT0dZR+AlfA@public.gmane.org, peda-koto5C5qi+TLoDKTGw+V6w@public.gmane.org, preid-qgqNFa1JUf/o2iN0hyhwsIdd74u8MsAO@public.gmane.org, benjamin.tissoires-H+wXaHxf7aLQT0dZR+AlfA@public.gmane.org, linux-i2c-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
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

Changes from v7
- Remove 2 patches that have been applied for incorrect le16_to_cpu
- i2c: i2c-smbus: Use threaded irq for smbalert
  - Added reviewed by Benjamin
- i2c: i2c-smbus: add of_i2c_setup_smbus_alert
  - Remove rename of variable, use adapater instead of adap in new function
  - Add CONFIG_OF guard 
- i2c: core: call of_i2c_setup_smbus_alert in i2c_register_adapter
  - Move call to just after register call and add error cleanup
  - Didn't split this as per review comments as the 1 error 
    of_property_match_string can return seems pretty unlikely.
    I don't think there's much benefit to it.
- i2c: mux: pca954x: Call request irq after adding mux segments
  - split into two patches. 
    pt1 as acked by Peter
    pt2 the extra error handling for irq_create_mapping as suggested in his review
- The rest
  - Added reviewed by Sebastian
    
  
Changes from v8
- i2c: mux: pca954x: Return error if irq_create_mapping fails
  - Add Peter's ack
  - change return check to if (!irq)

Changes from v9
- Move i2c_setup_smbbus_alert & of_i2c_setup_smbus_alert to
  i2c-core-smbus to resolve linking issues with modules.
  No functional changes.
- i2c: mux: pca954x: Call request irq after adding mux segments
  While testing above changes noticed a warning about unbalanced
  irq_enable / disable. This is resolved by remove the irq_mask
  irq_unmask functions that where an inital workaroudn to the
  problem this patch now fixes by delaying request irq.
  Removed Peter's ack on this one as it's changed.

Changes from v10
- i2c: mux: pca954x: Call request irq after adding mux segments 
  Added Peters ack
  renamed label 'fail_del_adapters' to 'fail_cleanup'

Karl-Heinz Schneider (2):
  Documentation: Add sbs-manager device tree node documentation
  power: Adds support for Smart Battery System Manager

Phil Reid (8):
  i2c: i2c-smbus: Use threaded irq for smbalert
  i2c: i2c-smbus: Move i2c_setup_smbus_alert from i2c-smbus to
    i2c-core-smbus
  i2c: i2c-smbus: add of_i2c_setup_smbus_alert
  i2c: core: call of_i2c_setup_smbus_alert in i2c_register_adapter
  i2c: mux: pca954x: call request irq after adding mux segments
  i2c: mux: pca954x: Return error if irq_create_mapping fails
  power: supply: sbs-manager: Add alert callback and battery change
    notification
  power: supply: sbs-battery: move gpio present detect to
    sbs_get_property

 Documentation/devicetree/bindings/i2c/i2c.txt      |   4 +-
 .../bindings/power/supply/sbs,sbs-manager.txt      |  66 +++
 drivers/i2c/busses/i2c-parport-light.c             |   1 -
 drivers/i2c/busses/i2c-parport.c                   |   1 -
 drivers/i2c/busses/i2c-thunderx-pcidrv.c           |   6 -
 drivers/i2c/i2c-core-base.c                        |   9 +
 drivers/i2c/i2c-core-smbus.c                       |  55 +++
 drivers/i2c/i2c-smbus.c                            |  81 ++--
 drivers/i2c/muxes/i2c-mux-pca954x.c                |  95 ++---
 drivers/power/supply/Kconfig                       |  14 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/sbs-battery.c                 |  23 +-
 drivers/power/supply/sbs-manager.c                 | 444 +++++++++++++++++++++
 include/linux/i2c-smbus.h                          |  10 +-
 14 files changed, 670 insertions(+), 140 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/supply/sbs,sbs-manager.txt
 create mode 100644 drivers/power/supply/sbs-manager.c

-- 
1.8.3.1

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
