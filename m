From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] sched: core: Fix comment regarding nr_iowait_cpu() and get_iowait_load()
Date: Thu, 04 Oct 2018 11:05:14 +0200
Message-ID: <3803514.xkx7zY50tF@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Tejun Heo <tj@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

The comment related to nr_iowait_cpu() and get_iowait_load() confuses
cpufreq with cpuidle and is not very useful for this reason, so fix it.

Fixes: e33a9bba85a8 "sched/core: move IO scheduling accounting from io_schedule_timeout() into scheduler"
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 kernel/sched/core.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-pm/kernel/sched/core.c
===================================================================
--- linux-pm.orig/kernel/sched/core.c
+++ linux-pm/kernel/sched/core.c
@@ -2915,10 +2915,10 @@ unsigned long nr_iowait(void)
 }
 
 /*
- * Consumers of these two interfaces, like for example the cpufreq menu
- * governor are using nonsensical data. Boosting frequency for a CPU that has
- * IO-wait which might not even end up running the task when it does become
- * runnable.
+ * Consumers of these two interfaces, like for example the cpuidle menu
+ * governor, are using nonsensical data. Preferring shallow idle state selection
+ * for a CPU that has IO-wait which might not even end up running the task when
+ * it does become runnable.
  */
 
 unsigned long nr_iowait_cpu(int cpu)
