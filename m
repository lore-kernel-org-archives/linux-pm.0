From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [PATCH 2/4] cpufreq: imx6q-cpufreq: assign cpu_dev correctly to cpu0 device
Date: Tue, 10 Sep 2013 18:59:47 +0100
Message-ID: <1378835989-19281-3-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1378835989-19281-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: Shawn Guo <shawn.guo@linaro.org>, Guennadi Liakhovetski <g.liakhovetski@gmx.de>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Sudeep.KarkadaNagesha@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, linux-arm-kernel@lists.infradead.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Commit cdc58d602d2e657602a90c190cbf745886c95977 "cpufreq: imx6q-cpufreq:
remove device tree parsing for cpu nodes" assumed the pdev->dev is set to
cpu0 device in the platform code. But it actually points to the virtual
cpufreq-cpu0 platform device which is not present in the device tree.
Most of the information needed by cpufreq is stored in cpu0 DT node.
So cpu_dev must point to cpu0 device.

This patch fixes the wrong assignment to cpu_dev.

Reported-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Shawn Guo <shawn.guo@linaro.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 arch/arm/mach-imx/mach-imx6q.c  | 9 +++++++--
 drivers/cpufreq/imx6q-cpufreq.c | 7 ++++++-
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-imx/mach-imx6q.c b/arch/arm/mach-imx/mach-imx6q.=
c
index 85a1b51..90372a2 100644
--- a/arch/arm/mach-imx/mach-imx6q.c
+++ b/arch/arm/mach-imx/mach-imx6q.c
@@ -233,10 +233,15 @@ put_node:
 =09of_node_put(np);
 }
=20
-static void __init imx6q_opp_init(struct device *cpu_dev)
+static void __init imx6q_opp_init(void)
 {
 =09struct device_node *np;
+=09struct device *cpu_dev =3D get_cpu_device(0);
=20
+=09if (!cpu_dev) {
+=09=09pr_warn("failed to get cpu0 device\n");
+=09=09return;
+=09}
 =09np =3D of_node_get(cpu_dev->of_node);
 =09if (!np) {
 =09=09pr_warn("failed to find cpu0 node\n");
@@ -268,7 +273,7 @@ static void __init imx6q_init_late(void)
 =09=09imx6q_cpuidle_init();
=20
 =09if (IS_ENABLED(CONFIG_ARM_IMX6Q_CPUFREQ)) {
-=09=09imx6q_opp_init(&imx6q_cpufreq_pdev.dev);
+=09=09imx6q_opp_init();
 =09=09platform_device_register(&imx6q_cpufreq_pdev);
 =09}
 }
diff --git a/drivers/cpufreq/imx6q-cpufreq.c b/drivers/cpufreq/imx6q-cpufre=
q.c
index 3e39654..c3fd2a1 100644
--- a/drivers/cpufreq/imx6q-cpufreq.c
+++ b/drivers/cpufreq/imx6q-cpufreq.c
@@ -7,6 +7,7 @@
  */
=20
 #include <linux/clk.h>
+#include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/delay.h>
 #include <linux/err.h>
@@ -202,7 +203,11 @@ static int imx6q_cpufreq_probe(struct platform_device =
*pdev)
 =09unsigned long min_volt, max_volt;
 =09int num, ret;
=20
-=09cpu_dev =3D &pdev->dev;
+=09cpu_dev =3D get_cpu_device(0);
+=09if (!cpu_dev) {
+=09=09pr_err("failed to get cpu0 device\n");
+=09=09return -ENODEV;
+=09}
=20
 =09np =3D of_node_get(cpu_dev->of_node);
 =09if (!np) {
--=20
1.8.1.2


