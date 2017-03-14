From: Lukasz Luba <lukasz.luba@arm.com>
Subject: [PATCH v3 3/3] trace: thermal: add another parameter *power to the tracing function
Date: Tue, 14 Mar 2017 13:06:16 +0000
Message-ID: <20170314130616.7711-4-lukasz.luba@arm.com>
References: <20170314130616.7711-1-lukasz.luba@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:32822 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750930AbdCNNHE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 14 Mar 2017 09:07:04 -0400
In-Reply-To: <20170314130616.7711-1-lukasz.luba@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: chris.diamand@arm.com, lukasz.luba@arm.com, javi.merino@kernel.org, rui.zhang@intel.com, edubezval@gmail.com, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar <mingo@redhat.com>

This patch adds another parameter to the trace function:
trace_thermal_power_devfreq_get_power().

In case when we call directly driver's code for the real power,
we do not have static/dynamic_power values. Instead we get total
power in the '*power' value. The 'static_power' and
'dynamic_power' are set to 0.

Therefore, we have to trace that '*power' value in this scenario.

CC: Steven Rostedt <rostedt@goodmis.org>
CC: Ingo Molnar <mingo@redhat.com>
CC: Zhang Rui <rui.zhang@intel.com>
CC: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Lukasz Luba <lukasz.luba@arm.com>
---
 drivers/thermal/devfreq_cooling.c |  2 +-
 include/trace/events/thermal.h    | 11 +++++++----
 2 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/thermal/devfreq_cooling.c b/drivers/thermal/devfreq_cooling.c
index 4411ab8..ca3ebe3 100644
--- a/drivers/thermal/devfreq_cooling.c
+++ b/drivers/thermal/devfreq_cooling.c
@@ -304,7 +304,7 @@ static int devfreq_cooling_get_requested_power(struct thermal_cooling_device *cd
 	}
 
 	trace_thermal_power_devfreq_get_power(cdev, status, freq, dyn_power,
-					      static_power);
+					      static_power, *power);
 
 	return 0;
 fail:
diff --git a/include/trace/events/thermal.h b/include/trace/events/thermal.h
index 2b4a8ff..6cde5b3 100644
--- a/include/trace/events/thermal.h
+++ b/include/trace/events/thermal.h
@@ -151,9 +151,9 @@ TRACE_EVENT(thermal_power_cpu_limit,
 TRACE_EVENT(thermal_power_devfreq_get_power,
 	TP_PROTO(struct thermal_cooling_device *cdev,
 		 struct devfreq_dev_status *status, unsigned long freq,
-		u32 dynamic_power, u32 static_power),
+		u32 dynamic_power, u32 static_power, u32 power),
 
-	TP_ARGS(cdev, status,  freq, dynamic_power, static_power),
+	TP_ARGS(cdev, status,  freq, dynamic_power, static_power, power),
 
 	TP_STRUCT__entry(
 		__string(type,         cdev->type    )
@@ -161,6 +161,7 @@ TRACE_EVENT(thermal_power_devfreq_get_power,
 		__field(u32,           load          )
 		__field(u32,           dynamic_power )
 		__field(u32,           static_power  )
+		__field(u32,           power)
 	),
 
 	TP_fast_assign(
@@ -169,11 +170,13 @@ TRACE_EVENT(thermal_power_devfreq_get_power,
 		__entry->load = (100 * status->busy_time) / status->total_time;
 		__entry->dynamic_power = dynamic_power;
 		__entry->static_power = static_power;
+		__entry->power = power;
 	),
 
-	TP_printk("type=%s freq=%lu load=%u dynamic_power=%u static_power=%u",
+	TP_printk("type=%s freq=%lu load=%u dynamic_power=%u static_power=%u power=%u",
 		__get_str(type), __entry->freq,
-		__entry->load, __entry->dynamic_power, __entry->static_power)
+		__entry->load, __entry->dynamic_power, __entry->static_power,
+		__entry->power)
 );
 
 TRACE_EVENT(thermal_power_devfreq_limit,
-- 
2.9.2
