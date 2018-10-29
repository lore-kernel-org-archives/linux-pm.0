From: Poonam Aggrwal <poonam.aggrwal@nxp.com>
Subject: RE: [PATCH v7 2/6] soc/fsl/guts: Add definition for LX2160A
Date: Mon, 29 Oct 2018 11:09:24 +0000
Message-ID: <VI1PR04MB4976D4A33E0561D125BE837486F30@VI1PR04MB4976.eurprd04.prod.outlook.com>
References: <1540759926-3641-1-git-send-email-vabhav.sharma@nxp.com>
 <1540759926-3641-3-git-send-email-vabhav.sharma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540759926-3641-3-git-send-email-vabhav.sharma@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "oss@buserror.net" <oss@buserror.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.or>
Cc: "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Udit Kumar <udit.kumar@nxp.com>, Pankaj Bansal <pankaj.bansal@nxp.com>, "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, Varun Sethi <V.Sethi@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>, Yinbo Zhu <yinbo.zhu@nxp.com>
List-Id: linux-pm@vger.kernel.org



> -----Original Message-----
> From: linux-arm-kernel [mailto:linux-arm-kernel-bounces@lists.infradead.o=
rg]
> On Behalf Of Vabhav Sharma
> Sent: Monday, October 29, 2018 2:28 PM
> To: sudeep.holla@arm.com; oss@buserror.net; linux-kernel@vger.kernel.org;
> devicetree@vger.kernel.org; robh+dt@kernel.org; mark.rutland@arm.com;
> linuxppc-dev@lists.ozlabs.org; linux-arm-kernel@lists.infradead.org;
> mturquette@baylibre.com; sboyd@kernel.org; rjw@rjwysocki.net;
> viresh.kumar@linaro.org; linux-clk@vger.kernel.org; linux-pm@vger.kernel.=
org;
> linux-kernel-owner@vger.kernel.org; catalin.marinas@arm.com;
> will.deacon@arm.com; gregkh@linuxfoundation.org; arnd@arndb.de;
> kstewart@linuxfoundation.org; yamada.masahiro@socionext.com; Leo Li
> <leoyang.li@nxp.com>; shawnguo@kernel.org
> Cc: ulf.hansson@linaro.org; Udit Kumar <udit.kumar@nxp.com>; Pankaj Bansa=
l
> <pankaj.bansal@nxp.com>; linux@armlinux.org.uk; adrian.hunter@intel.com;
> Varun Sethi <V.Sethi@nxp.com>; Vabhav Sharma <vabhav.sharma@nxp.com>;
> Yinbo Zhu <yinbo.zhu@nxp.com>
> Subject: [PATCH v7 2/6] soc/fsl/guts: Add definition for LX2160A
>=20
> Adding compatible string "lx2160a-dcfg" to initialize guts driver for lx2=
160 and
> SoC die attribute definition for LX2160A
>=20
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
> Acked-by: Li Yang <leoyang.li@nxp.com>
> ---
>  drivers/soc/fsl/guts.c | 6 ++++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c index
> 302e0c8..bcab1ee 100644
> --- a/drivers/soc/fsl/guts.c
> +++ b/drivers/soc/fsl/guts.c
> @@ -100,6 +100,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] =
=3D {
>  	  .svr		=3D 0x87000000,
>  	  .mask		=3D 0xfff70000,
>  	},
> +	/* Die: LX2160A, SoC: LX2160A/LX2120A/LX2080A */
> +	{ .die          =3D "LX2160A",
> +	  .svr          =3D 0x87360000,
Do all  the threevariants " LX2160A/LX2120A/LX2080A"  have same SVR?
> +	  .mask         =3D 0xff3f0000,
> +	},
>  	{ },
>  };
>=20
> @@ -222,6 +227,7 @@ static const struct of_device_id fsl_guts_of_match[] =
=3D {
>  	{ .compatible =3D "fsl,ls1088a-dcfg", },
>  	{ .compatible =3D "fsl,ls1012a-dcfg", },
>  	{ .compatible =3D "fsl,ls1046a-dcfg", },
> +	{ .compatible =3D "fsl,lx2160a-dcfg", },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
> --
> 2.7.4
>=20
>=20
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> https://emea01.safelinks.protection.outlook.com/?url=3Dhttp%3A%2F%2Flists=
.infr
> adead.org%2Fmailman%2Flistinfo%2Flinux-arm-
> kernel&amp;data=3D02%7C01%7Cpoonam.aggrwal%40nxp.com%7Cd9b7c36c786
> 54cd6dc4008d63d7fee63%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0
> %7C636764017001504288&amp;sdata=3DpqFMlw6yVrHrvn4YRhqj%2FmoOnSscrZu
> tcoYn3In8OJc%3D&amp;reserved=3D0
