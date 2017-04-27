From: Peter Chen <peter.chen@nxp.com>
Subject: RE: [PATCH] ARM: dts: imx6sx-sdb: Remove cpufreq OPP override
Date: Thu, 27 Apr 2017 01:17:12 +0000
Message-ID: <HE1PR04MB1450DA079FC35180FBE305388B100@HE1PR04MB1450.eurprd04.prod.outlook.com>
References: <89cc7192100bdc9ce546bf6000446e629457ebc1.1493138693.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-eopbgr00073.outbound.protection.outlook.com ([40.107.0.73]:39616
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754695AbdD0BRT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 26 Apr 2017 21:17:19 -0400
In-Reply-To: <89cc7192100bdc9ce546bf6000446e629457ebc1.1493138693.git.leonard.crestez@nxp.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Robin Gong <yibin.gong@nxp.com>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Anson Huang <anson.huang@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

=20
>
>The board file for imx6sx-dbg overrides cpufreq operating points to use hi=
gher
>voltages. This is done because the board has a shared rail for VDD_ARM_IN =
and
>VDD_SOC_IN and when using LDO bypass the shared voltage needs to be a valu=
e
>suitable for both ARM and SOC.
>
>This was introduced in:
>
>commit 54183bd7f766 ("ARM: imx6sx-sdb: add revb board and make it default"=
)
>
>This only only applies to LDO bypass mode, a feature not present in upstre=
am. When
>LDOs are enabled the effect is to use higher voltages than necesarry for n=
o good
>reason.
>
>Setting these higher voltages can make some boards fail to boot with ugly =
semi-
>random crashes, reminiscent of memory corruption. These failures happen th=
e first
>time the lowest idle state is used. Remove the OPP override in order to fi=
x those
>crashes.
>

Add Anson and Robin

This code has existed more than 2 years, it is strange why the bug has not =
reported both
for internal user and external user. I run upstream kernel using imx6sx-sdb=
 revB very often
at recent years, but not meet this issue. How to trigger this unstable issu=
e, anything needs
to change at u-boot?

Peter=20

>Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>
>
>---
>It's not clear exactly why the crashes happen. Perhaps waking up from idle=
 draws
>more power than is available? Removing this override is a correct change a=
nyway so
>maybe there is no need to investigate deeper.
>
> arch/arm/boot/dts/imx6sx-sdb.dts | 17 -----------------
> 1 file changed, 17 deletions(-)
>
>diff --git a/arch/arm/boot/dts/imx6sx-sdb.dts b/arch/arm/boot/dts/imx6sx-s=
db.dts
>index 5bb8fd5..d71da30 100644
>--- a/arch/arm/boot/dts/imx6sx-sdb.dts
>+++ b/arch/arm/boot/dts/imx6sx-sdb.dts
>@@ -12,23 +12,6 @@
> 	model =3D "Freescale i.MX6 SoloX SDB RevB Board";  };
>
>-&cpu0 {
>-	operating-points =3D <
>-		/* kHz    uV */
>-		996000  1250000
>-		792000  1175000
>-		396000  1175000
>-		198000  1175000
>-		>;
>-	fsl,soc-operating-points =3D <
>-		/* ARM kHz      SOC uV */
>-		996000	1250000
>-		792000	1175000
>-		396000	1175000
>-		198000  1175000
>-	>;
>-};
>-
> &i2c1 {
> 	clock-frequency =3D <100000>;
> 	pinctrl-names =3D "default";
>--
>2.7.4
