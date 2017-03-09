From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [RFC 2/9] irq_work: add irq_work_queue_on for !CONFIG_SMP
Date: Thu,  9 Mar 2017 17:15:12 +0530
Message-ID: <85403db254e26655d608137d7df49ebf3aade0c3.1489058244.git.viresh.kumar@linaro.org>
References: <cover.1489058244.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1489058244.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489058244.git.viresh.kumar@linaro.org>
References: <cover.1489058244.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, smuckle.linux@gmail.com, juri.lelli@arm.com, Morten.Rasmussen@arm.com, patrick.bellasi@arm.com, eas-dev@lists.linaro.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Steve Muckle <smuckle.linux@gmail.com>

Having irq_work_queue_on() available for !CONFIG_SMP can make some
call sites cleaner.

Signed-off-by: Steve Muckle <smuckle.linux@gmail.com>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/irq_work.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index 47b9ebd4a74f..0195c3502d6b 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -1,6 +1,7 @@
 #ifndef _LINUX_IRQ_WORK_H
 #define _LINUX_IRQ_WORK_H
 
+#include <linux/bug.h>
 #include <linux/llist.h>
 
 /*
@@ -36,6 +37,12 @@ bool irq_work_queue(struct irq_work *work);
 
 #ifdef CONFIG_SMP
 bool irq_work_queue_on(struct irq_work *work, int cpu);
+#else
+static inline bool irq_work_queue_on(struct irq_work *work, int cpu)
+{
+	BUG_ON(cpu != 0);
+	return irq_work_queue(work);
+}
 #endif
 
 void irq_work_tick(void);
-- 
2.7.1.410.g6faf27b
