From: Sudeep.KarkadaNagesha@arm.com
Subject: [RFC PATCH v2 12/15] cpufreq: arm_big_little: remove device tree parsing for cpu nodes
Date: Wed, 17 Jul 2013 15:06:21 +0100
Message-ID: <1374069984-20567-13-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1374069984-20567-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, devicetree-discuss@lists.ozlabs.org
Cc: Russell King <linux@arm.linux.org.uk>, Shawn Guo <shawn.guo@linaro.org>, Gregory Clement <gregory.clement@free-electrons.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Now that the cpu device registration initialises the of_node(if available)
appropriately for all the cpus, parsing here is redundant.

This patch removes all DT parsing and uses cpu->of_node instead.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/arm_big_little_dt.c | 39 ++++++++++++++++-----------------=
----
 1 file changed, 17 insertions(+), 22 deletions(-)

diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/arm_big_=
little_dt.c
index fd9e3ea..d2648d1 100644
--- a/drivers/cpufreq/arm_big_little_dt.c
+++ b/drivers/cpufreq/arm_big_little_dt.c
@@ -34,27 +34,19 @@
 /* get cpu node with valid operating-points */
 static struct device_node *get_cpu_node_with_valid_op(int cpu)
 {
-=09struct device_node *np =3D NULL, *parent;
-=09int count =3D 0;
+=09struct device *cpu_dev =3D get_cpu_device(cpu);
+=09struct device_node *np;
=20
-=09parent =3D of_find_node_by_path("/cpus");
-=09if (!parent) {
-=09=09pr_err("failed to find OF /cpus\n");
+=09if (!cpu_dev) {
+=09=09pr_err("failed to get cpu device\n");
 =09=09return NULL;
 =09}
-
-=09for_each_child_of_node(parent, np) {
-=09=09if (count++ !=3D cpu)
-=09=09=09continue;
-=09=09if (!of_get_property(np, "operating-points", NULL)) {
-=09=09=09of_node_put(np);
-=09=09=09np =3D NULL;
-=09=09}
-
-=09=09break;
+=09np =3D of_node_get(cpu_dev->of_node);
+=09if (!of_get_property(np, "operating-points", NULL)) {
+=09=09of_node_put(np);
+=09=09np =3D NULL;
 =09}
=20
-=09of_node_put(parent);
 =09return np;
 }
=20
@@ -63,11 +55,12 @@ static int dt_init_opp_table(struct device *cpu_dev)
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
@@ -79,9 +72,11 @@ static int dt_get_transition_latency(struct device *cpu_=
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
