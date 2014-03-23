From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch 15/16] cpufreq: intel-pstate: Use del_timer_sync in
 intel_pstate_cpu_exit()
Date: Sun, 23 Mar 2014 15:09:32 -0000
Message-ID: <20140323150754.272874059@linutronix.de>
References: <20140323150557.288925975@linutronix.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline;
 filename=cpufreq-intel-pstate-use-del_timer_sync.patch
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, cpufreq <cpufreq@vger.kernel.org>, pm <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

We are about to free the data structure. Make sure no timer callback
is running. I might be paranoid, but the ->exit callback can be
invoked from so many places, that it is not entirely clear whether
del_timer is always called on the cpu on which it is enqueued.

While looking through the call sites I noticed, that
cpufreq_init_policy() can fail and invoke cpufreq_driver->exit() but
it does not return the failure and the callsite happily proceeds.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: cpufreq <cpufreq@vger.kernel.org>
Cc: pm <linux-pm@vger.kernel.org>
---

 drivers/cpufreq/intel_pstate.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: tip/drivers/cpufreq/intel_pstate.c
===================================================================
--- tip.orig/drivers/cpufreq/intel_pstate.c
+++ tip/drivers/cpufreq/intel_pstate.c
@@ -777,7 +777,7 @@ static int intel_pstate_cpu_exit(struct
 {
 	int cpu = policy->cpu;
 
-	del_timer(&all_cpu_data[cpu]->timer);
+	del_timer_sync(&all_cpu_data[cpu]->timer);
 	kfree(all_cpu_data[cpu]);
 	all_cpu_data[cpu] = NULL;
 	return 0;
