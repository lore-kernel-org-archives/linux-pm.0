From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH 0/8] add support for AXP813 ADC and battery power supply
Date: Mon,  4 Dec 2017 15:12:46 +0100
Message-ID: <cover.4052f8c517c42db26a3cabe078cad333243d371c.1512396054.git-series.quentin.schulz@free-electrons.com>
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, icenowy-h8G6r0blFSE@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

The AXP813 PMIC is relatively close to the already supported AXP20X and
AXP22X. It provides three different power outputs: battery, AC and USB, and
measures a few different things: temperature, power supply status, current
current and voltage supplied, maximum current limit, battery capacity, min
and max voltage limits.

One of its two GPIOs can be used as an ADC.

There are a few differences with AXP20X/AXP22X PMICs though:
  - a different constant charge current formula,
  - battery temperature, GPIO0 and battery voltages are the only voltages
  measurable,
  - all data are stored on 12 bits (AXP20X/AXP22X had one type of data that
  was stored on 13 bits),
  - different scales and offsets,
  - a different ADC rate formula and register,

This patch series adds support for the PMIC's ADC and battery power supply
in the existing drivers.

Make the axp20x MFD automatically probe the ADC driver, add the battery
power supply node in axp81x node and enable it for the TBS A711 since it
has a soldered battery.

Q: The BananaPi M3 has two solder balls for battery, should the battery
power supply node be enabled for this board as well?

Thanks,
Quentin

Quentin Schulz (8):
  iio: adc: axp20x_adc: put ADC rate setting in a per-variant function
  iio: adc: axp20x_adc: add support for AXP813 ADC
  mfd: axp20x: probe axp20x_adc driver for AXP813
  dt-bindings: power: supply: axp20x: add AXP813 battery DT binding
  power: supply: axp20x_battery: add support for AXP813
  mfd: axp20x: add battery power supply cell for AXP813
  ARM: dtsi: axp81x: add battery power supply subnode
  ARM: dtsi: sun8i: a711: enable battery power supply subnode

 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt |   8 ++--
 arch/arm/boot/dts/axp81x.dtsi                                     |   5 +++-
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts                         |   4 ++-
 drivers/iio/adc/axp20x_adc.c                                      | 139 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 drivers/mfd/axp20x.c                                              |   7 +++-
 drivers/power/supply/axp20x_battery.c                             |  44 ++++++++++++++++++++++-
 include/linux/mfd/axp20x.h                                        |   2 +-
 7 files changed, 196 insertions(+), 13 deletions(-)

base-commit: 7cc61a0a562c7005d2a34f97e94cf26689a2f57c
-- 
git-series 0.9.1
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
