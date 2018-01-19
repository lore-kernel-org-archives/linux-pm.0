From: Lina Iyer <ilina@codeaurora.org>
Subject: [PATCH 3/4] drivers: qcom: rpmh-rsc: log RPMH requests in FTRACE
Date: Thu, 18 Jan 2018 17:01:56 -0700
Message-ID: <20180119000157.7380-4-ilina@codeaurora.org>
References: <20180119000157.7380-1-ilina@codeaurora.org>
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20180119000157.7380-1-ilina@codeaurora.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: andy.gross@linaro.org, david.brown@linaro.org
Cc: sboyd@codeaurora.org, rnayak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Lina Iyer <ilina@codeaurora.org>, Steven Rostedt <rostedt@goodmis.org>
List-Id: linux-pm@vger.kernel.org

Log sent RPMH requests and interrupt responses in FTRACE.

Cc: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Lina Iyer <ilina@codeaurora.org>
---
 drivers/soc/qcom/rpmh-rsc.c | 13 ++++++-
 include/trace/events/rpmh.h | 89 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 101 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/rpmh.h

diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
index 3e68cef5513e..424dc939b2e6 100644
--- a/drivers/soc/qcom/rpmh-rsc.c
+++ b/drivers/soc/qcom/rpmh-rsc.c
@@ -33,6 +33,9 @@
 
 #include "rpmh-internal.h"
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/rpmh.h>
+
 #define MAX_CMDS_PER_TCS		16
 #define MAX_TCS_PER_TYPE		3
 
@@ -325,6 +328,8 @@ static irqreturn_t tcs_irq_handler(int irq, void *p)
 			}
 		}
 
+		trace_rpmh_notify_irq(drv->name, m, resp->msg->payload[0].addr,
+						resp->err);
 		write_tcs_reg(base, RSC_DRV_CMD_ENABLE, m, 0, 0);
 		write_tcs_reg(base, RSC_DRV_IRQ_CLEAR, 0, 0, BIT(m));
 		atomic_set(&drv->tcs_in_use[m], 0);
@@ -351,7 +356,8 @@ static void tcs_notify_tx_done(unsigned long data)
 	struct rsc_drv *drv = (struct rsc_drv *)data;
 	struct tcs_response *resp;
 	unsigned long flags;
-	int err;
+	int err, m;
+	struct tcs_mbox_msg *msg;
 
 	do {
 		spin_lock_irqsave(&drv->drv_lock, flags);
@@ -364,7 +370,10 @@ static void tcs_notify_tx_done(unsigned long data)
 		list_del(&resp->list);
 		spin_unlock_irqrestore(&drv->drv_lock, flags);
 		err = resp->err;
+		m = resp->m;
+		msg = resp->msg;
 		free_response(resp);
+		trace_rpmh_notify(drv->name, m, msg->payload[0].addr, err);
 	} while (1);
 }
 
@@ -393,6 +402,8 @@ static void __tcs_buffer_write(struct rsc_drv *drv, int m, int n,
 		write_tcs_reg(base, RSC_DRV_CMD_MSGID, m, n + i, msgid);
 		write_tcs_reg(base, RSC_DRV_CMD_ADDR, m, n + i, cmd->addr);
 		write_tcs_reg(base, RSC_DRV_CMD_DATA, m, n + i, cmd->data);
+		trace_rpmh_send_msg(drv->name, m, n + i, msgid, cmd->addr,
+						cmd->data, cmd->complete);
 	}
 
 	write_tcs_reg(base, RSC_DRV_CMD_WAIT_FOR_CMPL, m, 0, cmd_complete);
diff --git a/include/trace/events/rpmh.h b/include/trace/events/rpmh.h
new file mode 100644
index 000000000000..2cc44fc5ff95
--- /dev/null
+++ b/include/trace/events/rpmh.h
@@ -0,0 +1,89 @@
+/* Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 and
+ * only version 2 as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rpmh
+
+#if !defined(_TRACE_RPMH_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_RPMH_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(rpmh_ack_recvd,
+
+	TP_PROTO(const char *s, int m, u32 addr, int errno),
+
+	TP_ARGS(s, m, addr, errno),
+
+	TP_STRUCT__entry(
+		__field(const char *, name)
+		__field(int, m)
+		__field(u32, addr)
+		__field(int, errno)
+	),
+
+	TP_fast_assign(
+		__entry->name = s;
+		__entry->m = m;
+		__entry->addr = addr;
+		__entry->errno = errno;
+	),
+
+	TP_printk("%s: ack: tcs-m:%d addr: 0x%08x errno: %d",
+		__entry->name, __entry->m, __entry->addr, __entry->errno)
+);
+
+DEFINE_EVENT(rpmh_ack_recvd, rpmh_notify_irq,
+	TP_PROTO(const char *s, int m, u32 addr, int err),
+	TP_ARGS(s, m, addr, err)
+);
+
+DEFINE_EVENT(rpmh_ack_recvd, rpmh_notify,
+	TP_PROTO(const char *s, int m, u32 addr, int err),
+	TP_ARGS(s, m, addr, err)
+);
+
+TRACE_EVENT(rpmh_send_msg,
+
+	TP_PROTO(const char *s, int m, int n, u32 h, u32 a, u32 v, bool c),
+
+	TP_ARGS(s, m, n, h, a, v, c),
+
+	TP_STRUCT__entry(
+		__field(const char*, name)
+		__field(int, m)
+		__field(int, n)
+		__field(u32, hdr)
+		__field(u32, addr)
+		__field(u32, data)
+		__field(bool, complete)
+	),
+
+	TP_fast_assign(
+		__entry->name = s;
+		__entry->m = m;
+		__entry->n = n;
+		__entry->hdr = h;
+		__entry->addr = a;
+		__entry->data = v;
+		__entry->complete = c;
+	),
+
+	TP_printk("%s: send-msg: tcs(m): %d cmd(n): %d msgid: 0x%08x addr: 0x%08x data: 0x%08x complete: %d",
+			__entry->name, __entry->m, __entry->n, __entry->hdr,
+			__entry->addr, __entry->data, __entry->complete)
+);
+
+#endif /* _TRACE_RPMH_H */
+
+#define TRACE_INCLUDE_FILE rpmh
+#include <trace/define_trace.h>
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
