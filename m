From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [RFC PATCH 1/2] PM / OPP: add support to specify phandle of another node for OPP
Date: Tue, 30 Jul 2013 19:00:16 +0100
Message-ID: <1375207217-4433-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1375207217-4433-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Sudeep.KarkadaNagesha@arm.com, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, Rob Herring <rob.herring@calxeda.com>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Stephen Warren <swarren@wwwdotorg.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Nishanth Menon <nm@ti.com>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

If more than one similar devices share the same OPPs, currently we
need to replicate the OPP entries in all the nodes.

Few drivers like cpufreq depend on physical cpu0 node to specify the
OPPs and only that node is referred irrespective of the logical cpu
accessing it. Alternatively to support cpuhotplug path, few drivers
parse all the cpu nodes for OPPs. Instead we can specify the phandle
of the node with which the current node shares the operating points.

This patch adds support to specify the phandle in the operating points
of any device node, where the node specified by the phandle holds the
actual OPPs.

Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Stephen Warren <swarren@wwwdotorg.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nishanth Menon <nm@ti.com>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 Documentation/devicetree/bindings/power/opp.txt | 114 ++++++++++++++++++++=
+---
 drivers/base/power/opp.c                        |  12 ++-
 2 files changed, 112 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentatio=
n/devicetree/bindings/power/opp.txt
index 74499e5..f66fd65 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -4,22 +4,112 @@ SoCs have a standard set of tuples consisting of frequen=
cy and
 voltage pairs that the device will support per voltage domain. These
 are called Operating Performance Points or OPPs.
=20
-Properties:
+Required Properties:
 - operating-points: An array of 2-tuples items, and each item consists
   of frequency and voltage like <freq-kHz vol-uV>.
 =09freq: clock frequency in kHz
 =09vol: voltage in microvolt
=20
+Optional properties:
+- operating-points-phandle: phandle to the device node with which this
+=09device shares the operating points(recommended if multiple
+=09devices are in the same clock domain and share OPPs, as it
+=09avoids replication of OPPs)
+
 Examples:
=20
-cpu@0 {
-=09compatible =3D "arm,cortex-a9";
-=09reg =3D <0>;
-=09next-level-cache =3D <&L2>;
-=09operating-points =3D <
-=09=09/* kHz    uV */
-=09=09792000  1100000
-=09=09396000  950000
-=09=09198000  850000
-=09>;
-};
+1. A uniprocessor system
+
+=09cpu@0 {
+=09=09compatible =3D "arm,cortex-a9";
+=09=09reg =3D <0>;
+=09=09next-level-cache =3D <&L2>;
+=09=09operating-points =3D <
+=09=09=09/* kHz    uV */
+=09=09=09792000  1100000
+=09=09=09396000  950000
+=09=09=09198000  850000
+=09=09>;
+=09};
+
+If more than one device of same type share the same OPPs, for example
+all the CPUs on a SoC or in a single cluster on a SoC, then we need to
+avoid replicating the OPPs in all the nodes. We can specify the phandle
+of the node with which the current node shares the operating points instea=
d.
+
+2. Consider a SMP system with 4 CPUs in the same clock domain.
+
+=09cpu0: cpu@0 {
+=09=09compatible =3D "arm,cortex-a9";
+=09=09reg =3D <0>;
+=09=09next-level-cache =3D <&L2>;
+=09=09operating-points =3D <
+=09=09=09/* kHz    uV */
+=09=09=09792000  1100000
+=09=09=09396000  950000
+=09=09=09198000  850000
+=09=09>;
+=09};
+
+=09cpu1: cpu@1 {
+=09=09compatible =3D "arm,cortex-a9";
+=09=09reg =3D <1>;
+=09=09next-level-cache =3D <&L2>;
+=09=09operating-points-phandle =3D <&cpu0>;
+=09};
+
+=09cpu2: cpu@2 {
+=09=09compatible =3D "arm,cortex-a9";
+=09=09reg =3D <2>;
+=09=09next-level-cache =3D <&L2>;
+=09=09operating-points-phandle =3D <&cpu0>;
+=09};
+
+=09cpu3: cpu@3 {
+=09=09compatible =3D "arm,cortex-a9";
+=09=09reg =3D <3>;
+=09=09next-level-cache =3D <&L2>;
+=09=09operating-points-phandle =3D <&cpu0>;
+=09};
+
+3. Consider an AMP(asymmetric multi-processor) sytem with 2 clusters of CP=
Us.
+   Each cluster has 2 CPUs and all the CPUs within the cluster share the c=
lock
+   domain.
+
+=09cpu0: cpu@0 {
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <0>;
+=09=09operating-points =3D <
+=09=09=09/* kHz    uV */
+=09=09=09792000  1100000
+=09=09=09396000  950000
+=09=09=09198000  850000
+=09=09>;
+=09=09clock-latency =3D <100000>; /* 100us */
+=09};
+
+=09cpu1: cpu@1 {
+=09=09compatible =3D "arm,cortex-a15";
+=09=09reg =3D <1>;
+=09=09clock-latency =3D <100000>; /* 100us */
+=09=09operating-points-phandle =3D <&cpu0>;
+=09};
+
+=09cpu2: cpu@100 {
+=09=09compatible =3D "arm,cortex-a7";
+=09=09reg =3D <100>;
+=09=09operating-points =3D <
+=09=09=09/* kHz    uV */
+=09=09=09792000  950000
+=09=09=09396000  750000
+=09=09=09198000  450000
+=09=09>;
+=09=09clock-latency =3D <100000>; /* 100us */
+=09};
+
+=09cpu3: cpu@101 {
+=09=09compatible =3D "arm,cortex-a7";
+=09=09reg =3D <101>;
+=09=09operating-points-phandle =3D <&cpu2>;
+=09=09clock-latency =3D <100000>; /* 100us */
+=09};
diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index c8ec186..9ac3c93 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -707,12 +707,20 @@ struct srcu_notifier_head *opp_get_notifier(struct de=
vice *dev)
 int of_init_opp_table(struct device *dev)
 {
 =09const struct property *prop;
+=09struct device_node *opp_node;
 =09const __be32 *val;
 =09int nr;
=20
-=09prop =3D of_find_property(dev->of_node, "operating-points", NULL);
-=09if (!prop)
+=09opp_node =3D of_parse_phandle(dev->of_node,
+=09=09=09=09=09"operating-points-phandle", 0);
+=09if (!opp_node) /* if no OPP phandle, search for OPPs in current node */
+=09=09opp_node =3D dev->of_node;
+=09prop =3D of_find_property(opp_node, "operating-points", NULL);
+=09if (!prop) {
+=09=09dev_warn(dev, "node %s missing operating-points property\n",
+=09=09=09=09=09=09=09opp_node->full_name);
 =09=09return -ENODEV;
+=09}
 =09if (!prop->value)
 =09=09return -ENODATA;
=20
--=20
1.8.1.2


