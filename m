From: Arjan van de Ven <arjan@infradead.org>
Subject: [PATCH] suspend: add initcall_debug style timing for
	suspend/resume
Date: Sun, 6 Dec 2009 12:35:52 -0800
Message-ID: <20091206123552.7be316b2__38430.3478910171$1260131711$gmane$org@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


>From fcd52b97aa02f19baa570e4a62dfdfab0faed976 Mon Sep 17 00:00:00 2001
From: Arjan van de Ven <arjan@linux.intel.com>
Date: Sun, 6 Dec 2009 12:32:28 -0800
Subject: [PATCH] suspend: add initcall_debug style timing for suspend/resume

In order to diagnose overall suspend/resume times, we need
basic instrumentation to break down the total time into per
device timing, similar to initcall_debug.

This patch adds the basic timing instrumentation, needed
for a scritps/bootgraph.pl equivalent or humans.
The bootgraph.pl program is still a work in progress, but
is far enough along to know that this patch is sufficient.

Signed-off-by: Arjan van de Ven <arjan@linux.intel.com>
---
 drivers/base/power/main.c |   29 +++++++++++++++++++++++++++++
 include/linux/init.h      |    2 ++
 2 files changed, 31 insertions(+), 0 deletions(-)

diff --git a/drivers/base/power/main.c b/drivers/base/power/main.c
index 8aa2443..2ad345c 100644
--- a/drivers/base/power/main.c
+++ b/drivers/base/power/main.c
@@ -25,6 +25,7 @@
 #include <linux/resume-trace.h>
 #include <linux/rwsem.h>
 #include <linux/interrupt.h>
+#include <linux/sched.h>
 
 #include "../base.h"
 #include "power.h"
@@ -172,6 +173,12 @@ static int pm_op(struct device *dev,
 		 pm_message_t state)
 {
 	int error = 0;
+	ktime_t calltime, delta, rettime;
+
+	if (initcall_debug) {
+		printk("calling  %s+ @ %i\n", dev_name(dev), task_pid_nr(current));
+		calltime = ktime_get();
+	}
 
 	switch (state.event) {
 #ifdef CONFIG_SUSPEND
@@ -219,6 +226,14 @@ static int pm_op(struct device *dev,
 	default:
 		error = -EINVAL;
 	}
+
+	if (initcall_debug) {
+		rettime = ktime_get();
+		delta = ktime_sub(rettime, calltime);
+		printk("initcall %s+ returned %d after %Ld usecs\n", dev_name(dev),
+			error, (unsigned long long) ktime_to_ns(delta) >> 10);
+	}
+
 	return error;
 }
 
@@ -236,6 +251,12 @@ static int pm_noirq_op(struct device *dev,
 			pm_message_t state)
 {
 	int error = 0;
+	ktime_t calltime, delta, rettime;
+
+	if (initcall_debug) {
+		printk("calling  %s_i+ @ %i\n", dev_name(dev), task_pid_nr(current));
+		calltime = ktime_get();
+	}
 
 	switch (state.event) {
 #ifdef CONFIG_SUSPEND
@@ -283,6 +304,14 @@ static int pm_noirq_op(struct device *dev,
 	default:
 		error = -EINVAL;
 	}
+
+	if (initcall_debug) {
+		rettime = ktime_get();
+		delta = ktime_sub(rettime, calltime);
+		printk("initcall %s_i+ returned %d after %Ld usecs\n", dev_name(dev),
+			error, (unsigned long long) ktime_to_ns(delta) >> 10);
+	}
+
 	return error;
 }
 
diff --git a/include/linux/init.h b/include/linux/init.h
index ff8bde5..ab1d31f 100644
--- a/include/linux/init.h
+++ b/include/linux/init.h
@@ -149,6 +149,8 @@ void prepare_namespace(void);
 
 extern void (*late_time_init)(void);
 
+extern int initcall_debug;
+
 #endif
   
 #ifndef MODULE
-- 
1.6.2.5


-- 
Arjan van de Ven 	Intel Open Source Technology Centre
For development, discussion and tips for power savings, 
visit http://www.lesswatts.org
