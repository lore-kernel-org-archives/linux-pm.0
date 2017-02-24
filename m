From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpuidle: menu: Avoid taking spinlock for accessing QoS values
Date: Fri, 24 Feb 2017 13:25:14 +0100
Message-ID: <4299615.p769K17ZAr@aspire.rjw.lan>
References: <1487768197.27533.5.camel@gmx.de> <2909793.Vfsrmqmg03@aspire.rjw.lan> <55ee4ca6-9369-06b5-b680-f6483ca496af@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <55ee4ca6-9369-06b5-b680-f6483ca496af@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Shi <alex.shi@linaro.org>, Linux PM <linux-pm@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Mike Galbraith <efault@gmx.de>, LKML <linux-kernel@vger.kernel.org>, Rik van Riel <riel@redhat.com>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

After commit 9908859acaa9 (cpuidle/menu: add per CPU PM QoS resume
latency consideration) the cpuidle menu governor calls
dev_pm_qos_read_value() on CPU devices to read the current resume
latency QoS constraint values for them.  That function takes a spinlock
to prevent the device's power.qos pointer from becoming NULL during
the access which is a problem for the RT patchset where spinlocks are
converted into mutexes and the idle loop stops working.

However, it is not even necessary for the menu governor to take
that spinlock, because the power.qos pointer accessed under it
cannot be modified during the access anyway.

For this reason, introduce a "raw" routine for accessing device
QoS resume latency constraints without locking and use it in the
menu governor.

Fixes: 9908859acaa9 (cpuidle/menu: add per CPU PM QoS resume latency consideration)
Acked-by: Alex Shi <alex.shi@linaro.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

OK

This doesn't break my test machine outright, so here it goes officially.

Thanks,
Rafael

---
 drivers/base/power/qos.c         |    3 +--
 drivers/cpuidle/governors/menu.c |    2 +-
 include/linux/pm_qos.h           |    7 +++++++
 3 files changed, 9 insertions(+), 3 deletions(-)

Index: linux-pm/drivers/base/power/qos.c
===================================================================
--- linux-pm.orig/drivers/base/power/qos.c
+++ linux-pm/drivers/base/power/qos.c
@@ -108,8 +108,7 @@ s32 __dev_pm_qos_read_value(struct devic
 {
 	lockdep_assert_held(&dev->power.lock);
 
-	return IS_ERR_OR_NULL(dev->power.qos) ?
-		0 : pm_qos_read_value(&dev->power.qos->resume_latency);
+	return dev_pm_qos_raw_read_value(dev);
 }
 
 /**
Index: linux-pm/drivers/cpuidle/governors/menu.c
===================================================================
--- linux-pm.orig/drivers/cpuidle/governors/menu.c
+++ linux-pm/drivers/cpuidle/governors/menu.c
@@ -287,7 +287,7 @@ static int menu_select(struct cpuidle_dr
 	unsigned int interactivity_req;
 	unsigned int expected_interval;
 	unsigned long nr_iowaiters, cpu_load;
-	int resume_latency = dev_pm_qos_read_value(device);
+	int resume_latency = dev_pm_qos_raw_read_value(device);
 
 	if (data->needs_update) {
 		menu_update(drv, dev);
Index: linux-pm/include/linux/pm_qos.h
===================================================================
--- linux-pm.orig/include/linux/pm_qos.h
+++ linux-pm/include/linux/pm_qos.h
@@ -172,6 +172,12 @@ static inline s32 dev_pm_qos_requested_f
 {
 	return dev->power.qos->flags_req->data.flr.flags;
 }
+
+static inline s32 dev_pm_qos_raw_read_value(struct device *dev)
+{
+	return IS_ERR_OR_NULL(dev->power.qos) ?
+		0 : pm_qos_read_value(&dev->power.qos->resume_latency);
+}
 #else
 static inline enum pm_qos_flags_status __dev_pm_qos_flags(struct device *dev,
 							  s32 mask)
@@ -236,6 +242,7 @@ static inline void dev_pm_qos_hide_laten
 
 static inline s32 dev_pm_qos_requested_resume_latency(struct device *dev) { return 0; }
 static inline s32 dev_pm_qos_requested_flags(struct device *dev) { return 0; }
+static inline s32 dev_pm_qos_raw_read_value(struct device *dev) { return 0; }
 #endif
 
 #endif
