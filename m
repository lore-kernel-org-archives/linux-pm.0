From: Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Subject: [PATCH v6 0/4] add reboot mode driver
Date: Tue, 22 Mar 2016 19:35:25 +0800
Message-ID: <1458646525-491-1-git-send-email-andy.yan@rock-chips.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org, john.stultz-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org
Cc: galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, catalin.marinas-5wv7dgnIgG8@public.gmane.org, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, alexandre.belloni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, jun.nie-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, f.fainelli-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, mbrugger-IBi9RG/b67k@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, moritz.fischer-+aYTwkv1SeIAvxtiuMwx3w@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, Andy Yan <andy.yan-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
List-Id: linux-pm@vger.kernel.org


This driver parse the reboot commands like "reboot loader"
and "reboot recovery" to get a boot mode described in the
device tree , then call the corresponding  write interfae
to store the boot mode in some place like special register
or ram , which can be read by the bootloader after system
reboot.

This is commonly done on Android based devices, in order to
reboot the device into fastboot or recovery mode.


Changes in v6:
- fix a typo with "property"
- describe property "mask" more clear

Changes in v5:
- delete a unnecessary blank line in syscon-reboot-mode.txt
- rename mode-fastoboot to mode-bootloader in syscon-reboot-mode.txt
- rename macro BOOT_LOADER to BOOT_BL_DOWNLOAD, which gives a more clear mean
- use two blank space under help in Kconfig
- use unsigned int instead of int for member magic in struct mode_info

Changes in v4:
- remove mode-maskrom
- rename mode-fastboot to mode-bootloader to keep compatible with the exiting Android device
- make this driver depends on OF to avoid kbuild test error

Changes in v3:
- descirbe all reboot mode as properity instead of subnode
- scan multi properities
- add mask value for some platform which only use some bits of the register
  to store boot mode magic value
- descirbe all reboot mode as property instead of subnode
- add rk3036 support
- descirbe all reboot mode as properity instead of subnode

Changes in v2:
- move to dir drivers/power/reset/
- make syscon-reboot-mode a generic driver
- make this node as a subnode of PMU
- make this node as a subnode of pmugrf

Changes in v1:
- fix the embarrassed compile warning
- correct the maskrom magic number
- check for the normal reboot
- correct the maskrom magic number
- use macro defined in rockchip_boot-mode.h for reboot-mode DT node

Andy Yan (4):
  dt-bindings: power: reset: add document for reboot-mode driver
  power: reset: add reboot mode driver
  ARM: dts: rockchip: add syscon-reboot-mode DT node
  ARM64: dts: rockchip: add syscon-reboot-mode DT node

 .../bindings/power/reset/reboot-mode.txt           |  24 +++++
 .../bindings/power/reset/syscon-reboot-mode.txt    |  35 +++++++
 arch/arm/boot/dts/rk3036.dtsi                      |  11 ++-
 arch/arm/boot/dts/rk3288.dtsi                      |  10 ++
 arch/arm/boot/dts/rk3xxx.dtsi                      |  12 ++-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi           |  12 ++-
 drivers/power/reset/Kconfig                        |  13 +++
 drivers/power/reset/Makefile                       |   2 +
 drivers/power/reset/reboot-mode.c                  | 106 +++++++++++++++++++++
 drivers/power/reset/reboot-mode.h                  |   6 ++
 drivers/power/reset/syscon-reboot-mode.c           |  65 +++++++++++++
 include/dt-bindings/soc/rockchip_boot-mode.h       |  15 +++
 12 files changed, 308 insertions(+), 3 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power/reset/reboot-mode.txt
 create mode 100644 Documentation/devicetree/bindings/power/reset/syscon-reboot-mode.txt
 create mode 100644 drivers/power/reset/reboot-mode.c
 create mode 100644 drivers/power/reset/reboot-mode.h
 create mode 100644 drivers/power/reset/syscon-reboot-mode.c
 create mode 100644 include/dt-bindings/soc/rockchip_boot-mode.h

-- 
1.9.1



--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
