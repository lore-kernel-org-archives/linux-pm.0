From: kpark3469@gmail.com
Subject: [PATCH v2 1/4] PM / tracing: Add pm_qos_update_target/flags tracepoints
Date: Fri, 21 Jun 2013 11:12:28 +0900
Message-ID: <1371780751-16576-1-git-send-email-kpark3469@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:33234 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161377Ab3FUCMw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2013 22:12:52 -0400
Received: by mail-bk0-f46.google.com with SMTP id na10so3142727bkb.33
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2013 19:12:50 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: keun-o.park@windriver.com, len.brown@intel.com, rjw@sisk.pl, rostedt@goodmis.org

From: Sahara <keun-o.park@windriver.com>

This patch adds tracepoints to pm_qos_update_target and
pm_qos_update_flags. It's useful for checking pm qos action,
previous value and current value.

Signed-off-by: Sahara <keun-o.park@windriver.com>
---
 include/trace/events/power.h |   51 ++++++++++++++++++++++++++++++++++++++++++
 kernel/power/qos.c           |    3 ++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 427acab..f1e73bd 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -5,6 +5,7 @@
 #define _TRACE_POWER_H
 
 #include <linux/ktime.h>
+#include <linux/pm_qos.h>
 #include <linux/tracepoint.h>
 
 DECLARE_EVENT_CLASS(cpu,
@@ -177,6 +178,56 @@ DEFINE_EVENT(power_domain, power_domain_target,
 
 	TP_ARGS(name, state, cpu_id)
 );
+
+/*
+ * The pm qos events are used for pm qos update
+ */
+DECLARE_EVENT_CLASS(pm_qos_update,
+
+	TP_PROTO(enum pm_qos_req_action action, int prev_value, int curr_value),
+
+	TP_ARGS(action, prev_value, curr_value),
+
+	TP_STRUCT__entry(
+		__field( enum pm_qos_req_action, action         )
+		__field( int,                    prev_value     )
+		__field( int,                    curr_value     )
+	),
+
+	TP_fast_assign(
+		__entry->action = action;
+		__entry->prev_value = prev_value;
+		__entry->curr_value = curr_value;
+	),
+
+	TP_printk("action=%s prev_value=%d curr_value=%d",
+		  __print_symbolic(__entry->action,
+			{ PM_QOS_ADD_REQ,	"ADD_REQ" },
+			{ PM_QOS_UPDATE_REQ,	"UPDATE_REQ" },
+			{ PM_QOS_REMOVE_REQ,	"REMOVE_REQ" }),
+		  __entry->prev_value, __entry->curr_value)
+);
+
+DEFINE_EVENT(pm_qos_update, pm_qos_update_target,
+
+	TP_PROTO(enum pm_qos_req_action action, int prev_value, int curr_value),
+
+	TP_ARGS(action, prev_value, curr_value)
+);
+
+DEFINE_EVENT_PRINT(pm_qos_update, pm_qos_update_flags,
+
+	TP_PROTO(enum pm_qos_req_action action, int prev_value, int curr_value),
+
+	TP_ARGS(action, prev_value, curr_value),
+
+	TP_printk("action=%s prev_value=0x%x curr_value=0x%x",
+		  __print_symbolic(__entry->action,
+			{ PM_QOS_ADD_REQ,	"ADD_REQ" },
+			{ PM_QOS_UPDATE_REQ,	"UPDATE_REQ" },
+			{ PM_QOS_REMOVE_REQ,	"REMOVE_REQ" }),
+		  __entry->prev_value, __entry->curr_value)
+);
 #endif /* _TRACE_POWER_H */
 
 /* This part must be outside protection */
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index f2f5f6e..4fb8d14 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -44,6 +44,7 @@
 
 #include <linux/uaccess.h>
 #include <linux/export.h>
+#include <trace/events/power.h>
 
 /*
  * locking rule: all changes to constraints or notifiers lists
@@ -202,6 +203,7 @@ int pm_qos_update_target(struct pm_qos_constraints *c, struct plist_node *node,
 
 	spin_unlock_irqrestore(&pm_qos_lock, flags);
 
+	trace_pm_qos_update_target(action, prev_value, curr_value);
 	if (prev_value != curr_value) {
 		blocking_notifier_call_chain(c->notifiers,
 					     (unsigned long)curr_value,
@@ -272,6 +274,7 @@ bool pm_qos_update_flags(struct pm_qos_flags *pqf,
 
 	spin_unlock_irqrestore(&pm_qos_lock, irqflags);
 
+	trace_pm_qos_update_flags(action, prev_value, curr_value);
 	return prev_value != curr_value;
 }
 
-- 
1.7.1

