From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] PM / OPP: fix debugfs files for 64-bit
Date: Wed, 07 Oct 2015 09:35:41 +0200
Message-ID: <5706174.BUsqiXljxZ@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.126.131]:54104 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213AbbJGHf6 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 7 Oct 2015 03:35:58 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Stephen Boyd <sboyd@codeaurora.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Nishanth Menon <nm@ti.com>, Dmitry Torokhov <dtor@chromium.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

The recently added debugfs support for OPP creates files using the
debugfs_create_bool() and debugfs_create_u32() interfaces, but
casts the data argument to u32*, which is broken on some architectures.

In case of debugfs_create_bool(), the API has changed as of 621a5f7ad9cd
("debugfs: Pass bool pointer to debugfs_create_bool()"), so we now get
a warning about the new interface in linux-next, which contains both
patches. Removing the cast makes it work in linux-next, and makes it
warn in cases where it does not work.

For debugfs_create_u32(), the current usage is broken on 64-bit
architectures when the values exceed the range of 32-bit variables
(which should not happen), or when the kernel is built for as
big-endian. This patch removes the casts and changes the types
to u32 to make them match and print the correct value on all
architectures.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 5cb5fdbf38770 ("PM / OPP: Add debugfs support")
---
Found while building ARM allmodconfig

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 25f3efef24db..1cbc0acf831a 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -696,7 +696,7 @@ static int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
 			break;
 
 		/* Duplicate OPPs */
-		dev_warn(dev, "%s: duplicate OPPs detected. Existing: freq: %lu, volt: %lu, enabled: %d. New: freq: %lu, volt: %lu, enabled: %d\n",
+		dev_warn(dev, "%s: duplicate OPPs detected. Existing: freq: %u, volt: %u, enabled: %d. New: freq: %u, volt: %u, enabled: %d\n",
 			 __func__, opp->rate, opp->u_volt, opp->available,
 			 new_opp->rate, new_opp->u_volt, new_opp->available);
 
@@ -898,7 +898,7 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 	/* OPP to select on device suspend */
 	if (of_property_read_bool(np, "opp-suspend")) {
 		if (dev_opp->suspend_opp)
-			dev_warn(dev, "%s: Multiple suspend OPPs found (%lu %lu)\n",
+			dev_warn(dev, "%s: Multiple suspend OPPs found (%u %u)\n",
 				 __func__, dev_opp->suspend_opp->rate,
 				 new_opp->rate);
 		else
@@ -910,7 +910,7 @@ static int _opp_add_static_v2(struct device *dev, struct device_node *np)
 
 	mutex_unlock(&dev_opp_list_lock);
 
-	pr_debug("%s: turbo:%d rate:%lu uv:%lu uvmin:%lu uvmax:%lu latency:%lu\n",
+	pr_debug("%s: turbo:%d rate:%u uv:%u uvmin:%u uvmax:%u latency:%u\n",
 		 __func__, new_opp->turbo, new_opp->rate, new_opp->u_volt,
 		 new_opp->u_volt_min, new_opp->u_volt_max,
 		 new_opp->clock_latency_ns);
diff --git a/drivers/base/power/opp/debugfs.c b/drivers/base/power/opp/debugfs.c
index 865cbfa24640..45436dabae8d 100644
--- a/drivers/base/power/opp/debugfs.c
+++ b/drivers/base/power/opp/debugfs.c
@@ -38,43 +38,42 @@ int opp_debug_create_one(struct dev_pm_opp *opp, struct device_opp *dev_opp)
 	char name[15];
 
 	/* Rate is unique to each OPP, use it to give opp-name */
-	sprintf(name, "opp:%lu", opp->rate);
+	sprintf(name, "opp:%u", opp->rate);
 
 	/* Create per-opp directory */
 	d = debugfs_create_dir(name, pdentry);
 	if (!d)
 		return -ENOMEM;
 
-	if (!debugfs_create_bool("available", S_IRUGO, d,
-				 (u32 *)&opp->available))
+	if (!debugfs_create_bool("available", S_IRUGO, d, &opp->available))
 		return -ENOMEM;
 
-	if (!debugfs_create_bool("dynamic", S_IRUGO, d, (u32 *)&opp->dynamic))
+	if (!debugfs_create_bool("dynamic", S_IRUGO, d, &opp->dynamic))
 		return -ENOMEM;
 
-	if (!debugfs_create_bool("turbo", S_IRUGO, d, (u32 *)&opp->turbo))
+	if (!debugfs_create_bool("turbo", S_IRUGO, d, &opp->turbo))
 		return -ENOMEM;
 
-	if (!debugfs_create_u32("rate_hz", S_IRUGO, d, (u32 *)&opp->rate))
+	if (!debugfs_create_u32("rate_hz", S_IRUGO, d, &opp->rate))
 		return -ENOMEM;
 
 	if (!debugfs_create_u32("u_volt_target", S_IRUGO, d,
-				(u32 *)&opp->u_volt))
+				&opp->u_volt))
 		return -ENOMEM;
 
 	if (!debugfs_create_u32("u_volt_min", S_IRUGO, d,
-				(u32 *)&opp->u_volt_min))
+				&opp->u_volt_min))
 		return -ENOMEM;
 
 	if (!debugfs_create_u32("u_volt_max", S_IRUGO, d,
-				(u32 *)&opp->u_volt_max))
+				&opp->u_volt_max))
 		return -ENOMEM;
 
-	if (!debugfs_create_u32("u_amp", S_IRUGO, d, (u32 *)&opp->u_amp))
+	if (!debugfs_create_u32("u_amp", S_IRUGO, d, &opp->u_amp))
 		return -ENOMEM;
 
 	if (!debugfs_create_u32("clock_latency_ns", S_IRUGO, d,
-				(u32 *)&opp->clock_latency_ns))
+				&opp->clock_latency_ns))
 		return -ENOMEM;
 
 	opp->dentry = d;
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index 0e4c27fb0c4a..ef573e650773 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -71,13 +71,13 @@ struct dev_pm_opp {
 	bool available;
 	bool dynamic;
 	bool turbo;
-	unsigned long rate;
+	u32 rate;
 
-	unsigned long u_volt;
-	unsigned long u_volt_min;
-	unsigned long u_volt_max;
-	unsigned long u_amp;
-	unsigned long clock_latency_ns;
+	u32 u_volt;
+	u32 u_volt_min;
+	u32 u_volt_max;
+	u32 u_amp;
+	u32 clock_latency_ns;
 
 	struct device_opp *dev_opp;
 	struct rcu_head rcu_head;

