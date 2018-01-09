From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [PATCH v2 00/16] add support for AXP813 ADC and battery
 power supply
Date: Tue,  9 Jan 2018 10:33:31 +0100
Message-ID: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
Reply-To: quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBREZ2LJAKGQEGX24VLI-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org
Cc: linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
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

v2:
  - introduce data structure instead of ID for variant specific code in
  battery driver,
  - add DT binding for ADC driver,
  - make mfd probe the ADC driver via DT as well so that its IIO channels
  can be consumed by other drivers via DT mapping,

Thanks,
Quentin

Quentin Schulz (16):
  iio: adc: axp20x_adc: put ADC rate setting in a per-variant function
  dt-bindings: iio: adc: add binding for X-Powers AXP PMICs ADC
  iio: adc: axp20x_adc: make it possible to probe from DT
  ARM: dtsi: axp209: add node for ADC
  ARM: dtsi: axp22x: add node for ADC
  mfd: axp20x: make AXP209/22x cells probe their ADC via DT
  dt-bindings: iio: adc: axp20x_adc: add AXP813 variant
  iio: adc: axp20x_adc: add support for AXP813 ADC
  ARM: dtsi: axp81x: add node for ADC
  mfd: axp20x: probe axp20x_adc driver for AXP813
  power: supply: axp20x_battery: use data structure instead of ID for variant specific code
  dt-bindings: power: supply: axp20x: add AXP813 battery DT binding
  power: supply: axp20x_battery: add support for AXP813
  mfd: axp20x: add battery power supply cell for AXP813
  ARM: dtsi: axp81x: add battery power supply subnode
  ARM: dtsi: sun8i: a711: enable battery power supply subnode

 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt          |  48 ++++++++++++++++++++++-
 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt |   8 ++--
 arch/arm/boot/dts/axp209.dtsi                                     |   5 ++-
 arch/arm/boot/dts/axp22x.dtsi                                     |   5 ++-
 arch/arm/boot/dts/axp81x.dtsi                                     |  10 +++++-
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts                         |   4 ++-
 drivers/iio/adc/axp20x_adc.c                                      | 160 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++----
 drivers/mfd/axp20x.c                                              |  13 +++++-
 drivers/power/supply/axp20x_battery.c                             | 134 ++++++++++++++++++++++++++++++++++++++++++++++--------------
 include/linux/mfd/axp20x.h                                        |   2 +-
 10 files changed, 345 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/axp20x_adc.txt

base-commit: 895c0dde398510a5b5ded60e5064c11b94bd30ca
-- 
git-series 0.9.1
