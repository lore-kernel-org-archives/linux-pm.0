From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [v6 PATCH 3/4] timers: /proc/sys sysctl hook to enable
	timer	migration
Date: Thu, 16 Apr 2009 12:15:34 +0530
Message-ID: <20090416064534.GD7510__32775.1883575276$1239864558$gmane$org@linux.vnet.ibm.com>
References: <20090416064136.GA7510@linux.vnet.ibm.com>
Reply-To: arun@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090416064136.GA7510@linux.vnet.ibm.com>
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
Cc: Chris Zankel <chris@zankel.net>, Jesper Nilsson <jesper.nilsson@axis.com>, Tony Luck <tony.luck@intel.com>, a.p.zijlstra@chello.nl, Richard Henderson <rth@twiddle.net>, vatsa@linux.vnet.ibm.com, Mikael Starvik <starvik@axis.com>, Arun Bharadwaj <arun@linux.vnet.ibm.com>, andi@firstfloor.org, Kyle McMartin <kyle@mcmartin.ca>, tglx@linutronix.de, mingo@elte.hu, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

* Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-04-16 12:11:36]:

This patch creates the /proc/sys sysctl interface at
/proc/sys/kernel/timer_migration

Timer migration is enabled by default.

To disable timer migration, when CONFIG_SCHED_DEBUG = y,

echo 0 > /proc/sys/kernel/timer_migration

Signed-off-by: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
---
 include/linux/sched.h |    1 +
 kernel/sched.c        |    2 ++
 kernel/sysctl.c       |    8 ++++++++
 3 files changed, 11 insertions(+)

Index: linux.trees.git/include/linux/sched.h
===================================================================
--- linux.trees.git.orig/include/linux/sched.h
+++ linux.trees.git/include/linux/sched.h
@@ -1763,6 +1763,7 @@ extern unsigned int sysctl_sched_child_r
 extern unsigned int sysctl_sched_features;
 extern unsigned int sysctl_sched_migration_cost;
 extern unsigned int sysctl_sched_nr_migrate;
+extern unsigned int sysctl_timer_migration;
 
 int sched_nr_latency_handler(struct ctl_table *table, int write,
 		struct file *file, void __user *buffer, size_t *length,
Index: linux.trees.git/kernel/sysctl.c
===================================================================
--- linux.trees.git.orig/kernel/sysctl.c
+++ linux.trees.git/kernel/sysctl.c
@@ -328,6 +328,14 @@ static struct ctl_table kern_table[] = {
 		.mode		= 0644,
 		.proc_handler	= &proc_dointvec,
 	},
+	{
+		.ctl_name	= CTL_UNNUMBERED,
+		.procname	= "timer_migration",
+		.data		= &sysctl_timer_migration,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
 #endif
 	{
 		.ctl_name	= CTL_UNNUMBERED,
Index: linux.trees.git/kernel/sched.c
===================================================================
--- linux.trees.git.orig/kernel/sched.c
+++ linux.trees.git/kernel/sched.c
@@ -8426,6 +8426,8 @@ void __init sched_init_smp(void)
 }
 #endif /* CONFIG_SMP */
 
+const_debug unsigned int sysctl_timer_migration = 1;
+
 int in_sched_functions(unsigned long addr)
 {
 	return in_lock_functions(addr) ||
