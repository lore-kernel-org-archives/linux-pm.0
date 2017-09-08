From: Georgi Djakov <georgi.djakov@linaro.org>
Subject: [RFC v3 2/3] interconnect: Add basic event tracing
Date: Fri,  8 Sep 2017 20:18:29 +0300
Message-ID: <20170908171830.13813-3-georgi.djakov@linaro.org>
References: <20170908171830.13813-1-georgi.djakov@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170908171830.13813-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, gregkh@linuxfoundation.org
Cc: rjw@rjwysocki.net, robh+dt@kernel.org, khilman@baylibre.com, mturquette@baylibre.com, vincent.guittot@linaro.org, skannan@codeaurora.org, sboyd@codeaurora.org, andy.gross@linaro.org, seansw@qti.qualcomm.com, davidai@quicinc.com, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org, mark.rutland@arm.com, lorenzo.pieralisi@arm.com, georgi.djakov@linaro.org, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>
List-Id: linux-pm@vger.kernel.org

Add basic tracepoints in interconnect_set() so we can trace the
performance and the operations which configure the hardware.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
---
 drivers/interconnect/interconnect.c |  7 ++++++
 include/trace/events/interconnect.h | 45 +++++++++++++++++++++++++++++++++++++
 2 files changed, 52 insertions(+)
 create mode 100644 include/trace/events/interconnect.h

diff --git a/drivers/interconnect/interconnect.c b/drivers/interconnect/interconnect.c
index 94e2a9f01545..4a016f3bedc3 100644
--- a/drivers/interconnect/interconnect.c
+++ b/drivers/interconnect/interconnect.c
@@ -33,6 +33,9 @@ struct interconnect_path {
 	struct interconnect_req reqs[0];
 };
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/interconnect.h>
+
 static struct interconnect_node *node_find(const char *dev_id, int con_id)
 {
 	struct interconnect_node *node = ERR_PTR(-EPROBE_DEFER);
@@ -209,6 +212,8 @@ int interconnect_set(struct interconnect_path *path,
 	size_t i;
 	int ret = 0;
 
+	trace_interconnect_set(path);
+
 	for (i = 0; i < path->num_nodes; i++, prev = next) {
 		next = path->reqs[i].node;
 
@@ -242,6 +247,8 @@ int interconnect_set(struct interconnect_path *path,
 	}
 
 out:
+	trace_interconnect_set_complete(path);
+
 	return ret;
 }
 
diff --git a/include/trace/events/interconnect.h b/include/trace/events/interconnect.h
new file mode 100644
index 000000000000..c4a72163873c
--- /dev/null
+++ b/include/trace/events/interconnect.h
@@ -0,0 +1,45 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM interconnect
+
+#if !defined(_TRACE_INTERCONNECT_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_INTERCONNECT_H
+
+#include <linux/tracepoint.h>
+
+struct interconnect_path;
+
+DECLARE_EVENT_CLASS(interconnect_path,
+
+	TP_PROTO(struct interconnect_path *path),
+
+	TP_ARGS(path),
+
+	TP_STRUCT__entry(
+		__field(struct interconnect_path *, path)
+	),
+
+	TP_fast_assign(
+		__entry->path = path;
+	),
+
+	TP_printk("INTERCONNECT: %p", __entry->path)
+);
+
+DEFINE_EVENT(interconnect_path, interconnect_set,
+
+	TP_PROTO(struct interconnect_path *path),
+
+	TP_ARGS(path)
+);
+
+DEFINE_EVENT(interconnect_path, interconnect_set_complete,
+
+	TP_PROTO(struct interconnect_path *path),
+
+	TP_ARGS(path)
+);
+
+#endif /* _TRACE_INTERCONNECT_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
