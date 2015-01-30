From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Set cpufreq_cpu_data to NULL before putting kobject
Date: Fri, 30 Jan 2015 06:43:12 +0530
Message-ID: <ed8fd187687cb4ea9afd0bc32107ca5abf03e679.1422580135.git.viresh.kumar@linaro.org>
Return-path: <stable-owner@vger.kernel.org>
Sender: stable-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, santosh.shilimkar@oracle.com, ethan.zhao@oracle.com
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

cpufreq_cpu_data is protected by cpufreq_driver_lock and one of the instances
has missed this. And as a result we get this:

 ------------[ cut here ]------------
 WARNING: CPU: 0 PID: 4 at include/linux/kref.h:47
 kobject_get+0x41/0x50()
 Modules linked in: acpi_cpufreq(+) nfsd auth_rpcgss nfs_acl
 lockd grace sunrpc xfs libcrc32c sd_mod ixgbe igb mdio ahci hwmon
 ...
 Call Trace:
  [<ffffffff81661b14>] dump_stack+0x46/0x58
  [<ffffffff81072b61>] warn_slowpath_common+0x81/0xa0
  [<ffffffff81072c7a>] warn_slowpath_null+0x1a/0x20
  [<ffffffff812e16d1>] kobject_get+0x41/0x50
  [<ffffffff815262a5>] cpufreq_cpu_get+0x75/0xc0
  [<ffffffff81527c3e>] cpufreq_update_policy+0x2e/0x1f0
  [<ffffffff810b8cb2>] ? up+0x32/0x50
  [<ffffffff81381aa9>] ? acpi_ns_get_node+0xcb/0xf2
  [<ffffffff81381efd>] ? acpi_evaluate_object+0x22c/0x252
  [<ffffffff813824f6>] ? acpi_get_handle+0x95/0xc0
  [<ffffffff81360967>] ? acpi_has_method+0x25/0x40
  [<ffffffff81391e08>] acpi_processor_ppc_has_changed+0x77/0x82
  [<ffffffff81089566>] ? move_linked_works+0x66/0x90
  [<ffffffff8138e8ed>] acpi_processor_notify+0x58/0xe7
  [<ffffffff8137410c>] acpi_ev_notify_dispatch+0x44/0x5c
  [<ffffffff8135f293>] acpi_os_execute_deferred+0x15/0x22
  [<ffffffff8108c910>] process_one_work+0x160/0x410
  [<ffffffff8108d05b>] worker_thread+0x11b/0x520
  [<ffffffff8108cf40>] ? rescuer_thread+0x380/0x380
  [<ffffffff81092421>] kthread+0xe1/0x100
  [<ffffffff81092340>] ? kthread_create_on_node+0x1b0/0x1b0
  [<ffffffff81669ebc>] ret_from_fork+0x7c/0xb0
  [<ffffffff81092340>] ? kthread_create_on_node+0x1b0/0x1b0
 ---[ end trace 89e66eb9795efdf7 ]---

And here is the race:

 Thread A: Workqueue: kacpi_notify

 acpi_processor_notify()
   acpi_processor_ppc_has_changed()
         cpufreq_update_policy()
           cpufreq_cpu_get()
             kobject_get()

 Thread B: xenbus_thread()

 xenbus_thread()
   msg->u.watch.handle->callback()
     handle_vcpu_hotplug_event()
       vcpu_hotplug()
         cpu_down()
           __cpu_notify(CPU_POST_DEAD..)
             cpufreq_cpu_callback()
               __cpufreq_remove_dev_finish()
                 cpufreq_policy_put_kobj()
                   kobject_put()

cpufreq_cpu_get() gets the policy from per-cpu variable cpufreq_cpu_data under
cpufreq_driver_lock, and once it gets a valid policy it expects it to not be
freed until cpufreq_cpu_put() is called.

But the race happens when another thread puts the kobject first and updates
cpufreq_cpu_data later and that too without these locks. And so the first thread
gets a valid policy structure and before it does kobject_get() on it, the second
one does kobject_put(). And so this WARN().

Fix this by setting cpufreq_cpu_data to NULL before putting the kobject and that
too under locks.

Cc: <stable@vger.kernel.org>        # 3.12+
Reported-by: Ethan Zhao <ethan.zhao@oracle.com>
Reported-and-tested-by: Santosh Shilimkar <santosh.shilimkar@oracle.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
@Santosh: I have changed read locks to write locks here and so you need to test
again.

 drivers/cpufreq/cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 4473eba1d6b0..e3bf702b5588 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1409,9 +1409,10 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 	unsigned long flags;
 	struct cpufreq_policy *policy;
 
-	read_lock_irqsave(&cpufreq_driver_lock, flags);
+	write_lock_irqsave(&cpufreq_driver_lock, flags);
 	policy = per_cpu(cpufreq_cpu_data, cpu);
-	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
+	per_cpu(cpufreq_cpu_data, cpu) = NULL;
+	write_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
 	if (!policy) {
 		pr_debug("%s: No cpu_data found\n", __func__);
@@ -1466,7 +1467,6 @@ static int __cpufreq_remove_dev_finish(struct device *dev,
 		}
 	}
 
-	per_cpu(cpufreq_cpu_data, cpu) = NULL;
 	return 0;
 }
 
-- 
2.3.0.rc0.44.ga94655d
