From: Sudeep.KarkadaNagesha@arm.com
Subject: [RFC PATCH v2 13/15] cpufreq: maple-cpufreq: remove device tree parsing for cpu nodes
Date: Wed, 17 Jul 2013 15:06:22 +0100
Message-ID: <1374069984-20567-14-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Russell King <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes all DT parsing and uses cpu->of_node instead.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/maple-cpufreq.c | 23 +++++++----------------
 1 file changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufre=
q.c
index cdd6291..bc7233b 100644
--- a/drivers/cpufreq/maple-cpufreq.c
+++ b/drivers/cpufreq/maple-cpufreq.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/sched.h>
+#include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/init.h>
 #include <linux/completion.h>
@@ -201,7 +202,7 @@ static struct cpufreq_driver maple_cpufreq_driver =3D {
=20
 static int __init maple_cpufreq_init(void)
 {
-=09struct device_node *cpus;
+=09struct device *cpu_dev;
 =09struct device_node *cpunode;
 =09unsigned int psize;
 =09unsigned long max_freq;
@@ -217,24 +218,17 @@ static int __init maple_cpufreq_init(void)
 =09    !of_machine_is_compatible("Momentum,Apache"))
 =09=09return 0;
=20
-=09cpus =3D of_find_node_by_path("/cpus");
-=09if (cpus =3D=3D NULL) {
-=09=09DBG("No /cpus node !\n");
+=09cpu_dev =3D get_cpu_device(0);
+=09if (!cpu_dev) {
+=09=09pr_err("failed to get cpu device\n");
 =09=09return -ENODEV;
 =09}
=20
 =09/* Get first CPU node */
-=09for (cpunode =3D NULL;
-=09     (cpunode =3D of_get_next_child(cpus, cpunode)) !=3D NULL;) {
-=09=09const u32 *reg =3D of_get_property(cpunode, "reg", NULL);
-=09=09if (reg =3D=3D NULL || (*reg) !=3D 0)
-=09=09=09continue;
-=09=09if (!strcmp(cpunode->type, "cpu"))
-=09=09=09break;
-=09}
+=09cpunode =3D of_node_get(cpu_dev->of_node);
 =09if (cpunode =3D=3D NULL) {
 =09=09printk(KERN_ERR "cpufreq: Can't find any CPU 0 node\n");
-=09=09goto bail_cpus;
+=09=09goto bail_noprops;
 =09}
=20
 =09/* Check 970FX for now */
@@ -290,14 +284,11 @@ static int __init maple_cpufreq_init(void)
 =09rc =3D cpufreq_register_driver(&maple_cpufreq_driver);
=20
 =09of_node_put(cpunode);
-=09of_node_put(cpus);
=20
 =09return rc;
=20
 bail_noprops:
 =09of_node_put(cpunode);
-bail_cpus:
-=09of_node_put(cpus);
=20
 =09return rc;
 }
--=20
1.8.1.2
