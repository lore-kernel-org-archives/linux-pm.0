From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [PATCH v3 13/16] cpufreq: arm_big_little: remove device tree parsing for cpu nodes
Date: Mon, 22 Jul 2013 12:32:24 +0100
Message-ID: <1374492747-13879-14-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
 <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:36826 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932501Ab3GVLct (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jul 2013 07:32:49 -0400
In-Reply-To: <1374492747-13879-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Sudeep.KarkadaNagesha@arm.com, Russell King <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes all DT parsing and uses cpu->of_node instead.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/arm_big_little_dt.c | 40 +++++++++++++--------------------=
----
 1 file changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/arm_big_=
little_dt.c
index fd9e3ea..480c0bd 100644
--- a/drivers/cpufreq/arm_big_little_dt.c
+++ b/drivers/cpufreq/arm_big_little_dt.c
@@ -19,12 +19,11 @@
=20
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
=20
-#include <linux/cpu.h>
 #include <linux/cpufreq.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/module.h>
-#include <linux/of.h>
+#include <linux/of_device.h>
 #include <linux/opp.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
@@ -34,27 +33,13 @@
 /* get cpu node with valid operating-points */
 static struct device_node *get_cpu_node_with_valid_op(int cpu)
 {
-=09struct device_node *np =3D NULL, *parent;
-=09int count =3D 0;
+=09struct device_node *np =3D of_cpu_device_node_get(cpu);
=20
-=09parent =3D of_find_node_by_path("/cpus");
-=09if (!parent) {
-=09=09pr_err("failed to find OF /cpus\n");
-=09=09return NULL;
+=09if (!of_get_property(np, "operating-points", NULL)) {
+=09=09of_node_put(np);
+=09=09np =3D NULL;
 =09}
=20
-=09for_each_child_of_node(parent, np) {
-=09=09if (count++ !=3D cpu)
-=09=09=09continue;
-=09=09if (!of_get_property(np, "operating-points", NULL)) {
-=09=09=09of_node_put(np);
-=09=09=09np =3D NULL;
-=09=09}
-
-=09=09break;
-=09}
-
-=09of_node_put(parent);
 =09return np;
 }
=20
@@ -63,11 +48,12 @@ static int dt_init_opp_table(struct device *cpu_dev)
 =09struct device_node *np;
 =09int ret;
=20
-=09np =3D get_cpu_node_with_valid_op(cpu_dev->id);
-=09if (!np)
-=09=09return -ENODATA;
+=09np =3D of_node_get(cpu_dev->of_node);
+=09if (!np) {
+=09=09pr_err("failed to find cpu%d node\n", cpu_dev->id);
+=09=09return -ENOENT;
+=09}
=20
-=09cpu_dev->of_node =3D np;
 =09ret =3D of_init_opp_table(cpu_dev);
 =09of_node_put(np);
=20
@@ -79,9 +65,11 @@ static int dt_get_transition_latency(struct device *cpu_=
dev)
 =09struct device_node *np;
 =09u32 transition_latency =3D CPUFREQ_ETERNAL;
=20
-=09np =3D get_cpu_node_with_valid_op(cpu_dev->id);
-=09if (!np)
+=09np =3D of_node_get(cpu_dev->of_node);
+=09if (!np) {
+=09=09pr_info("Failed to find cpu node. Use CPUFREQ_ETERNAL transition lat=
ency\n");
 =09=09return CPUFREQ_ETERNAL;
+=09}
=20
 =09of_property_read_u32(np, "clock-latency", &transition_latency);
 =09of_node_put(np);
--=20
1.8.1.2


