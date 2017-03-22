From: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>
Subject: [RFC 0/8] ARM: imx: Upstream fsl,ldo-bypass
Date: Wed, 22 Mar 2017 18:53:02 +0200
Message-ID: <cover.1490199005.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Liam Girdwood <lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Shawn Guo <shawnguo-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
Cc: Leonard Crestez <leonard.crestez-3arQi8VN3Tc@public.gmane.org>, Robin Gong <yibin.gong-3arQi8VN3Tc@public.gmane.org>, Anson Huang <Anson.Huang-3arQi8VN3Tc@public.gmane.org>, Irina Tirdea <irina.tirdea-3arQi8VN3Tc@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Fabio Estevam <fabio.estevam-3arQi8VN3Tc@public.gmane.org>, Octavian Purdila <octavian.purdila-3arQi8VN3Tc@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Freescale imx socs have three built-in regulators LDO_ARM LDO_SOC and LDO_PU
used to control internal chip voltages. "ldo-bypass" mode refers to placing
these regulators in bypass mode and controlling voltages from an external power
management chip instead. The intention is to save power (at the expense of an
extra PMIC on the board).

Looking through commit messages and emails it seems that there are other users
of unusual power configurations for imx but there doesn't appear to be any
board dts file using this mode. This is an attempt to upstream this feature
based on how the freescale BSP does it. This series only enables it for the
imx6qdl-sabresd boards for simplicity.

Versions of u-boot shipped by freescale for imx partially handle this in the
bootloader. His patch series tries to detect if the bootloader did this and
takes advantage of it but it is not required. This series works fine with
upstream u-boot. The binding is odd because it's shared with those versions of
uboot.

The LDO regulators have a minimum dropout of 125mv and this is removed when
bypass mode is entered. This results in a brief increase in voltage. The bypass
code sets the minimum frequency before enabling LDO bypass to avoid
overvolting. Some new checks are added in the regulator core to check for this
(patch 4) and the checks would trigger without lowering the frequency.

Issues that need to be discussed:

* I'm not happy with the regulator_allow_bypass API. It claims to "allow the
regulator to go into bypass mode if all other consumers for the regulator also
enable bypass mode" but it doesn't seem to properly handle the case when
additional consumers show up after bypass mode is enabled. It's not even clear
how it should be done, should regulator_get on a bypassed regulator disable
bypass mode?

There are only 2 other users of this and they don't seem to use multiple
consumers. For imx the gpc driver is a secondary consumer for vddpu so this
needs to be handled somehow. There is a hack in patch 7 which forces gpc to
always probe after cpufreq and rely on it to perform the bypass procedure.

Having both gpc and cpufreq call regulator_allow_bypass would sort of work but
it would be ugly. If gpc probes first it would attempt bypass and get an error
(because of the supply voltage check), bypass would later be performed
successfully by cpufreq.

I think it would be better to have an imperative regulator_set_bypass API. I
think it might even be reasonable for it to completely replace the current
regulator_allow_bypass API.

It would also make the code a lot simpler, there would no longer be a need to
check regulator_is_bypass after regulator_allow_bypass.

* There is an anatop patch which dynamically modifies regulator_desc to
zero-out "min_dropout_uV" in bypass mode, despite the fact that documentation
claims that regulator_desc should be read-only. Perhaps the core should handle
this or this should be replaced with a function in regulator_ops?

Irina Tirdea (2):
  cpufreq: imx6q: Fix handling EPROBE_DEFER from regulator
  regulator: anatop: fix min dropout for bypass mode

Leonard Crestez (6):
  ARM: imx: gpc: Do not print error message for EPROBE_DEFER
  cpufreq: imx6q: Set max suspend_freq to avoid changes during suspend
  regulator: core: Check enabling bypass respects constraints
  regulator: core: Add regulator_is_bypass function
  cpufreq: imx6q: Initialize LDO bypass
  ARM: dts: imx6qdl-sabresd: Enable fsl,ldo-bypass

 .../devicetree/bindings/power/fsl,imx-gpc.txt      |   4 +
 arch/arm/boot/dts/imx6dl-sabresd-ldo.dts           |  13 ++
 arch/arm/boot/dts/imx6q-sabresd-ldo.dts            |  13 ++
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi             |  19 +++
 arch/arm/boot/dts/imx6qdl.dtsi                     |   6 +-
 arch/arm/boot/dts/imx6qp-sabresd-ldo.dts           |  13 ++
 arch/arm/boot/dts/imx6qp-sabresd.dts               |   4 +-
 arch/arm/mach-imx/gpc.c                            |  13 +-
 drivers/cpufreq/imx6q-cpufreq.c                    | 180 +++++++++++++++++++++
 drivers/regulator/anatop-regulator.c               |   9 +-
 drivers/regulator/core.c                           |  78 ++++++++-
 include/linux/regulator/consumer.h                 |   1 +
 12 files changed, 344 insertions(+), 9 deletions(-)
 create mode 100644 arch/arm/boot/dts/imx6dl-sabresd-ldo.dts
 create mode 100644 arch/arm/boot/dts/imx6q-sabresd-ldo.dts
 create mode 100644 arch/arm/boot/dts/imx6qp-sabresd-ldo.dts

-- 
2.7.4

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
