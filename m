From: "A.S. Dong" <aisheng.dong@nxp.com>
Subject: RE: [PATCH] ARM: imx_v6_v7_defconfig: Enable cpufreq governors
Date: Wed, 3 May 2017 03:48:03 +0000
Message-ID: <AM3PR04MB306B60CED1751FA382AFBB980160@AM3PR04MB306.eurprd04.prod.outlook.com>
References: <c401883fec8db20878c7593d879e9e128cacc495.1493736306.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve1eur01on0073.outbound.protection.outlook.com ([104.47.1.73]:5760
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751272AbdECDsH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 2 May 2017 23:48:07 -0400
In-Reply-To: <c401883fec8db20878c7593d879e9e128cacc495.1493736306.git.leonard.crestez@nxp.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shawn Guo <shawnguo@kernel.org>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Sascha Hauer <kernel@pengutronix.de>, Jagan Teki <jagan@amarulasolutions.com>, Fabio Estevam <fabio.estevam@nxp.com>, Dong Aisheng <aisheng.dong@freescale.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

> -----Original Message-----
> From: Leonard Crestez [mailto:leonard.crestez@nxp.com]
> Sent: Tuesday, May 02, 2017 10:46 PM
> To: Shawn Guo
> Cc: Leonard Crestez; Sascha Hauer; Jagan Teki; Fabio Estevam; Dong Aishen=
g;
> linux-arm-kernel@lists.infradead.org; linux-pm@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: [PATCH] ARM: imx_v6_v7_defconfig: Enable cpufreq governors
>=20
> Enable more common cpufreq governors in imx defconfig because this is ver=
y
> useful for testing. In particular you can't use cpufreq-set -f $FREQ
> without explicitly defining CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy.
>=20
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Well, I think we do need this.
So:
Acked-by: Dong Aisheng <aisheng.dong@nxp.com>

Regards
Dong Aisheng

>=20
> ---
>=20
> It might make sense for all governors to be enabled by default from
> drivers/cpufreq/Kconfig and allow defconfigs to be shorter.
> Right now the descriptions for some of them includes a line that says "If
> in doubt, say Y" but the config options don't have actually have a defaul=
t
> value defined and they effectively default to N.
>=20
> Cycling via savedefconfig on shawnguo/for-next also generates some
> reordering for some newly added options CONFIG_TOUCHSCREEN_MAX11801=3Dy a=
nd
> CONFIG_HID_MULTITOUCH=3Dy. Those were not included but it's strange that
> this happens. Maybe those options were inserted manually, or otherwise
> there is an annoying bug in kconfig?
>=20
>  arch/arm/configs/imx_v6_v7_defconfig | 3 +++
>  1 file changed, 3 insertions(+)
>=20
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig
> b/arch/arm/configs/imx_v6_v7_defconfig
> index bb6fa56..bf1e7e3 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -55,6 +55,9 @@ CONFIG_CMDLINE=3D"noinitrd console=3Dttymxc0,115200"
>  CONFIG_KEXEC=3Dy
>  CONFIG_CPU_FREQ=3Dy
>  CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND=3Dy
> +CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
> +CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
> +CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy
>  CONFIG_ARM_IMX6Q_CPUFREQ=3Dy
>  CONFIG_CPU_IDLE=3Dy
>  CONFIG_VFP=3Dy
> --
> 2.7.4
