From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 0/4] set battery info on AXP20X and AXP22X from DT
Date: Thu, 11 May 2017 15:42:16 +0200
Message-ID: <20170511134221.5569-1-quentin.schulz@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org
Cc: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

X-Powers AXP20X and AXP22X are capable of setting battery constant
charge current to limit the current supplied to the battery. The battery
driver already offers the ability to modify the constant charge current
via sysfs but the driver will probe with the default value of 1500mA.

They are also able to tell the system when to shut down due to the
supplied power being too low. This patch series adds the ability to set
this power threshold from the battery DT node.

The constant charge current is critical for batteries as if it is higher
than the supported constant charge current, it might
severly/irreversibly damages or kills the battery.

This patch series aims at offering the ability to set the maximal
supported constant charge current from Device Tree which will be used at
driver probing to set the default constant charge current, thus making
sure we stay out of the unsupported range as little time as possible
(the default constant current charge will still be 1500mA from powering
up the board to the driver probing unless the bootloader takes care of
it beforehand).

We still offer the user the ability to change the maximal constant
charge current from sysfs for those who would like to switch the battery
attached to their board, so they can set an appropriate constant current
charge and take advantage of higher constant current charge.

Quentin

Quentin Schulz (4):
  power: supply: axp20x_battery: add support for DT battery
  dt-bindings: power: battery: add constant-charge-current-max-microamp
    property
  power: supply: power_supply_core: add constant-charge-current optional
    property
  power: supply: axp20x_battery: add DT support for battery max constant
    charge current

 .../devicetree/bindings/power/supply/battery.txt   |  2 +
 drivers/power/supply/axp20x_battery.c              | 88 ++++++++++++++++++++--
 drivers/power/supply/power_supply_core.c           |  3 +
 include/linux/power_supply.h                       |  1 +
 4 files changed, 86 insertions(+), 8 deletions(-)

-- 
2.11.0

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
