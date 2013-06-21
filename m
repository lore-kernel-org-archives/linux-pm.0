From: kpark3469@gmail.com
Subject: [PATCH v2 2/4] PM / tracing: Add pm_qos_request tracepoints
Date: Fri, 21 Jun 2013 11:12:29 +0900
Message-ID: <1371780751-16576-2-git-send-email-kpark3469@gmail.com>
References: <1371780751-16576-1-git-send-email-kpark3469@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f42.google.com ([209.85.214.42]:33770 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161377Ab3FUCNA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2013 22:13:00 -0400
Received: by mail-bk0-f42.google.com with SMTP id jk13so3219767bkc.15
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2013 19:12:58 -0700 (PDT)
In-Reply-To: <1371780751-16576-1-git-send-email-kpark3469@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: keun-o.park@windriver.com, len.brown@intel.com, rjw@sisk.pl, rostedt@goodmis.org

From: Sahara <keun-o.park@windriver.com>

Adds tracepoints to pm_qos_add_request, pm_qos_update_request,
pm_qos_remove_request, and pm_qos_update_request_timeout.
It's useful for checking pm_qos_class, value, and timeout_us.

Signed-off-by: Sahara <keun-o.park@windriver.com>
---
 include/trace/events/power.h |   71 ++++++++++++++++++++++++++++++++++++++++++
 kernel/power/qos.c           |    5 +++
 2 files changed, 76 insertions(+), 0 deletions(-)

diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index f1e73bd..6411f92 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -182,6 +182,77 @@ DEFINE_EVENT(power_domain, power_domain_target,
 /*
  * The pm qos events are used for pm qos update
  */
+DECLARE_EVENT_CLASS(pm_qos_request,
+
+	TP_PROTO(int pm_qos_class, s32 value),
+
+	TP_ARGS(pm_qos_class, value),
+
+	TP_STRUCT__entry(
+		__field( int,                    pm_qos_class   )
+		__field( s32,                    value          )
+	),
+
+	TP_fast_assign(
+		__entry->pm_qos_class = pm_qos_class;
+		__entry->value = value;
+	),
+
+	TP_printk("pm_qos_class=%s value=%d",
+		  __print_symbolic(__entry->pm_qos_class,
+			{ PM_QOS_CPU_DMA_LATENCY,	"CPU_DMA_LATENCY" },
+			{ PM_QOS_NETWORK_LATENCY,	"NETWORK_LATENCY" },
+			{ PM_QOS_NETWORK_THROUGHPUT,	"NETWORK_THROUGHPUT" }),
+		  __entry->value)
+);
+
+DEFINE_EVENT(pm_qos_request, pm_qos_add_request,
+
+	TP_PROTO(int pm_qos_class, s32 value),
+
+	TP_ARGS(pm_qos_class, value)
+);
+
+DEFINE_EVENT(pm_qos_request, pm_qos_update_request,
+
+	TP_PROTO(int pm_qos_class, s32 value),
+
+	TP_ARGS(pm_qos_class, value)
+);
+
+DEFINE_EVENT(pm_qos_request, pm_qos_remove_request,
+
+	TP_PROTO(int pm_qos_class, s32 value),
+
+	TP_ARGS(pm_qos_class, value)
+);
+
+TRACE_EVENT(pm_qos_update_request_timeout,
+
+	TP_PROTO(int pm_qos_class, s32 value, unsigned long timeout_us),
+
+	TP_ARGS(pm_qos_class, value, timeout_us),
+
+	TP_STRUCT__entry(
+		__field( int,                    pm_qos_class   )
+		__field( s32,                    value          )
+		__field( unsigned long,          timeout_us     )
+	),
+
+	TP_fast_assign(
+		__entry->pm_qos_class = pm_qos_class;
+		__entry->value = value;
+		__entry->timeout_us = timeout_us;
+	),
+
+	TP_printk("pm_qos_class=%s value=%d, timeout_us=%ld",
+		  __print_symbolic(__entry->pm_qos_class,
+			{ PM_QOS_CPU_DMA_LATENCY,	"CPU_DMA_LATENCY" },
+			{ PM_QOS_NETWORK_LATENCY,	"NETWORK_LATENCY" },
+			{ PM_QOS_NETWORK_THROUGHPUT,	"NETWORK_THROUGHPUT" }),
+		  __entry->value, __entry->timeout_us)
+);
+
 DECLARE_EVENT_CLASS(pm_qos_update,
 
 	TP_PROTO(enum pm_qos_req_action action, int prev_value, int curr_value),
diff --git a/kernel/power/qos.c b/kernel/power/qos.c
index 4fb8d14..06fe285 100644
--- a/kernel/power/qos.c
+++ b/kernel/power/qos.c
@@ -336,6 +336,7 @@ void pm_qos_add_request(struct pm_qos_request *req,
 	}
 	req->pm_qos_class = pm_qos_class;
 	INIT_DELAYED_WORK(&req->work, pm_qos_work_fn);
+	trace_pm_qos_add_request(pm_qos_class, value);
 	pm_qos_update_target(pm_qos_array[pm_qos_class]->constraints,
 			     &req->node, PM_QOS_ADD_REQ, value);
 }
@@ -364,6 +365,7 @@ void pm_qos_update_request(struct pm_qos_request *req,
 
 	cancel_delayed_work_sync(&req->work);
 
+	trace_pm_qos_update_request(req->pm_qos_class, new_value);
 	if (new_value != req->node.prio)
 		pm_qos_update_target(
 			pm_qos_array[req->pm_qos_class]->constraints,
@@ -390,6 +392,8 @@ void pm_qos_update_request_timeout(struct pm_qos_request *req, s32 new_value,
 
 	cancel_delayed_work_sync(&req->work);
 
+	trace_pm_qos_update_request_timeout(req->pm_qos_class,
+					    new_value, timeout_us);
 	if (new_value != req->node.prio)
 		pm_qos_update_target(
 			pm_qos_array[req->pm_qos_class]->constraints,
@@ -419,6 +423,7 @@ void pm_qos_remove_request(struct pm_qos_request *req)
 
 	cancel_delayed_work_sync(&req->work);
 
+	trace_pm_qos_remove_request(req->pm_qos_class, PM_QOS_DEFAULT_VALUE);
 	pm_qos_update_target(pm_qos_array[req->pm_qos_class]->constraints,
 			     &req->node, PM_QOS_REMOVE_REQ,
 			     PM_QOS_DEFAULT_VALUE);
-- 
1.7.1

