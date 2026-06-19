Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C6023B19B1;
	Fri, 19 Jun 2026 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781881296; cv=none; b=ohMCIsHJEEL49cFicgPHoGDd/X80JVAPr9De3qMDbw2Y7ZaCPWh/JDSfZziJpf46XNos1hJHUSjIJ/dD9B4y4ksmxZhRy/28C9mNeuqGNJkA9K5+p2C5fV+LmDMkx9v02sg+6gcefjBj9WMwtrBojSBREWjad5oYGEqcJxqYgk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781881296; c=relaxed/simple;
	bh=8YmNzXUtBLt5fQ0nSx5bYZkHYbZ6y3lwmebZQNxre+w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=iziP/DEkJ1v6ENjZED/KlTXP/GQw7nUIFRR7kGWOp7BLqHfMhjgGwbiKCwVKfDEg1ovVGBRb2rhzANoIleUcjBJeTzQCnm43OdlyjSdkU7OAX3qWZgwqszvKHS9AzgwIGl+GZ8rEMgc7DLss4am0kMsDs2hcrIXyabiU9Hxw1yI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YRpHXrFm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YRpHXrFm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39F411F000E9;
	Fri, 19 Jun 2026 15:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781881291;
	bh=urhBa8/WM3+ZS+Yw7ttRz+fRIbqCK8QCPari98aCCEk=;
	h=From:To:Cc:Subject:Date;
	b=YRpHXrFmJkXNIUjOEt2Xdja7OejXcvF2waSNcxQ4k4lLmnEmHuomDM0MFZbG2wGna
	 EjF8X8+ViqKQQfzDheccLxLqflX8L8+hqxt8wkLoSr55iix/cLWE4c1rclkKD7Ej1c
	 Cu7ktbO+4lHjAfb+X+rAe8cUkYYt9v09Wr2lwEHR/IAbj9qFPOV0GlW59326Z0MfYf
	 jFHC985Ir1WBPFBhKU7BuxR78c+3/TdToFGb57TBHmkpbpDx1M+Hg1Grwa0ZfxQPxJ
	 9iu/Gwh95TzaZFrHv3QZs62RsqbOfhGPvYaYKR5/COtAX+lK4VxobGBDFQ3U6DqxuM
	 e/08qQ6Uyam3Q==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH v2] thermal: testing: zone: Flush work items during cleanup
Date: Fri, 19 Jun 2026 17:01:27 +0200
Message-ID: <1959388.tdWV9SEqCh@rafael.j.wysocki>
Organization: Linux Kernel Development
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

This is an update of

https://lore.kernel.org/linux-pm/5107023.GXAFRqVoOG@rafael.j.wysocki/

sent to address Sashiko feedback

https://sashiko.dev/#/patchset/12941879.O9o76ZdvQC%40rafael.j.wysocki

(and the first patch in the series is not really necessary, so it has been
dropped).

Thanks!

---
 drivers/thermal/testing/command.c         |   35 ++++++++++++++++++++++++++----
 drivers/thermal/testing/thermal_testing.h |    8 ++++++
 drivers/thermal/testing/zone.c            |    7 ++----
 3 files changed, 42 insertions(+), 8 deletions(-)

--- a/drivers/thermal/testing/command.c
+++ b/drivers/thermal/testing/command.c
@@ -86,7 +86,9 @@
 
 #include "thermal_testing.h"
 
-struct dentry *d_testing;
+struct workqueue_struct *tt_wq __ro_after_init;
+
+struct dentry *d_testing, *d_command __ro_after_init;
 
 #define TT_COMMAND_SIZE		16
 
@@ -203,17 +205,42 @@ static const struct file_operations tt_c
 
 static int __init thermal_testing_init(void)
 {
+	int error;
+
+	tt_wq = alloc_workqueue("thermal_testing", WQ_UNBOUND, 0);
+	if (!tt_wq)
+		return -ENOMEM;
+
 	d_testing = debugfs_create_dir("thermal-testing", NULL);
-	if (!IS_ERR(d_testing))
-		debugfs_create_file("command", 0200, d_testing, NULL,
-				    &tt_command_fops);
+	if (IS_ERR(d_testing)) {
+		error = PTR_ERR(d_testing);
+		goto destroy_wq;
+	}
+
+	d_command = debugfs_create_file("command", 0200, d_testing, NULL, &tt_command_fops);
+	if (IS_ERR(d_command)) {
+		error = PTR_ERR(d_command);
+		goto remove_d_testing;
+	}
 
 	return 0;
+
+remove_d_testing:
+	debugfs_remove(d_testing);
+destroy_wq:
+	destroy_workqueue(tt_wq);
+	return error;
 }
 module_init(thermal_testing_init);
 
 static void __exit thermal_testing_exit(void)
 {
+	/* First, prevent new commands from being entered. */
+	debugfs_remove(d_command);
+	/* Flush commands in progress (if any). */
+	flush_workqueue(tt_wq);
+	destroy_workqueue(tt_wq);
+	/* Remove the directory structure and clean up. */
 	debugfs_remove(d_testing);
 	tt_zone_cleanup();
 }
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



