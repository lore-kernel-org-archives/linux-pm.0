From: Sudeep.KarkadaNagesha@arm.com
Subject: [RFC PATCH v2 15/15] cpufreq: pmac32-cpufreq: remove device tree parsing for cpu nodes
Date: Wed, 17 Jul 2013 15:06:24 +0100
Message-ID: <1374069984-20567-16-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:56314 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755597Ab3GQOGu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jul 2013 10:06:50 -0400
In-Reply-To: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Russell King <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes DT parsing and uses cpu->of_node instead.

Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/pmac32-cpufreq.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-cpuf=
req.c
index 3104fad..b6822ee 100644
--- a/drivers/cpufreq/pmac32-cpufreq.c
+++ b/drivers/cpufreq/pmac32-cpufreq.c
@@ -21,6 +21,7 @@
 #include <linux/sched.h>
 #include <linux/adb.h>
 #include <linux/pmu.h>
+#include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/init.h>
 #include <linux/device.h>
@@ -643,6 +644,7 @@ static int pmac_cpufreq_init_750FX(struct device_node *=
cpunode)
  */
 static int __init pmac_cpufreq_setup(void)
 {
+=09struct device *cpu_dev;
 =09struct device_node=09*cpunode;
 =09const u32=09=09*value;
=20
@@ -650,7 +652,14 @@ static int __init pmac_cpufreq_setup(void)
 =09=09return 0;
=20
 =09/* Assume only one CPU */
-=09cpunode =3D of_find_node_by_type(NULL, "cpu");
+=09cpu_dev =3D get_cpu_device(0);
+=09if (!cpu_dev) {
+=09=09pr_err("failed to get cpu device\n");
+=09=09return -ENODEV;
+=09}
+
+=09/* Get first CPU node */
+=09cpunode =3D of_node_get(cpu_dev->of_node);
 =09if (!cpunode)
 =09=09goto out;
=20
--=20
1.8.1.2


