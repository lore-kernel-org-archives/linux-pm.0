From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v3 3/3] devfreq_cooling: add trace information
Date: Tue, 28 Jul 2015 16:17:52 +0100
Message-ID: <1438096672-10867-4-git-send-email-javi.merino@arm.com>
References: <1438096672-10867-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:59996 "EHLO foss.arm.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752076AbbG1PSY (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 28 Jul 2015 11:18:24 -0400
In-Reply-To: <1438096672-10867-1-git-send-email-javi.merino@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: cw00.choi@samsung.com, Javi Merino <javi.merino@arm.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>

Tracing is useful for debugging and performance tuning.  Add similar
traces to what's present in the cpu cooling device.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Signed-off-by: Javi Merino <javi.merino@arm.com>
---
 drivers/thermal/devfreq_cooling.c |  6 +++++
 include/trace/events/thermal.h    | 53 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 81e357fce751..bd067545ad60 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -21,6 +21,8 @@
 #include <linux/pm_opp.h>
 #include <linux/thermal.h>
 
+#include <trace/events/thermal.h>
+
 static DEFINE_MUTEX(devfreq_lock);
 static DEFINE_IDR(devfreq_idr);
 
@@ -210,6 +212,9 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 	/* Get static power */
 	static_power = get_static_power(dfc, freq);
 
+	trace_thermal_power_devfreq_get_power(cdev, status, freq, dyn_power,
+					      static_power);
+
 	*power = dyn_power + static_power;
 
 	return 0;
@@ -263,6 +268,7 @@ static int devfreq_cooling_power2state(struct thermal_cooling_device *cdev,
 			break;
 
 	*state = i;
+	trace_thermal_power_devfreq_limit(cdev, freq, *state, power);
 	return 0;
 }
 
diff --git a/include/trace/events/thermal.h b/include/trace/events/thermal.h
index 8b1f80682b80..5738bb3e2343 100644
--- a/include/trace/events/thermal.h
+++ b/include/trace/events/thermal.h
@@ -4,6 +4,7 @@
 #if !defined(_TRACE_THERMAL_H) || defined(TRACE_HEADER_MULTI_READ)
 #define _TRACE_THERMAL_H
 
+#include <linux/devfreq.h>
 #include <linux/thermal.h>
 #include <linux/tracepoint.h>
 
@@ -135,6 +136,58 @@ TRACE_EVENT(thermal_power_cpu_limit,
 		__entry->power)
 );
 
+TRACE_EVENT(thermal_power_devfreq_get_power,
+	TP_PROTO(struct thermal_cooling_device *cdev,
+		 struct devfreq_dev_status *status, unsigned long freq,
+		u32 dynamic_power, u32 static_power),
+
+	TP_ARGS(cdev, status,  freq, dynamic_power, static_power),
+
+	TP_STRUCT__entry(
+		__string(type,         cdev->type    )
+		__field(unsigned long, freq          )
+		__field(u32,           load          )
+		__field(u32,           dynamic_power )
+		__field(u32,           static_power  )
+	),
+
+	TP_fast_assign(
+		__assign_str(type, cdev->type);
+		__entry->freq = freq;
+		__entry->load = (100 * status->busy_time) / status->total_time;
+		__entry->dynamic_power = dynamic_power;
+		__entry->static_power = static_power;
+	),
+
+	TP_printk("type=%s freq=%lu load=%u dynamic_power=%u static_power=%u",
+		__get_str(type), __entry->freq,
+		__entry->load, __entry->dynamic_power, __entry->static_power)
+);
+
+TRACE_EVENT(thermal_power_devfreq_limit,
+	TP_PROTO(struct thermal_cooling_device *cdev, unsigned long freq,
+		unsigned long cdev_state, u32 power),
+
+	TP_ARGS(cdev, freq, cdev_state, power),
+
+	TP_STRUCT__entry(
+		__string(type,         cdev->type)
+		__field(unsigned int,  freq      )
+		__field(unsigned long, cdev_state)
+		__field(u32,           power     )
+	),
+
+	TP_fast_assign(
+		__assign_str(type, cdev->type);
+		__entry->freq = freq;
+		__entry->cdev_state = cdev_state;
+		__entry->power = power;
+	),
+
+	TP_printk("type=%s freq=%u cdev_state=%lu power=%u",
+		__get_str(type), __entry->freq, __entry->cdev_state,
+		__entry->power)
+);
 #endif /* _TRACE_THERMAL_H */
 
 /* This part must be outside protection */
-- 
1.9.1

