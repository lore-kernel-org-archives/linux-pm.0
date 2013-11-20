From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH 7/7] preempt: Take away preempt_enable_no_resched() from modules
Date: Wed, 20 Nov 2013 17:04:57 +0100
Message-ID: <20131120162736.760865926@infradead.org>
References: <20131120160450.072555619@infradead.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline; filename=peterz-hide-preempt_enable_no_resched-modules.patch
Sender: linux-kernel-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>, lenb@kernel.org, rjw@rjwysocki.net, Eliezer Tamir <eliezer.tamir@linux.intel.com>, Chris Leech <christopher.leech@intel.com>, David Miller <davem@davemloft.net>, rui.zhang@intel.com, jacob.jun.pan@linux.intel.com, Mike Galbraith <bitbucket@online.de>, Ingo Molnar <mingo@kernel.org>, hpa@zytor.com, Thomas Gleixner <tglx@linutronix.de>, Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rusty Russell <rusty@rustcorp.com.au>
List-Id: linux-pm@vger.kernel.org

Discourage drivers/modules to be creative with preemption.

Sadly all is implemented in macros and inline so if they want to do
evil they still can, but at least try and discourage some.

Cc: Rusty Russell <rusty@rustcorp.com.au>
Cc: Arjan van de Ven <arjan@linux.intel.com>
Cc: lenb@kernel.org
Cc: rjw@rjwysocki.net
Cc: Eliezer Tamir <eliezer.tamir@linux.intel.com>
Cc: Chris Leech <christopher.leech@intel.com>
Cc: David S. Miller <davem@davemloft.net>
Cc: rui.zhang@intel.com
Cc: jacob.jun.pan@linux.intel.com
Cc: Mike Galbraith <bitbucket@online.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: hpa@zytor.com
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
---
 include/linux/preempt.h |   16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -64,7 +64,11 @@ do { \
 } while (0)
 
 #else
-#define preempt_enable() preempt_enable_no_resched()
+#define preempt_enable() \
+do { \
+	barrier(); \
+	preempt_count_dec(); \
+} while (0)
 #define preempt_check_resched() do { } while (0)
 #endif
 
@@ -126,6 +130,16 @@ do { \
 #define preempt_fold_need_resched() do { } while (0)
 #endif
 
+#ifdef MODULE
+/*
+ * Modules have no business playing preemption tricks.
+ */
+#undef sched_preempt_enable_no_resched
+#undef preempt_enable_no_resched
+#undef preempt_enable_no_resched_notrace
+#undef preempt_check_resched
+#endif
+
 #ifdef CONFIG_PREEMPT_NOTIFIERS
 
 struct preempt_notifier;
