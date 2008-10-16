From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [RFC PATCH 4/4] timers: Migrating non pinned regular and
	hrtimers.
Date: Thu, 16 Oct 2008 17:22:19 +0530
Message-ID: <20081016115219.GE7641__17396.8207127929$1224158187$gmane$org@linux.vnet.ibm.com>
Reply-To: arun@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: a.p.zijlstra@chello.nl, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, arun@linux.vnet.ibm.com, tglx@linutronix.de, mingo@elte.hu, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

This patch migrates all the non cpu-pinned regular and hrtimers
from a particular cpu to the target cpu specified.

The migration is triggered by setting the target cpu number at
/sys/devices/system/cpu/cpuX/timer_migration.

In the situation where the cpuX goes offline *after* the user sets
X as the target_cpu, then timers are not migrated and stay on
the source cpu. But this is just a short term fix and any discussion
in this regard will help greatly.

I have tested this patch by stressing the system using a script
which continuously hotplug-add and removes the cpus.


Signed-off-by: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
---
 kernel/hrtimer.c |    6 ++++++
 kernel/timer.c   |    7 ++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

Index: linux-2.6.27/kernel/timer.c
===================================================================
--- linux-2.6.27.orig/kernel/timer.c
+++ linux-2.6.27/kernel/timer.c
@@ -547,7 +547,7 @@ int __mod_timer(struct timer_list *timer
 {
 	struct tvec_base *base, *new_base;
 	unsigned long flags;
-	int ret = 0;
+	int ret = 0, target_cpu;
 
 	timer_stats_timer_set_start_info(timer);
 	BUG_ON(!timer->function);
@@ -562,6 +562,11 @@ int __mod_timer(struct timer_list *timer
 	debug_timer_activate(timer);
 
 	new_base = __get_cpu_var(tvec_bases);
+	target_cpu = __get_cpu_var(enable_timer_migration);
+	if (target_cpu != smp_processor_id() && !tbase_get_pinned(timer->base)
+			&& cpu_online(target_cpu))
+		new_base = per_cpu(tvec_bases, target_cpu);
+
 
 	if (base != new_base) {
 		/*
Index: linux-2.6.27/kernel/hrtimer.c
===================================================================
--- linux-2.6.27.orig/kernel/hrtimer.c
+++ linux-2.6.27/kernel/hrtimer.c
@@ -206,8 +206,14 @@ switch_hrtimer_base(struct hrtimer *time
 {
 	struct hrtimer_clock_base *new_base;
 	struct hrtimer_cpu_base *new_cpu_base;
+	int target_cpu;
 
 	new_cpu_base = &__get_cpu_var(hrtimer_bases);
+	target_cpu = __get_cpu_var(enable_timer_migration);
+	if (target_cpu != smp_processor_id() && !is_hrtimer_pinned(timer)
+			&& cpu_online(target_cpu))
+		new_cpu_base = &per_cpu(hrtimer_bases, target_cpu);
+
 	new_base = &new_cpu_base->clock_base[base->index];
 
 	if (base != new_base) {
