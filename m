From: Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
Subject: [PATCH v4 00/13] add support for AXP813 ADC and battery
 power supply
Date: Mon, 19 Feb 2018 13:47:23 +0100
Message-ID: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
Reply-To: quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBB4PVPKAKGQEVFWP5OY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
Cc: knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, thomas.petazzoni-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org, Quentin Schulz <quentin.schulz-LDxbnhwyfcJBDgjK7y7TUQ@public.gmane.org>
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

I suggest patches:
  - 1,2,4,10,11,12 go through Maxime and Chen-Yu's tree,
  - 13 go through Jonathan's tree,
  - 3,5,9 go through Lee's tree,
  - 6,7,8 go through Sebastian's tree,

v4:
  - shortened one commit title as a workaround to Chen-Yu note,
  - added const to data structures as proposed by Chen-Yu,
  - added last patch for making sparse happy, on a proposal from Jonathan,
  - removed already applied patches (IIO ones),

v3:
  - merging dt-bindings patches for axp_adc as requested by Rob,
  - re-ordered constant in IIO driver as requested by Julian,
  - compatibles for ADC are now named after the first design that
  introduced the IP instead of wildcard as requested by Maxime,
  - renamed DT node name from axp-adc to adc as requested by Rob,
  - replaced enumeration of supported PMICs in battery power supply DT
  bindings documentation by "supported devices" as requested by Jonathan,
  - added a new patch for removing "axp-" from axp81x's pinctrl DT node,

v2:
  - introduce data structure instead of ID for variant specific code in
  battery driver,
  - add DT binding for ADC driver,
  - make mfd probe the ADC driver via DT as well so that its IIO channels
  can be consumed by other drivers via DT mapping,

Thanks,
Quentin

Quentin Schulz (13):
  ARM: dtsi: axp209: add node for ADC
  ARM: dtsi: axp22x: add node for ADC
  mfd: axp20x: make AXP209/22x cells probe their ADC via DT
  ARM: dtsi: axp81x: add node for ADC
  mfd: axp20x: probe axp20x_adc driver for AXP813
  power: supply: axp20x_battery: use data struct for variant specific code
  dt-bindings: power: supply: axp20x: add AXP813 battery DT binding
  power: supply: axp20x_battery: add support for AXP813
  mfd: axp20x: add battery power supply cell for AXP813
  ARM: dtsi: axp81x: add battery power supply subnode
  ARM: dtsi: sun8i: a711: enable battery power supply subnode
  ARM: dtsi: axp81x: remove IP name from DT node name
  iio: adc: axp20x_adc: remove !! in favor of ternary condition

 Documentation/devicetree/bindings/power/supply/axp20x_battery.txt |   8 ++--
 arch/arm/boot/dts/axp209.dtsi                                     |   5 +++-
 arch/arm/boot/dts/axp22x.dtsi                                     |   5 +++-
 arch/arm/boot/dts/axp81x.dtsi                                     |  12 +++++-
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts                         |   4 ++-
 drivers/iio/adc/axp20x_adc.c                                      |   8 ++--
 drivers/mfd/axp20x.c                                              |  13 +++++--
 drivers/power/supply/axp20x_battery.c                             | 134 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------------
 8 files changed, 149 insertions(+), 40 deletions(-)

base-commit: c4fb39f307d40fa088ebd39573f8d8d6c4388826
-- 
git-series 0.9.1
