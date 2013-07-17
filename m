From: Sudeep.KarkadaNagesha@arm.com
Subject: [RFC PATCH v2 14/15] cpufreq: pmac64-cpufreq: remove device tree parsing for cpu nodes
Date: Wed, 17 Jul 2013 15:06:23 +0100
Message-ID: <1374069984-20567-15-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:56217 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755560Ab3GQOGs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2013 10:06:48 -0400
In-Reply-To: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Russell King <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes all DT parsing and uses cpu->of_node instead.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/pmac64-cpufreq.c | 54 ++++++++++++++----------------------=
----
 1 file changed, 18 insertions(+), 36 deletions(-)

diff --git a/drivers/cpufreq/pmac64-cpufreq.c b/drivers/cpufreq/pmac64-cpuf=
req.c
index 7ba4234..b60ccea 100644
--- a/drivers/cpufreq/pmac64-cpufreq.c
+++ b/drivers/cpufreq/pmac64-cpufreq.c
@@ -18,6 +18,7 @@
 #include <linux/kernel.h>
 #include <linux/delay.h>
 #include <linux/sched.h>
+#include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/init.h>
 #include <linux/completion.h>
@@ -383,9 +384,8 @@ static struct cpufreq_driver g5_cpufreq_driver =3D {
=20
 #ifdef CONFIG_PMAC_SMU
=20
-static int __init g5_neo2_cpufreq_init(struct device_node *cpus)
+static int __init g5_neo2_cpufreq_init(struct device_node *cpunode)
 {
-=09struct device_node *cpunode;
 =09unsigned int psize, ssize;
 =09unsigned long max_freq;
 =09char *freq_method, *volt_method;
@@ -405,20 +405,6 @@ static int __init g5_neo2_cpufreq_init(struct device_n=
ode *cpus)
 =09else
 =09=09return -ENODEV;
=20
-=09/* Get first CPU node */
-=09for (cpunode =3D NULL;
-=09     (cpunode =3D of_get_next_child(cpus, cpunode)) !=3D NULL;) {
-=09=09const u32 *reg =3D of_get_property(cpunode, "reg", NULL);
-=09=09if (reg =3D=3D NULL || (*reg) !=3D 0)
-=09=09=09continue;
-=09=09if (!strcmp(cpunode->type, "cpu"))
-=09=09=09break;
-=09}
-=09if (cpunode =3D=3D NULL) {
-=09=09printk(KERN_ERR "cpufreq: Can't find any CPU 0 node\n");
-=09=09return -ENODEV;
-=09}
-
 =09/* Check 970FX for now */
 =09valp =3D of_get_property(cpunode, "cpu-version", NULL);
 =09if (!valp) {
@@ -537,9 +523,9 @@ static int __init g5_neo2_cpufreq_init(struct device_no=
de *cpus)
 #endif /* CONFIG_PMAC_SMU */
=20
=20
-static int __init g5_pm72_cpufreq_init(struct device_node *cpus)
+static int __init g5_pm72_cpufreq_init(struct device_node *cpunode)
 {
-=09struct device_node *cpuid =3D NULL, *hwclock =3D NULL, *cpunode =3D NUL=
L;
+=09struct device_node *cpuid =3D NULL, *hwclock =3D NULL;
 =09const u8 *eeprom =3D NULL;
 =09const u32 *valp;
 =09u64 max_freq, min_freq, ih, il;
@@ -548,17 +534,6 @@ static int __init g5_pm72_cpufreq_init(struct device_n=
ode *cpus)
 =09DBG("cpufreq: Initializing for PowerMac7,2, PowerMac7,3 and"
 =09    " RackMac3,1...\n");
=20
-=09/* Get first CPU node */
-=09for (cpunode =3D NULL;
-=09     (cpunode =3D of_get_next_child(cpus, cpunode)) !=3D NULL;) {
-=09=09if (!strcmp(cpunode->type, "cpu"))
-=09=09=09break;
-=09}
-=09if (cpunode =3D=3D NULL) {
-=09=09printk(KERN_ERR "cpufreq: Can't find any CPU node\n");
-=09=09return -ENODEV;
-=09}
-
 =09/* Lookup the cpuid eeprom node */
         cpuid =3D of_find_node_by_path("/u3@0,f8000000/i2c@f8001000/cpuid@=
a0");
 =09if (cpuid !=3D NULL)
@@ -718,25 +693,32 @@ static int __init g5_pm72_cpufreq_init(struct device_=
node *cpus)
=20
 static int __init g5_cpufreq_init(void)
 {
-=09struct device_node *cpus;
+=09struct device *cpu_dev;
+=09struct device_node *cpunode;
 =09int rc =3D 0;
=20
-=09cpus =3D of_find_node_by_path("/cpus");
-=09if (cpus =3D=3D NULL) {
-=09=09DBG("No /cpus node !\n");
+=09cpu_dev =3D get_cpu_device(0);
+=09if (!cpu_dev) {
+=09=09pr_err("failed to get cpu device\n");
+=09=09return -ENODEV;
+=09}
+
+=09/* Get first CPU node */
+=09cpunode =3D of_node_get(cpu_dev->of_node);
+=09if (cpunode =3D=3D NULL) {
+=09=09pr_err("cpufreq: Can't find any CPU node\n");
 =09=09return -ENODEV;
 =09}
=20
 =09if (of_machine_is_compatible("PowerMac7,2") ||
 =09    of_machine_is_compatible("PowerMac7,3") ||
 =09    of_machine_is_compatible("RackMac3,1"))
-=09=09rc =3D g5_pm72_cpufreq_init(cpus);
+=09=09rc =3D g5_pm72_cpufreq_init(cpunode);
 #ifdef CONFIG_PMAC_SMU
 =09else
-=09=09rc =3D g5_neo2_cpufreq_init(cpus);
+=09=09rc =3D g5_neo2_cpufreq_init(cpunode);
 #endif /* CONFIG_PMAC_SMU */
=20
-=09of_node_put(cpus);
 =09return rc;
 }
=20
--=20
1.8.1.2


