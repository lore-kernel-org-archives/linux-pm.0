From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 08/20] powercap/intel_rapl: Add missing domain data update on hotplug
Date: Thu, 17 Nov 2016 19:35:29 +0100
Message-ID: <20161117183541.8588-9-bigeasy@linutronix.de>
References: <20161117183541.8588-1-bigeasy@linutronix.de>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161117183541.8588-1-bigeasy@linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: rt@linuxtronix.de, Thomas Gleixner <tglx@linutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>
List-Id: linux-pm@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

The domain data of packages is only updated at init time, but new packages
created by hotplug miss that treatment.

Add it there and remove the global update at init time, because it's now
obsolete.

Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 drivers/powercap/intel_rapl.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index 243b233ff31b..44b12e2e4aa7 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1164,24 +1164,20 @@ static const struct x86_cpu_id rapl_ids[] __initcon=
st =3D {
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
=20
-/* read once for all raw primitive data for all packages, domains */
-static void rapl_update_domain_data(void)
+/* Read once for all raw primitive data for domains */
+static void rapl_update_domain_data(struct rapl_package *rp)
 {
 	int dmn, prim;
 	u64 val;
-	struct rapl_package *rp;
=20
-	list_for_each_entry(rp, &rapl_packages, plist) {
-		for (dmn =3D 0; dmn < rp->nr_domains; dmn++) {
-			pr_debug("update package %d domain %s data\n", rp->id,
-				rp->domains[dmn].name);
+	for (dmn =3D 0; dmn < rp->nr_domains; dmn++) {
+		pr_debug("update package %d domain %s data\n", rp->id,
+			 rp->domains[dmn].name);
 			/* exclude non-raw primitives */
-			for (prim =3D 0; prim < NR_RAW_PRIMITIVES; prim++)
-				if (!rapl_read_data_raw(&rp->domains[dmn], prim,
-								rpi[prim].unit,
-								&val))
-					rp->domains[dmn].rdd.primitives[prim] =3D
-									val;
+		for (prim =3D 0; prim < NR_RAW_PRIMITIVES; prim++) {
+			if (!rapl_read_data_raw(&rp->domains[dmn], prim,
+						rpi[prim].unit,	&val))
+				rp->domains[dmn].rdd.primitives[prim] =3D val;
 		}
 	}
=20
@@ -1239,6 +1235,9 @@ static int rapl_package_register_powercap(struct rapl=
_package *rp)
 	struct powercap_zone *power_zone =3D NULL;
 	int nr_pl;
=20
+	/* Update the domain data of the new package */
+	rapl_update_domain_data(rp);
+
 	/* first we register package domain as the parent zone*/
 	for (rd =3D rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
 		if (rd->id =3D=3D RAPL_DOMAIN_PACKAGE) {
@@ -1357,8 +1356,7 @@ static int rapl_register_powercap(void)
 		pr_debug("failed to register powercap control_type.\n");
 		return PTR_ERR(control_type);
 	}
-	/* read the initial data */
-	rapl_update_domain_data();
+
 	list_for_each_entry(rp, &rapl_packages, plist)
 		if (rapl_package_register_powercap(rp))
 			goto err_cleanup_package;
--=20
2.10.2
