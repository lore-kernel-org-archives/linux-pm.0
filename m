From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 1/2] trace: events: add devfreq trace event file
Date: Thu, 14 Feb 2019 19:57:55 +0100
Message-ID: <1550170676-14173-2-git-send-email-l.luba@partner.samsung.com>
References: <1550170676-14173-1-git-send-email-l.luba@partner.samsung.com>
        <CGME20190214185809eucas1p219acc085fd241f3f685e52cb5534f905@eucas1p2.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1550170676-14173-1-git-send-email-l.luba@partner.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

The patch adds a new file for with trace events for devfreq
framework. They are used for performance analysis of the framework.
It also contains updates in MAINTAINERS file adding new entry for
devfreq maintainers.

Signed-off-by: Lukasz Luba <l.luba@partner.samsung.com>
---
 MAINTAINERS                    |  1 +
 include/trace/events/devfreq.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)
 create mode 100644 include/trace/events/devfreq.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 41ce5f4..9c44076 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4447,6 +4447,7 @@ S:	Maintained
 F:	drivers/devfreq/
 F:	include/linux/devfreq.h
 F:	Documentation/devicetree/bindings/devfreq/
+F:	include/trace/events/devfreq.h
 
 DEVICE FREQUENCY EVENT (DEVFREQ-EVENT)
 M:	Chanwoo Choi <cw00.choi@samsung.com>
diff --git a/include/trace/events/devfreq.h b/include/trace/events/devfreq.h
new file mode 100644
index 0000000..d6990dc
--- /dev/null
+++ b/include/trace/events/devfreq.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM devfreq
+
+#if !defined(_TRACE_DEVFREQ_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_DEVFREQ_H
+
+#include <linux/devfreq.h>
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(devfreq_monitor,
+	TP_PROTO(const char *dev_name, unsigned long freq,
+		 unsigned int polling_ms, unsigned long busy_time,
+		 unsigned long total_time),
+
+	TP_ARGS(dev_name, freq, polling_ms, busy_time, total_time),
+
+	TP_STRUCT__entry(
+		__field(unsigned long, freq)
+		__field(unsigned long, busy_time)
+		__field(unsigned long, total_time)
+		__field(unsigned int, polling_ms)
+		__string(dev_name, dev_name)
+	),
+
+	TP_fast_assign(
+		__entry->freq = freq;
+		__entry->busy_time = busy_time;
+		__entry->total_time = total_time;
+		__entry->polling_ms = polling_ms;
+		__assign_str(dev_name, dev_name);
+	),
+
+	TP_printk("dev_name=%s freq=%lu polling_ms=%u load=%lu",
+		__get_str(dev_name), __entry->freq, __entry->polling_ms,
+		__entry->total_time == 0 ? 100 :
+			(100 * __entry->busy_time) / __entry->total_time)
+);
+#endif /* _TRACE_DEVFREQ_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.7.4
