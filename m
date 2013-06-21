From: kpark3469@gmail.com
Subject: [PATCH v2 3/4] PM / tracing: Add dev_pm_qos_request tracepoints
Date: Fri, 21 Jun 2013 11:12:30 +0900
Message-ID: <1371780751-16576-3-git-send-email-kpark3469@gmail.com>
References: <1371780751-16576-1-git-send-email-kpark3469@gmail.com>
 <1371780751-16576-2-git-send-email-kpark3469@gmail.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f51.google.com ([209.85.214.51]:42264 "EHLO
	mail-bk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422845Ab3FUCNI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 20 Jun 2013 22:13:08 -0400
Received: by mail-bk0-f51.google.com with SMTP id ji1so3154086bkc.24
        for <linux-pm@vger.kernel.org>; Thu, 20 Jun 2013 19:13:05 -0700 (PDT)
In-Reply-To: <1371780751-16576-2-git-send-email-kpark3469@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: keun-o.park@windriver.com, len.brown@intel.com, rjw@sisk.pl, rostedt@goodmis.org

From: Sahara <keun-o.park@windriver.com>

Adds tracepoints to dev_pm_qos_add_request, dev_pm_qos_update_request,
and dev_pm_qos_remove_request.  It's useful for checking device name,
dev_pm_qos_request_type, and value.

Signed-off-by: Sahara <keun-o.park@windriver.com>
---
 drivers/base/power/qos.c     |    6 +++++
 include/trace/events/power.h |   51 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 57 insertions(+), 0 deletions(-)

diff --git a/drivers/base/power/qos.c b/drivers/base/power/qos.c
index 71671c4..5c1361a 100644
--- a/drivers/base/power/qos.c
+++ b/drivers/base/power/qos.c
@@ -42,6 +42,7 @@
 #include <linux/export.h>
 #include <linux/pm_runtime.h>
 #include <linux/err.h>
+#include <trace/events/power.h>
 
 #include "power.h"
 
@@ -305,6 +306,7 @@ int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
 	else if (!dev->power.qos)
 		ret = dev_pm_qos_constraints_allocate(dev);
 
+	trace_dev_pm_qos_add_request(dev_name(dev), type, value);
 	if (!ret) {
 		req->dev = dev;
 		req->type = type;
@@ -349,6 +351,8 @@ static int __dev_pm_qos_update_request(struct dev_pm_qos_request *req,
 		return -EINVAL;
 	}
 
+	trace_dev_pm_qos_update_request(dev_name(req->dev), req->type,
+					new_value);
 	if (curr_value != new_value)
 		ret = apply_constraint(req, PM_QOS_UPDATE_REQ, new_value);
 
@@ -398,6 +402,8 @@ static int __dev_pm_qos_remove_request(struct dev_pm_qos_request *req)
 	if (IS_ERR_OR_NULL(req->dev->power.qos))
 		return -ENODEV;
 
+	trace_dev_pm_qos_remove_request(dev_name(req->dev), req->type,
+					PM_QOS_DEFAULT_VALUE);
 	ret = apply_constraint(req, PM_QOS_REMOVE_REQ, PM_QOS_DEFAULT_VALUE);
 	memset(req, 0, sizeof(*req));
 	return ret;
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 6411f92..8e42410 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -299,6 +299,57 @@ DEFINE_EVENT_PRINT(pm_qos_update, pm_qos_update_flags,
 			{ PM_QOS_REMOVE_REQ,	"REMOVE_REQ" }),
 		  __entry->prev_value, __entry->curr_value)
 );
+
+DECLARE_EVENT_CLASS(dev_pm_qos_request,
+
+	TP_PROTO(const char *name, enum dev_pm_qos_req_type type,
+		 s32 new_value),
+
+	TP_ARGS(name, type, new_value),
+
+	TP_STRUCT__entry(
+		__string( name,                    name         )
+		__field( enum dev_pm_qos_req_type, type         )
+		__field( s32,                      new_value    )
+	),
+
+	TP_fast_assign(
+		__assign_str(name, name);
+		__entry->type = type;
+		__entry->new_value = new_value;
+	),
+
+	TP_printk("device=%s type=%s new_value=%d",
+		  __get_str(name),
+		  __print_symbolic(__entry->type,
+			{ DEV_PM_QOS_LATENCY,	"DEV_PM_QOS_LATENCY" },
+			{ DEV_PM_QOS_FLAGS,	"DEV_PM_QOS_FLAGS" }),
+		  __entry->new_value)
+);
+
+DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_add_request,
+
+	TP_PROTO(const char *name, enum dev_pm_qos_req_type type,
+		 s32 new_value),
+
+	TP_ARGS(name, type, new_value)
+);
+
+DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_update_request,
+
+	TP_PROTO(const char *name, enum dev_pm_qos_req_type type,
+		 s32 new_value),
+
+	TP_ARGS(name, type, new_value)
+);
+
+DEFINE_EVENT(dev_pm_qos_request, dev_pm_qos_remove_request,
+
+	TP_PROTO(const char *name, enum dev_pm_qos_req_type type,
+		 s32 new_value),
+
+	TP_ARGS(name, type, new_value)
+);
 #endif /* _TRACE_POWER_H */
 
 /* This part must be outside protection */
-- 
1.7.1

