From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] PM / OPP: Protect updates to list_dev with mutex
Date: Fri, 30 Oct 2015 17:26:06 +0530
Message-ID: <5f8fac4ad84716ef68fc50ab0b78e11ad2837524.1446205160.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35579 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758999AbbJ3L4Y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2015 07:56:24 -0400
Received: by pasz6 with SMTP id z6so72955520pas.2
        for <linux-pm@vger.kernel.org>; Fri, 30 Oct 2015 04:56:23 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, mturquette@baylibre.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>, Stephen Boyd <sboyd@codeaurora.org>

dev_opp_list_lock is used everywhere to protect device and OPP lists,
but dev_pm_opp_set_sharing_cpus() is missed somehow. And instead we used
rcu-lock, which wouldn't help here as we are adding a new list_dev.

This also fixes a problem where we have called kzalloc(..., GFP_KERNEL)
from within rcu-lock, which isn't allowed as kzalloc can sleep when
called with GFP_KERNEL.

With CONFIG_DEBUG_ATOMIC_SLEEP set, we will see the caller vomiting.

Fixes: 8d4d4e98acd6 ("PM / OPP: Add helpers for initializing CPU OPPs")
Reported-by: Michael Turquette <mturquette@baylibre.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
Mike: Can you please verify if this fixes it for you..

 drivers/base/power/opp/core.c | 2 +-
 drivers/base/power/opp/cpu.c  | 8 ++++----
 drivers/base/power/opp/opp.h  | 3 +++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index d5c1149ff123..69f83cbe37b2 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -27,7 +27,7 @@
  */
 static LIST_HEAD(dev_opp_list);
 /* Lock to allow exclusive modification to the device and opp lists */
-static DEFINE_MUTEX(dev_opp_list_lock);
+DEFINE_MUTEX(dev_opp_list_lock);
 
 #define opp_rcu_lockdep_assert()					\
 do {									\
diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 7654c5606307..91f15b2e25ee 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -124,12 +124,12 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 	struct device *dev;
 	int cpu, ret = 0;
 
-	rcu_read_lock();
+	mutex_lock(&dev_opp_list_lock);
 
 	dev_opp = _find_device_opp(cpu_dev);
 	if (IS_ERR(dev_opp)) {
 		ret = -EINVAL;
-		goto out_rcu_read_unlock;
+		goto unlock;
 	}
 
 	for_each_cpu(cpu, cpumask) {
@@ -150,8 +150,8 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 			continue;
 		}
 	}
-out_rcu_read_unlock:
-	rcu_read_unlock();
+unlock:
+	mutex_unlock(&dev_opp_list_lock);
 
 	return 0;
 }
diff --git a/drivers/base/power/opp/opp.h b/drivers/base/power/opp/opp.h
index dcb38f78dae4..7366b2aa8997 100644
--- a/drivers/base/power/opp/opp.h
+++ b/drivers/base/power/opp/opp.h
@@ -21,6 +21,9 @@
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
 
+/* Lock to allow exclusive modification to the device and opp lists */
+extern struct mutex dev_opp_list_lock;
+
 /*
  * Internal data structure organization with the OPP layer library is as
  * follows:
-- 
2.6.2.198.g614a2ac

