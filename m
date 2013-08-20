From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [PATCH v4 15/19] cpufreq: kirkwood-cpufreq: remove device tree parsing for cpu nodes
Date: Tue, 20 Aug 2013 10:30:17 +0100
Message-ID: <1376991021-12160-16-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1376991021-12160-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: Sudeep.KarkadaNagesha@arm.com, Viresh Kumar <viresh.kumar@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Jonas Bonn <jonas@southpole.se>, Michal Simek <monstr@monstr.eu>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Jason Cooper <jason@lakedaemon.net>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes all DT parsing and uses cpu->of_node instead.

Cc: Jason Cooper <jason@lakedaemon.net>
Acked-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/kirkwood-cpufreq.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-=
cpufreq.c
index c233ea6..25ac2cb 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -14,7 +14,7 @@
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/cpufreq.h>
-#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/io.h>
 #include <asm/proc-fns.h>
@@ -175,9 +175,11 @@ static int kirkwood_cpufreq_probe(struct platform_devi=
ce *pdev)
 =09if (IS_ERR(priv.base))
 =09=09return PTR_ERR(priv.base);
=20
-=09np =3D of_find_node_by_path("/cpus/cpu@0");
-=09if (!np)
+=09np =3D of_cpu_device_node_get(0);
+=09if (!np) {
+=09=09dev_err(&pdev->dev, "failed to get cpu device node\n");
 =09=09return -ENODEV;
+=09}
=20
 =09priv.cpu_clk =3D of_clk_get_by_name(np, "cpu_clk");
 =09if (IS_ERR(priv.cpu_clk)) {
--=20
1.8.1.2
