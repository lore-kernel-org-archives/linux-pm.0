From: Chuansheng Liu <chuansheng.liu@intel.com>
Subject: [PATCH 2/3] smp: re-implement the kick_all_cpus_sync() with wake_up_if_idle()
Date: Fri, 15 Aug 2014 15:01:24 +0800
Message-ID: <1408086085-16691-2-git-send-email-chuansheng.liu@intel.com>
References: <1408086085-16691-1-git-send-email-chuansheng.liu@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1408086085-16691-1-git-send-email-chuansheng.liu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: peterz@infradead.org, luto@amacapital.net, daniel.lezcano@linaro.org, rjw@rjwysocki.net, mingo@redhat.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, changcheng.liu@intel.com, xiaoming.wang@intel.com, souvik.k.chakravarty@intel.com, Chuansheng Liu <chuansheng.liu@intel.com>
List-Id: linux-pm@vger.kernel.org

Currently using smp_call_function() just woke up the corresponding
cpu, but can not break the polling idle loop.

Here using the new sched API wake_up_if_idle() to implement it.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
---
 kernel/smp.c |   18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/kernel/smp.c b/kernel/smp.c
index aff8aa1..0b647c3 100644
--- a/kernel/smp.c
+++ b/kernel/smp.c
@@ -13,6 +13,7 @@
 #include <linux/gfp.h>
 #include <linux/smp.h>
 #include <linux/cpu.h>
+#include <linux/sched.h>
 
 #include "smpboot.h"
 
@@ -677,10 +678,6 @@ void on_each_cpu_cond(bool (*cond_func)(int cpu, void *info),
 }
 EXPORT_SYMBOL(on_each_cpu_cond);
 
-static void do_nothing(void *unused)
-{
-}
-
 /**
  * kick_all_cpus_sync - Force all cpus out of idle
  *
@@ -694,8 +691,15 @@ static void do_nothing(void *unused)
  */
 void kick_all_cpus_sync(void)
 {
-	/* Make sure the change is visible before we kick the cpus */
-	smp_mb();
-	smp_call_function(do_nothing, NULL, 1);
+	int cpu;
+
+	preempt_disable();
+	for_each_online_cpu(cpu) {
+		if (cpu == smp_processor_id())
+			continue;
+
+		wake_up_if_idle(cpu);
+	}
+	preempt_enable();
 }
 EXPORT_SYMBOL_GPL(kick_all_cpus_sync);
-- 
1.7.9.5
