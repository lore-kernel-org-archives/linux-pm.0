From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 1/5] powercap/intel_rapl: Add missing domain data update on
 hotplug
Date: Tue, 22 Nov 2016 21:15:58 -0000
Message-ID: <20161122211438.432984735@linutronix.de>
References: <20161122210518.079483154@linutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([146.0.238.70]:60987 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755213AbcKVVSm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 16:18:42 -0500
Content-Disposition: inline;
 filename=powercapintel_rapl_Add_missing_domain_data_update_on_hotplug.patch
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Rafael Wysocki <rjw@sisk.pl>, x86@kernel.org, Peter Zijlstra <peterz@infradead.org>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

The domain data of packages is only updated at init time, but new packages
created by hotplug miss that treatment.

Add it there and remove the global update at init time, because it's now
obsolete.

The more interesting question is why rapl_update_domain_data() exists at
all as nothing ever uses that data.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/powercap/intel_rapl.c |   42 ++++++++++++++++++------------------------
 1 file changed, 18 insertions(+), 24 deletions(-)

--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1164,24 +1164,20 @@ static const struct x86_cpu_id rapl_ids[
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
 
-/* read once for all raw primitive data for all packages, domains */
-static void rapl_update_domain_data(void)
+/* Read once for all raw primitive data for domains */
+static void rapl_update_domain_data(struct rapl_package *rp)
 {
 	int dmn, prim;
 	u64 val;
-	struct rapl_package *rp;
 
-	list_for_each_entry(rp, &rapl_packages, plist) {
-		for (dmn = 0; dmn < rp->nr_domains; dmn++) {
-			pr_debug("update package %d domain %s data\n", rp->id,
-				rp->domains[dmn].name);
-			/* exclude non-raw primitives */
-			for (prim = 0; prim < NR_RAW_PRIMITIVES; prim++)
-				if (!rapl_read_data_raw(&rp->domains[dmn], prim,
-								rpi[prim].unit,
-								&val))
-					rp->domains[dmn].rdd.primitives[prim] =
-									val;
+	for (dmn = 0; dmn < rp->nr_domains; dmn++) {
+		pr_debug("update package %d domain %s data\n", rp->id,
+			 rp->domains[dmn].name);
+		/* exclude non-raw primitives */
+		for (prim = 0; prim < NR_RAW_PRIMITIVES; prim++) {
+			if (!rapl_read_data_raw(&rp->domains[dmn], prim,
+						rpi[prim].unit, &val))
+				rp->domains[dmn].rdd.primitives[prim] =	val;
 		}
 	}
 
@@ -1234,10 +1230,12 @@ static int rapl_unregister_powercap(void
 static int rapl_package_register_powercap(struct rapl_package *rp)
 {
 	struct rapl_domain *rd;
-	int ret = 0;
 	char dev_name[17]; /* max domain name = 7 + 1 + 8 for int + 1 for null*/
 	struct powercap_zone *power_zone = NULL;
-	int nr_pl;
+	int nr_pl, ret;;
+
+	/* Update the domain data of the new package */
+	rapl_update_domain_data(rp);
 
 	/* first we register package domain as the parent zone*/
 	for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
@@ -1257,8 +1255,7 @@ static int rapl_package_register_powerca
 			if (IS_ERR(power_zone)) {
 				pr_debug("failed to register package, %d\n",
 					rp->id);
-				ret = PTR_ERR(power_zone);
-				goto exit_package;
+				return PTR_ERR(power_zone);
 			}
 			/* track parent zone in per package/socket data */
 			rp->power_zone = power_zone;
@@ -1268,8 +1265,7 @@ static int rapl_package_register_powerca
 	}
 	if (!power_zone) {
 		pr_err("no package domain found, unknown topology!\n");
-		ret = -ENODEV;
-		goto exit_package;
+		return -ENODEV;
 	}
 	/* now register domains as children of the socket/package*/
 	for (rd = rp->domains; rd < rp->domains + rp->nr_domains; rd++) {
@@ -1290,9 +1286,8 @@ static int rapl_package_register_powerca
 			goto err_cleanup;
 		}
 	}
+	return 0;
 
-exit_package:
-	return ret;
 err_cleanup:
 	/* clean up previously initialized domains within the package if we
 	 * failed after the first domain setup.
@@ -1357,8 +1352,7 @@ static int rapl_register_powercap(void)
 		pr_debug("failed to register powercap control_type.\n");
 		return PTR_ERR(control_type);
 	}
-	/* read the initial data */
-	rapl_update_domain_data();
+
 	list_for_each_entry(rp, &rapl_packages, plist)
 		if (rapl_package_register_powercap(rp))
 			goto err_cleanup_package;


