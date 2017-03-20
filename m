From: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: [RESEND PATCH v4 0/9] add support for AXP20X and AXP22X
 power supply drivers
Date: Mon, 20 Mar 2017 09:16:44 +0100
Message-ID: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
Reply-To: quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-sunxi+bncBCLZXSNY5IDBBCVAX3DAKGQEW7OCE2I-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, wens-jdAy2FN1RRM@public.gmane.org, linux-I+IVW8TIWO2tmTQ+vhA3Yw@public.gmane.org, maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, jic23-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, knaack.h-Mmb7MZpHnFY@public.gmane.org, lars-Qo5EllUWu/uELgA04lAiVw@public.gmane.org, pmeerw-jW+XmwGofnusTnJN9+BGXg@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, icenowy-ymACFijhrKM@public.gmane.org
Cc: Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, liam-RYWXG+zxWwBdeoIcmNTgJF6hYfS7NtTn@public.gmane.org, thomas.petazzoni-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-iio-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org

These patches haven't changed since v4. The goal is to split the series in
two series, one (this one) with patches ready to be merged and the other
one (everything impacting the battery power supply) which depends on an
ongoing series by Liam Breck to be merged once the ongoing series has a
consensus.

Therefore, this series of patch is ready to be merged. I don't see any
dependency between subsystems.

Thanks,
Quentin

Quote from v4 cover letter:

The X-Powers AXP20X and AXP22X PMICs have multiple ADCs. They expose
information and data of the various power supplies they support such as
ACIN, battery and VBUS. For example, they expose the current battery
voltage, charge or discharge, as well as ACIN and VBUS current voltages
and currents, internal PMIC temperature and ADC on 2 different GPIOs
when in the right mode (for the AXP209 only).

The ACIN power supply driver is added by this patch. The AXP20X and
AXP22X can both read the status and the "usability" of the power supply
but only the AXP209 will be able to tell the current current and voltage
of the power supply by reading ADC channels. It is simply not supported
by the AXP22X PMICs.

The battery power supply driver is also added by this patch. The AXP20X
and AXP22X share most of their behaviour but have slight variations. The
allowed target voltages for battery charging are not the same, the
AXP22X PMIC are able to tell if the battery percentage computed by the
PMIC is trustworthy and they have different formulas for computing max
current for battery power supply. The driver is able to give the current
voltage and current of the battery (be it charging or discharging), the
maximal and minimal voltage and maximal current allowed for the battery,
whether the battery is present and usable and its capacity. It will get
the battery current current and voltage by reading the ADC channels. The
PMIC allows maximal voltages (4.36V for AXP20X and 4.22V and 4.24V for
AXP22X) that should not be used with Lithium-based batteries and since
this PMIC is supposed to be used with Lithium-based batteries, they have
been disabled. The values returned by the ADC driver are multipled by
1000 to scale from the mV returned by the ADC to the uV expected by the
power supply framework.

This series of patch adds DT bindings for ACIN power supply, ADC and
battery power supply drivers for AXP20X and AXP22X PMICs and their
documentation. It also enables the supported power supplies for the
Nextthing Co. CHIP and Sinlinx SinA33 boards.

The different drivers are also added to the MFD cells of the AXP20X and
AXP22X cells and the writeable and volatile regs updated to work with
the newly added drivers.

This series of patch is based on a previous upstreaming attempt done by
Bruno Pr=C3=A9mont few months ago. It differs in three points: the ADC
driver does not tell the battery temperature (TS_IN) as I do not have a
board to test it with, it does not tell the instantaneous battery power
as it returns crazy values for me and finally no support for OCV curves
for the battery.

You can test these patches from this repo and branch:
https://github.com/QSchulz/linux/tree/axp2xx_adc_batt_ac_v4

v4:
 - added the ability to set maximum constant charge current from sysfs,
 - added a warning when setting a higher than current maximum constant char=
ge
 current,
 - set default to minimum possible value for current and maximum constant c=
harge
 current when no battery DT is present or invalid battery DT,
 - fixed a forgotten custom formula to compute maximum constant charge curr=
ent
 for AXP22X,
 - automatically lower the current constant charge current when it is highe=
r
 than the maximum constant charge current about to be set,

v3:
 - Removed DT property for constant charge current in favor of the WIP
 battery framework as requested by Sebastian Reichel,
 - Using a simple if condition instead of a switch in the ADC driver,
 - Fixed error handling in ADC driver's probe,
 - Fixed missing call to iio_map_array_unregister in the ADC driver's
 remove,
 - Removed ADC driver's DT node and documentation,
 - Merged IIO channel mapping patches into the original ADC driver
 patch,
 - Removed `adding V-OFF to writeable reg' patch as it's already in
 writeable reg range,

v2:
 - Some registers' name have been changed to better reflect their
 purpose,
 - Make VBUS power supply driver use IIO channels when AXP ADC driver is
 enabled, but fall back on previous behavior when disabled. This is made
 to avoid the ADC driver overwritting registers for VBUS power supply
 ADC when removed,
 - Removed useless adding of data registers to volatile registers,
 - Reordered IIO channels, now grouped by same part of the PMIC (e.g.
 voltage and current of the battery have the same index in different
 IIO types),
 - Added structures for specific data instead of matching on IDs,
 - Switched from DT IIO channels mapping to iio_map structures IIO
 channels mapping,

Quentin

Quentin Schulz (9):
  mfd: axp20x: correct name of temperature data ADC registers
  iio: adc: add support for X-Powers AXP20X and AXP22X PMICs ADCs
  mfd: axp20x: add ADC cells for AXP20X and AXP22X PMICs
  mfd: axp20x: add AC power supply cells for AXP22X PMICs
  ARM: dtsi: axp209: add AC power supply subnode
  ARM: dtsi: axp22x: add AC power supply subnode
  ARM: dts: sun8i: sina33: enable ACIN power supply subnode
  ARM: sun5i: chip: enable ACIN power supply subnode
  mfd: axp20x: add CHRG_CTRL1/2/3 to writeable regs for AXP20X/AXP22X

 arch/arm/boot/dts/axp209.dtsi                  |   5 +
 arch/arm/boot/dts/axp22x.dtsi                  |   5 +
 arch/arm/boot/dts/sun5i-r8-chip.dts            |   4 +
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts |   4 +
 drivers/iio/adc/Kconfig                        |  10 +
 drivers/iio/adc/Makefile                       |   1 +
 drivers/iio/adc/axp20x_adc.c                   | 617 +++++++++++++++++++++=
++++
 drivers/mfd/axp20x.c                           |  20 +-
 include/linux/mfd/axp20x.h                     |   4 +-
 9 files changed, 667 insertions(+), 3 deletions(-)
 create mode 100644 drivers/iio/adc/axp20x_adc.c

--=20
2.9.3

--=20
You received this message because you are subscribed to the Google Groups "=
linux-sunxi" group.
To unsubscribe from this group and stop receiving emails from it, send an e=
mail to linux-sunxi+unsubscribe-/JYPxA39Uh5TLH3MbocFF+G/Ez6ZCGd0@public.gmane.org
For more options, visit https://groups.google.com/d/optout.
