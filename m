From: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH v7 2/6] soc/fsl/guts: Add definition for LX2160A
Date: Mon, 29 Oct 2018 08:57:34 +0000
Message-ID: <1540759926-3641-3-git-send-email-vabhav.sharma@nxp.com>
References: <1540759926-3641-1-git-send-email-vabhav.sharma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1540759926-3641-1-git-send-email-vabhav.sharma@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "oss@buserror.net" <oss@buserror.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel-owner@vger.kernel.org
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Varun Sethi <V.Sethi@nxp.com>, Udit Kumar <udit.kumar@nxp.com>, Pankaj Bansal <pankaj.bansal@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>, Yinbo Zhu <yinbo.zhu@nxp.com>
List-Id: linux-pm@vger.kernel.org

Adding compatible string "lx2160a-dcfg" to
initialize guts driver for lx2160 and SoC die
attribute definition for LX2160A

Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Signed-off-by: Yinbo Zhu <yinbo.zhu@nxp.com>
Acked-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/soc/fsl/guts.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/fsl/guts.c b/drivers/soc/fsl/guts.c
index 302e0c8..bcab1ee 100644
--- a/drivers/soc/fsl/guts.c
+++ b/drivers/soc/fsl/guts.c
@@ -100,6 +100,11 @@ static const struct fsl_soc_die_attr fsl_soc_die[] =3D=
 {
 	  .svr		=3D 0x87000000,
 	  .mask		=3D 0xfff70000,
 	},
+	/* Die: LX2160A, SoC: LX2160A/LX2120A/LX2080A */
+	{ .die          =3D "LX2160A",
+	  .svr          =3D 0x87360000,
+	  .mask         =3D 0xff3f0000,
+	},
 	{ },
 };
=20
@@ -222,6 +227,7 @@ static const struct of_device_id fsl_guts_of_match[] =
=3D {
 	{ .compatible =3D "fsl,ls1088a-dcfg", },
 	{ .compatible =3D "fsl,ls1012a-dcfg", },
 	{ .compatible =3D "fsl,ls1046a-dcfg", },
+	{ .compatible =3D "fsl,lx2160a-dcfg", },
 	{}
 };
 MODULE_DEVICE_TABLE(of, fsl_guts_of_match);
--=20
2.7.4
