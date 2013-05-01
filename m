From: Sudeep.KarkadaNagesha@arm.com
Subject: [PATCH 1/2] PM / OPP: add support to specify phandle of another node for OPP
Date: Wed,  1 May 2013 12:11:18 +0100
Message-ID: <1367406679-21603-2-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1367406679-21603-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:48968 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758441Ab3EALLc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 1 May 2013 07:11:32 -0400
In-Reply-To: <1367406679-21603-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Grant Likely <grant.likely@linaro.org>, Rob Herring <rob.herring@calxeda.com>, Rob Landley <rob@landley.net>, "Rafael J. Wysocki" <rjw@sisk.pl>, Shawn Guo <shawn.guo@linaro.org>, devicetree-discuss@lists.ozlabs.org, linux-doc@vger.kernel.org, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

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

Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 Documentation/devicetree/bindings/power/opp.txt |   41 +++++++++++++++++++=
++++
 drivers/base/power/opp.c                        |   30 ++++++++++++-----
 2 files changed, 63 insertions(+), 8 deletions(-)

diff --git a/Documentation/devicetree/bindings/power/opp.txt b/Documentatio=
n/devicetree/bindings/power/opp.txt
index 74499e5..a659da4 100644
--- a/Documentation/devicetree/bindings/power/opp.txt
+++ b/Documentation/devicetree/bindings/power/opp.txt
@@ -23,3 +23,44 @@ cpu@0 {
 =09=09198000  850000
 =09>;
 };
+
+If more than one device of same type share the same OPPs, e.g. all the CPU=
s on
+a SoC or in a single cluster on a SoC, then we need to avoid replicating t=
he
+OPPs in all the nodes. We can specify the phandle of the node with which t=
he
+current node shares the operating points instead.
+
+Examples:
+Consider an SMP with 4 CPUs all sharing the same OPPs.
+
+cpu0: cpu@0 {
+=09compatible =3D "arm,cortex-a9";
+=09reg =3D <0>;
+=09next-level-cache =3D <&L2>;
+=09operating-points =3D <
+=09=09/* kHz    uV */
+=09=09792000  1100000
+=09=09396000  950000
+=09=09198000  850000
+=09>;
+};
+
+cpu1: cpu@1 {
+=09compatible =3D "arm,cortex-a9";
+=09reg =3D <1>;
+=09next-level-cache =3D <&L2>;
+=09operating-points =3D <&cpu0>;
+};
+
+cpu2: cpu@2 {
+=09compatible =3D "arm,cortex-a9";
+=09reg =3D <2>;
+=09next-level-cache =3D <&L2>;
+=09operating-points =3D <&cpu0>;
+};
+
+cpu3: cpu@3 {
+=09compatible =3D "arm,cortex-a9";
+=09reg =3D <3>;
+=09next-level-cache =3D <&L2>;
+=09operating-points =3D <&cpu0>;
+};
diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
index f0077cb..4dfdc01 100644
--- a/drivers/base/power/opp.c
+++ b/drivers/base/power/opp.c
@@ -698,19 +698,15 @@ struct srcu_notifier_head *opp_get_notifier(struct de=
vice *dev)
 }
=20
 #ifdef CONFIG_OF
-/**
- * of_init_opp_table() - Initialize opp table from device tree
- * @dev:=09device pointer used to lookup device OPPs.
- *
- * Register the initial OPP table with the OPP library for given device.
- */
-int of_init_opp_table(struct device *dev)
+static int of_init_opp_table_from_ofnode(struct device *dev,
+=09=09=09=09=09struct device_node *of_node)
 {
+=09struct device_opp *dev_opp =3D NULL;
 =09const struct property *prop;
 =09const __be32 *val;
 =09int nr;
=20
-=09prop =3D of_find_property(dev->of_node, "operating-points", NULL);
+=09prop =3D of_find_property(of_node, "operating-points", NULL);
 =09if (!prop)
 =09=09return -ENODEV;
 =09if (!prop->value)
@@ -722,6 +718,14 @@ int of_init_opp_table(struct device *dev)
 =09 */
 =09nr =3D prop->length / sizeof(u32);
 =09if (nr % 2) {
+=09=09if (nr =3D=3D 1) {
+=09=09=09struct device_node *opp_node;
+=09=09=09opp_node =3D of_parse_phandle(dev->of_node,
+=09=09=09=09=09=09"operating-points", 0);
+=09=09=09if (opp_node)
+=09=09=09=09return of_init_opp_table_from_ofnode(dev,
+=09=09=09=09=09=09=09=09opp_node);
+=09=09}
 =09=09dev_err(dev, "%s: Invalid OPP list\n", __func__);
 =09=09return -EINVAL;
 =09}
@@ -741,5 +745,15 @@ int of_init_opp_table(struct device *dev)
=20
 =09return 0;
 }
+/**
+ * of_init_opp_table() - Initialize opp table from device tree
+ * @dev:=09device pointer used to lookup device OPPs.
+ *
+ * Register the initial OPP table with the OPP library for given device.
+ */
+int of_init_opp_table(struct device *dev)
+{
+=09return of_init_opp_table_from_ofnode(dev, dev->of_node);
+}
 EXPORT_SYMBOL_GPL(of_init_opp_table);
 #endif
--=20
1.7.10.4


