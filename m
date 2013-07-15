From: Sudeep.KarkadaNagesha@arm.com
Subject: [RFC PATCH 06/11] cpufreq: imx6q-cpufreq: remove device tree parsing for cpu nodes
Date: Mon, 15 Jul 2013 11:22:07 +0100
Message-ID: <1373883732-26303-7-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1373883732-26303-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1373883732-26303-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: cpufreq@vger.kernel.org, arnd@arndb.de, olof@lixom.net, lorenzo.pieralisi@arm.com, rob.herring@calxeda.com, grant.likely@linaro.org, rjw@sisk.pl, viresh.kumar@linaro.org, gregkh@linuxfoundation.org, gregory.clement@free-electrons.com, kernel@pengutronix.de, shawn.guo@linaro.org, linux@arm.linux.org.uk, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes all DT parsing and uses cpu->of_node instead.

Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 arch/arm/mach-imx/mach-imx6q.c  | 3 +--
 drivers/cpufreq/imx6q-cpufreq.c | 4 +---
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.=
c
index 7be13f8..a02f275 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -254,13 +254,12 @@ static void __init imx6q_opp_init(struct device *cpu_=
dev)
 {
 =09struct device_node *np;
=20
-=09np =3D of_find_node_by_path("/cpus/cpu@0");
+=09np =3D of_node_get(cpu_dev->of_node);
 =09if (!np) {
 =09=09pr_warn("failed to find cpu0 node\n");
 =09=09return;
 =09}
=20
-=09cpu_dev->of_node =3D np;
 =09if (of_init_opp_table(cpu_dev)) {
 =09=09pr_warn("failed to init OPP table\n");
 =09=09goto put_node;
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufre=
q.c
index e37cdae..b16632b 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -221,14 +221,12 @@ static int imx6q_cpufreq_probe(struct platform_device=
 *pdev)
=20
 =09cpu_dev =3D &pdev->dev;
=20
-=09np =3D of_find_node_by_path("/cpus/cpu@0");
+=09np =3D of_node_get(cpu_dev->of_node);
 =09if (!np) {
 =09=09dev_err(cpu_dev, "failed to find cpu0 node\n");
 =09=09return -ENOENT;
 =09}
=20
-=09cpu_dev->of_node =3D np;
-
 =09arm_clk =3D devm_clk_get(cpu_dev, "arm");
 =09pll1_sys_clk =3D devm_clk_get(cpu_dev, "pll1_sys");
 =09pll1_sw_clk =3D devm_clk_get(cpu_dev, "pll1_sw");
--=20
1.8.1.2
