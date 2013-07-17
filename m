From: Sudeep.KarkadaNagesha@arm.com
Subject: [RFC PATCH v2 11/15] cpufreq: kirkwood-cpufreq: remove device tree parsing for cpu nodes
Date: Wed, 17 Jul 2013 15:06:20 +0100
Message-ID: <1374069984-20567-12-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Russell King <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Andrew Lunn <andrew@lunn.ch>, Jason Cooper <jason@lakedaemon.net>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes all DT parsing and uses cpu->of_node instead.

Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Jason Cooper <jason@lakedaemon.net>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/kirkwood-cpufreq.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-=
cpufreq.c
index c233ea6..18aa3eb 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -13,6 +13,7 @@
 #include <linux/module.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
@@ -165,6 +166,7 @@ static struct cpufreq_driver kirkwood_cpufreq_driver =
=3D {
 static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 {
 =09struct device_node *np;
+=09struct device *cpu_dev;
 =09struct resource *res;
 =09int err;
=20
@@ -175,9 +177,17 @@ static int kirkwood_cpufreq_probe(struct platform_devi=
ce *pdev)
 =09if (IS_ERR(priv.base))
 =09=09return PTR_ERR(priv.base);
=20
-=09np =3D of_find_node_by_path("/cpus/cpu@0");
-=09if (!np)
+=09cpu_dev =3D get_cpu_device(0);
+=09if (!cpu_dev) {
+=09=09dev_err(&pdev->dev, "failed to get cpu device\n");
 =09=09return -ENODEV;
+=09}
+
+=09np =3D of_node_get(cpu_dev->of_node);
+=09if (!np) {
+=09=09dev_err(&pdev->dev, "failed to get cpu device node\n");
+=09=09return -ENODEV;
+=09}
=20
 =09priv.cpu_clk =3D of_clk_get_by_name(np, "cpu_clk");
 =09if (IS_ERR(priv.cpu_clk)) {
--=20
1.8.1.2
