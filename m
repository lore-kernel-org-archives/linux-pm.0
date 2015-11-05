From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 2/4] PM / OPP: Protect updates to list_dev with mutex
Date: Thu,  5 Nov 2015 14:21:19 +0530
Message-ID: <659a9d35df63661e056b1497cf45729afc30db71.1446713282.git.viresh.kumar@linaro.org>
References: <cover.1446713282.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1446713282.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1446713282.git.viresh.kumar@linaro.org>
References: <cover.1446713282.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Stephen Boyd <sboyd@codeaurora.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "4 . 3 # 4 . 3" <stable@vger.kernel.org>, Michael Turquette <mturquette@baylibre.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dan Carpenter <dan.carpenter@oracle.com>, Dmitry Torokhov <dtor@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Len Brown <len.brown@intel.com>, open list <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

dev_opp_list_lock is used everywhere to protect device and OPP lists,
but dev_pm_opp_set_sharing_cpus() is missed somehow. And instead we used
rcu-lock, which wouldn't help here as we are adding a new list_dev.

This also fixes a problem where we have called kzalloc(..., GFP_KERNEL)
from within rcu-lock, which isn't allowed as kzalloc can sleep when
called with GFP_KERNEL.

With CONFIG_DEBUG_ATOMIC_SLEEP set, we get following lockdep-splat:

include/linux/rcupdate.h:578 Illegal context switch in RCU read-side critical section!

other info that might help us debug this:

rcu_scheduler_active = 1, debug_locks = 0
5 locks held by swapper/0/1:
 #0:  (&dev->mutex){......}, at: [<c02f68f4>] __driver_attach+0x48/0x98
 #1:  (&dev->mutex){......}, at: [<c02f6904>] __driver_attach+0x58/0x98
 #2:  (cpu_hotplug.lock){++++++}, at: [<c00249d0>] get_online_cpus+0x40/0xb0
 #3:  (subsys mutex#5){+.+.+.}, at: [<c02f4f8c>] subsys_interface_register+0x44/0xdc
 #4:  (rcu_read_lock){......}, at: [<c0305c80>] dev_pm_opp_set_sharing_cpus+0x0/0x1e4

stack backtrace:
CPU: 1 PID: 1 Comm: swapper/0 Tainted: G        W       4.3.0-rc7-00047-g81f5932958a8 #59
Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
[<c0016874>] (unwind_backtrace) from [<c001355c>] (show_stack+0x10/0x14)
[<c001355c>] (show_stack) from [<c022553c>] (dump_stack+0x94/0xbc)
[<c022553c>] (dump_stack) from [<c004904c>] (___might_sleep+0x24c/0x298)
[<c004904c>] (___might_sleep) from [<c00f07e4>] (kmem_cache_alloc+0xe8/0x164)
[<c00f07e4>] (kmem_cache_alloc) from [<c0305354>] (_add_list_dev+0x30/0x58)
[<c0305354>] (_add_list_dev) from [<c0305d50>] (dev_pm_opp_set_sharing_cpus+0xd0/0x1e4)
[<c0305d50>] (dev_pm_opp_set_sharing_cpus) from [<c040eda4>] (cpufreq_init+0x4cc/0x62c)
[<c040eda4>] (cpufreq_init) from [<c040a964>] (cpufreq_online+0xbc/0x73c)
[<c040a964>] (cpufreq_online) from [<c02f4fe0>] (subsys_interface_register+0x98/0xdc)
[<c02f4fe0>] (subsys_interface_register) from [<c040a640>] (cpufreq_register_driver+0x110/0x17c)
[<c040a640>] (cpufreq_register_driver) from [<c040ef64>] (dt_cpufreq_probe+0x60/0x8c)
[<c040ef64>] (dt_cpufreq_probe) from [<c02f8084>] (platform_drv_probe+0x44/0xa4)
[<c02f8084>] (platform_drv_probe) from [<c02f67c0>] (driver_probe_device+0x208/0x2f4)
[<c02f67c0>] (driver_probe_device) from [<c02f6940>] (__driver_attach+0x94/0x98)
[<c02f6940>] (__driver_attach) from [<c02f4c1c>] (bus_for_each_dev+0x68/0x9c)

Cc: 4.3 <stable@vger.kernel.org> # 4.3
Reported-by: Michael Turquette <mturquette@baylibre.com>
Reviewed-by: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/base/power/opp/core.c | 2 +-
 drivers/base/power/opp/cpu.c  | 8 ++++----
 drivers/base/power/opp/opp.h  | 3 +++
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/base/power/opp/core.c b/drivers/base/power/opp/core.c
index 8fa522f41226..a93a433c9ac5 100644
--- a/drivers/base/power/opp/core.c
+++ b/drivers/base/power/opp/core.c
@@ -29,7 +29,7 @@
  */
 static LIST_HEAD(dev_opp_list);
 /* Lock to allow exclusive modification to the device and opp lists */
-static DEFINE_MUTEX(dev_opp_list_lock);
+DEFINE_MUTEX(dev_opp_list_lock);
 
 #define opp_rcu_lockdep_assert()					\
 do {									\
diff --git a/drivers/base/power/opp/cpu.c b/drivers/base/power/opp/cpu.c
index 2139c9d4c447..7b445e88a0d5 100644
--- a/drivers/base/power/opp/cpu.c
+++ b/drivers/base/power/opp/cpu.c
@@ -127,12 +127,12 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
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
@@ -153,8 +153,8 @@ int dev_pm_opp_set_sharing_cpus(struct device *cpu_dev, cpumask_var_t cpumask)
 			continue;
 		}
 	}
-out_rcu_read_unlock:
-	rcu_read_unlock();
+unlock:
+	mutex_unlock(&dev_opp_list_lock);
 
 	return ret;
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
