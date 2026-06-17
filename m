Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D5743D4FA;
	Wed, 17 Jun 2026 16:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712690; cv=none; b=JhOAdHxlRip18rq5ZlOCoHJvdKah9PuW7/LZLQjd9bh28Q83auVWGBgzSnzzSooLpMcxr5TyywY9LVF1Y2Z+k/TL2b7k1S198We4Bfo72ohReDyXd3oZAAJ+yceHNfjsYe3Ji2xC/g/B6qwzXrs8eAWTXBraZ0rrOFotY5amYbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712690; c=relaxed/simple;
	bh=exYPUEfVRWlcYEGmvpuGwbDzXT7tVoB1yA8LBWCmDTw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYjn83YKpdVOFRDlBacPw6CiohOXPTM8ul9xXRK/9EXcZsLgrQ9iJiWVDNsww/aLl4FoPafJqZMyNcPTcBfD7okuZ6OHXkTrmITsWV/mDwDf2bbre2AShd+e10WqPhwXeI2iAbA3kKO/PP7FbpNL2zW2blEy6vkVe7cS58SfG1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h10ROI1b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h10ROI1b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6209C1F00A3A;
	Wed, 17 Jun 2026 16:11:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781712683;
	bh=twYlBHqo3agizPvTm6EAjI6IHv8OXLmiHsKy2rX5PTI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h10ROI1bhHHLNycGxEjprkBUcFT7w5iFCdV31dWSuM72rmaHbQjRdu6LUJzMIfiPx
	 bCQblZUoeahEbc5+dwJfZBQbEraDmYhGVvy7ySp41avBdmwEr9QiVmLPes9szNyo7z
	 N529guyqfIgpxxzNIo+dIUGW5z+u+wvyDgtOJfZOfiRzdVxdD0kGp7BJiCg4lW0Pa0
	 TJgBx+qIMS0nE117ooiTX7DnQpc6DryCky+MCK22w0dICDTbTbbn2MGLz934EYk/gx
	 s/Qi3TRpEdxJnBm0w4NvzZhnwNvXYmkvZrSETbRFHUaz/EXcoeDO/j0SFU3Px6TqMm
	 6ZLo6KDZ9Xtuw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v1 2/2] thermal: testing: Flush work items during cleanup
Date: Wed, 17 Jun 2026 18:10:47 +0200
Message-ID: <5107023.GXAFRqVoOG@rafael.j.wysocki>
Organization: Linux Kernel Development
In-Reply-To: <12941879.O9o76ZdvQC@rafael.j.wysocki>
References: <12941879.O9o76ZdvQC@rafael.j.wysocki>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

To prevent freed module code from being executed during the thermal
testing module unload, make it add a dedicated workqueue for thermal
testing work items and flush it in thermal_testing_exit().

Fixes: f6a034f2df42 ("thermal: Introduce a debugfs-based testing facility")
Link: https://sashiko.dev/#/patchset/20260605185212.2491144-1-sam.moelius%40trailofbits.com
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/thermal/testing/command.c         |   16 +++++++++++++---
 drivers/thermal/testing/thermal_testing.h |    8 ++++++++
 drivers/thermal/testing/zone.c            |    7 +++----
 3 files changed, 24 insertions(+), 7 deletions(-)

--- a/drivers/thermal/testing/command.c
+++ b/drivers/thermal/testing/command.c
@@ -86,6 +86,8 @@
 
 #include "thermal_testing.h"
 
+struct workqueue_struct *tt_wq __ro_after_init;
+
 struct dentry *d_testing;
 
 #define TT_COMMAND_SIZE		16
@@ -203,10 +205,17 @@ static const struct file_operations tt_c
 
 static int __init thermal_testing_init(void)
 {
+	tt_wq = alloc_workqueue("thermal_testing", WQ_UNBOUND, 0);
+	if (!tt_wq)
+		return -ENOMEM;
+
 	d_testing = debugfs_create_dir("thermal-testing", NULL);
-	if (!IS_ERR(d_testing))
-		debugfs_create_file("command", 0200, d_testing, NULL,
-				    &tt_command_fops);
+	if (IS_ERR(d_testing)) {
+		destroy_workqueue(tt_wq);
+		return PTR_ERR(d_testing);
+	}
+
+	debugfs_create_file("command", 0200, d_testing, NULL, &tt_command_fops);
 
 	return 0;
 }
@@ -215,6 +224,7 @@ module_init(thermal_testing_init);
 static void __exit thermal_testing_exit(void)
 {
 	debugfs_remove(d_testing);
+	flush_workqueue(tt_wq);
 	tt_zone_cleanup();
 }
 module_exit(thermal_testing_exit);
--- a/drivers/thermal/testing/thermal_testing.h
+++ b/drivers/thermal/testing/thermal_testing.h
@@ -1,4 +1,12 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/workqueue.h>
+
+extern struct workqueue_struct *tt_wq;
+
+static inline void tt_queue_work(struct work_struct *work)
+{
+	queue_work(tt_wq, work);
+}
 
 extern struct dentry *d_testing;
 
--- a/drivers/thermal/testing/zone.c
+++ b/drivers/thermal/testing/zone.c
@@ -13,7 +13,6 @@
 #include <linux/idr.h>
 #include <linux/list.h>
 #include <linux/thermal.h>
-#include <linux/workqueue.h>
 
 #include "thermal_testing.h"
 
@@ -207,7 +206,7 @@ int tt_add_tz(void)
 
 	INIT_WORK(&tt_work->work, tt_add_tz_work_fn);
 	tt_work->tt_zone = no_free_ptr(tt_zone);
-	schedule_work(&(no_free_ptr(tt_work)->work));
+	tt_queue_work(&(no_free_ptr(tt_work)->work));
 
 	return 0;
 }
@@ -269,7 +268,7 @@ int tt_del_tz(const char *arg)
 
 	INIT_WORK(&tt_work->work, tt_del_tz_work_fn);
 	tt_work->tt_zone = tt_zone;
-	schedule_work(&(no_free_ptr(tt_work)->work));
+	tt_queue_work(&(no_free_ptr(tt_work)->work));
 
 	return 0;
 }
@@ -358,7 +357,7 @@ int tt_zone_add_trip(const char *arg)
 	INIT_WORK(&tt_work->work, tt_zone_add_trip_work_fn);
 	tt_work->tt_zone = no_free_ptr(tt_zone);
 	tt_work->tt_trip = no_free_ptr(tt_trip);
-	schedule_work(&(no_free_ptr(tt_work)->work));
+	tt_queue_work(&(no_free_ptr(tt_work)->work));
 
 	return 0;
 }



