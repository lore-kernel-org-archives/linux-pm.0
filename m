From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [RFC PATCH 4/4] timers: logic to enable timer migration.
Date: Fri, 20 Feb 2009 18:31:31 +0530
Message-ID: <20090220130131.GD19762__9699.68997310406$1235135180$gmane$org@linux.vnet.ibm.com>
References: <20090220125516.GB10232@linux.vnet.ibm.com>
Reply-To: arun@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090220125516.GB10232@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org, linux-pm@lists.linux-foundation.org, a.p.zijlstra@chello.nl, ego@in.ibm.com, tglx@linutronix.de, mingo@elte.hu, andi@firstfloor.org, venkate
List-Id: linux-pm@vger.kernel.org

* Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-02-20 18:25:16]:

This patch migrates all non pinned timers and hrtimers to the target
CPU.

Timer migration is enabled by setting the sysfs entry of the
particular CPU. At the time of queuing a timer, it is checked to see
if migration is enabled for that particular CPU. If so, the target CPU
base is set as the new timer base and the timer is queued on that CPU.


Signed-off-by: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
---
 kernel/hrtimer.c |   12 +++++++++++-
 kernel/timer.c   |   15 ++++++++++++++-
 2 files changed, 25 insertions(+), 2 deletions(-)

Index: git-2.6/kernel/timer.c
===================================================================
--- git-2.6.orig/kernel/timer.c
+++ git-2.6/kernel/timer.c
@@ -616,7 +616,7 @@ int __mod_timer(struct timer_list *timer
 {
 	struct tvec_base *base, *new_base;
 	unsigned long flags;
-	int ret = 0;
+	int ret = 0, target_cpu;
 
 	timer_stats_timer_set_start_info(timer);
 	BUG_ON(!timer->function);
@@ -631,6 +631,18 @@ int __mod_timer(struct timer_list *timer
 	debug_timer_activate(timer);
 
 	new_base = __get_cpu_var(tvec_bases);
+	/*
+	 * @target_cpu: The CPU to which timers are to be migrated.
+	 * If timer migration is disabled, target_cpu = this_cpu.
+	 */
+	target_cpu = __get_cpu_var(enable_timer_migration);
+	if (!tbase_get_pinned(timer->base) && cpu_online(target_cpu)) {
+		new_base = per_cpu(tvec_bases, target_cpu);
+		timer_set_base(timer, new_base);
+		timer->expires = expires;
+		internal_add_timer(new_base, timer);
+		goto out;
+	}
 
 	if (base != new_base) {
 		/*
@@ -652,6 +664,7 @@ int __mod_timer(struct timer_list *timer
 
 	timer->expires = expires;
 	internal_add_timer(base, timer);
+out:
 	spin_unlock_irqrestore(&base->lock, flags);
 
 	return ret;
Index: git-2.6/kernel/hrtimer.c
===================================================================
--- git-2.6.orig/kernel/hrtimer.c
+++ git-2.6/kernel/hrtimer.c
@@ -198,8 +198,18 @@ int pinned)
 {
 	struct hrtimer_clock_base *new_base;
 	struct hrtimer_cpu_base *new_cpu_base;
+	int target_cpu;
+
+	/*
+	 * @target_cpu: CPU to which the timers are to be migrated.
+	 * If timer migration is disabled, target_cpu = this_cpu
+	 */
+	target_cpu = __get_cpu_var(enable_timer_migration);
+	if (cpu_online(target_cpu) && !pinned)
+		new_cpu_base = &per_cpu(hrtimer_bases, target_cpu);
+	else
+		new_cpu_base = &__get_cpu_var(hrtimer_bases);
 
-	new_cpu_base = &__get_cpu_var(hrtimer_bases);
 	new_base = &new_cpu_base->clock_base[base->index];
 
 	if (base != new_base) {
