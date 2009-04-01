From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [v4 RFC PATCH 3/4] timers: /proc/sys sysctl hook to
	enable timer	migration
Date: Wed, 1 Apr 2009 17:06:05 +0530
Message-ID: <20090401113605.GD22478__26461.2847161063$1238586320$gmane$org@linux.vnet.ibm.com>
References: <20090401113128.GA22478@linux.vnet.ibm.com>
Reply-To: arun@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090401113128.GA22478@linux.vnet.ibm.com>
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
Cc: a.p.zijlstra@chello.nl, vatsa@linux.vnet.ibm.com, andi@firstfloor.org, Arun Bharadwaj <arun@linux.vnet.ibm.com>, tglx@linutronix.de, mingo@elte.hu, arjan@infradead.org
List-Id: linux-pm@vger.kernel.org

* Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-04-01 17:01:28]:

This patch creates the /proc/sys sysctl interface at
/proc/sys/kernel/timer_migration

Timer migration is enabled by default.

To disable timer migration, when CONFIG_SCHED_DEBUG = y,

echo 0 > /proc/sys/kernel/timer_migration

Signed-off-by: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
---
 include/linux/sched.h |    1 +
 kernel/sched.c        |    1 +
 kernel/sysctl.c       |    8 ++++++++
 3 files changed, 10 insertions(+)

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
@@ -7445,6 +7445,7 @@ static void sched_domain_node_span(int n
 #endif /* CONFIG_NUMA */
 
 int sched_smt_power_savings = 0, sched_mc_power_savings = 0;
+const_debug unsigned int sysctl_timer_migration = 1;
 
 /*
  * The cpus mask in sched_group and sched_domain hangs off the end.
