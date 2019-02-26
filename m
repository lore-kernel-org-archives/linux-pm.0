From: Vabhav Sharma <vabhav.sharma@nxp.com>
Subject: [PATCH 4/4] clk: qoriq: Add clockgen support for lx2160a
Date: Tue, 26 Feb 2019 08:34:46 +0000
Message-ID: <1551126463-5341-5-git-send-email-vabhav.sharma@nxp.com>
References: <1551126463-5341-1-git-send-email-vabhav.sharma@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1551126463-5341-1-git-send-email-vabhav.sharma@nxp.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "sudeep.holla@arm.com" <sudeep.holla@arm.com>, "oss@buserror.net" <oss@buserror.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "robh+dt@kernel.org" <robh+dt@kernel.org>, "mark.rutland@arm.com" <mark.rutland@arm.com>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "mturquette@baylibre.com" <mturquette@baylibre.com>, "sboyd@kernel.org" <sboyd@kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "viresh.kumar@linaro.org" <viresh.kumar@linaro.org>, "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, linux-kernel-owner@vger.kernel.org
Cc: "linux@armlinux.org.uk" <linux@armlinux.org.uk>, "adrian.hunter@intel.com" <adrian.hunter@intel.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, Yogesh Narayan Gaur <yogeshnarayan.gaur@nxp.com>, Andy Tang <andy.tang@nxp.com>, Vabhav Sharma <vabhav.sharma@nxp.com>
List-Id: linux-pm@vger.kernel.org

From: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>

Add clockgen support for lx2160a.
Added entry for compat 'fsl,lx2160a-clockgen'.

Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
Signed-off-by: Yogesh Gaur <yogeshnarayan.gaur@nxp.com>
Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
Acked-by: Stephen Boyd <sboyd@kernel.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/clk/clk-qoriq.c         | 12 ++++++++++++
 drivers/cpufreq/qoriq-cpufreq.c |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/clk/clk-qoriq.c b/drivers/clk/clk-qoriq.c
index e75194a..cfd14ef 100644
--- a/drivers/clk/clk-qoriq.c
+++ b/drivers/clk/clk-qoriq.c
@@ -570,6 +570,17 @@ static const struct clockgen_chipinfo chipinfo[] =3D {
 		.flags =3D CG_VER3 | CG_LITTLE_ENDIAN,
 	},
 	{
+		.compat =3D "fsl,lx2160a-clockgen",
+		.cmux_groups =3D {
+			&clockgen2_cmux_cga12, &clockgen2_cmux_cgb
+		},
+		.cmux_to_group =3D {
+			0, 0, 0, 0, 1, 1, 1, 1, -1
+		},
+		.pll_mask =3D 0x37,
+		.flags =3D CG_VER3 | CG_LITTLE_ENDIAN,
+	},
+	{
 		.compat =3D "fsl,p2041-clockgen",
 		.guts_compat =3D "fsl,qoriq-device-config-1.0",
 		.init_periph =3D p2041_init_periph,
@@ -1435,6 +1446,7 @@ CLK_OF_DECLARE(qoriq_clockgen_t1023, "fsl,t1023-clock=
gen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_t1040, "fsl,t1040-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_t2080, "fsl,t2080-clockgen", clockgen_init);
 CLK_OF_DECLARE(qoriq_clockgen_t4240, "fsl,t4240-clockgen", clockgen_init);
+CLK_OF_DECLARE(qoriq_clockgen_lx2160a, "fsl,lx2160a-clockgen", clockgen_in=
it);
=20
 /* Legacy nodes */
 CLK_OF_DECLARE(qoriq_sysclk_1, "fsl,qoriq-sysclk-1.0", sysclk_init);
diff --git a/drivers/cpufreq/qoriq-cpufreq.c b/drivers/cpufreq/qoriq-cpufre=
q.c
index 3d773f6..83921b7 100644
--- a/drivers/cpufreq/qoriq-cpufreq.c
+++ b/drivers/cpufreq/qoriq-cpufreq.c
@@ -295,6 +295,7 @@ static const struct of_device_id node_matches[] __initc=
onst =3D {
 	{ .compatible =3D "fsl,ls1046a-clockgen", },
 	{ .compatible =3D "fsl,ls1088a-clockgen", },
 	{ .compatible =3D "fsl,ls2080a-clockgen", },
+	{ .compatible =3D "fsl,lx2160a-clockgen", },
 	{ .compatible =3D "fsl,p4080-clockgen", },
 	{ .compatible =3D "fsl,qoriq-clockgen-1.0", },
 	{ .compatible =3D "fsl,qoriq-clockgen-2.0", },
--=20
2.7.4
