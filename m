From: Michele Di Giorgio <michele.digiorgio@arm.com>
Subject: [PATCH] thermal: trace: migrating thermal traces to use TRACE_DEFINE_ENUM() macros
Date: Tue,  1 Mar 2016 17:38:54 +0000
Message-ID: <1456853934-24715-1-git-send-email-michele.digiorgio@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:55439 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1750996AbcCARjo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 1 Mar 2016 12:39:44 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Ingo Molnar <mingo@redhat.com>, Javi Merino <javi.merino@arm.com>, linux-kernel@vger.kernel.org, Punit Agrawal <punit.agrawal@arm.com>, Michele Di Giorgio <michele.digiorgio@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Eduardo Valentin <edubezval@gmail.com>

Userspace tools are not aware of how to convert the enums provided by
the tracepoints to their corresponding strings.

Adding TRACE_DEFINE_ENUM() macros allows to make the enums available
to userspace to let the tools know what those enum values represent.

In particular, for thermal zone trip types what we obtained before was
something like:

kworker/1:1-460   [001]   320.372732: thermal_zone_trip:    thermal_zone=soc
				id=0 trip=1 trip_type=1

Unfortunately, userspace tools do not know how to convert enum values to
strings and as a consequence they can only forward the enum value to the
output. By using TRACE_DEFINE_ENUM() macros for thermal traces we get the
following trace line:

kworker/1:1-460   [001]   320.372732: thermal_zone_trip:    thermal_zone=soc
				id=0 trip=1 trip_type=PASSIVE

Userspace tools are now able to better understand the meaning of the trip_type
and provide the user with more readable information.

CC: Steven Rostedt <rostedt@goodmis.org>
CC: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Michele Di Giorgio <michele.digiorgio@arm.com>
---
 include/trace/events/thermal.h | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/include/trace/events/thermal.h b/include/trace/events/thermal.h
index 5738bb3..2b4a8ff 100644
--- a/include/trace/events/thermal.h
+++ b/include/trace/events/thermal.h
@@ -8,6 +8,18 @@
 #include <linux/thermal.h>
 #include <linux/tracepoint.h>
 
+TRACE_DEFINE_ENUM(THERMAL_TRIP_CRITICAL);
+TRACE_DEFINE_ENUM(THERMAL_TRIP_HOT);
+TRACE_DEFINE_ENUM(THERMAL_TRIP_PASSIVE);
+TRACE_DEFINE_ENUM(THERMAL_TRIP_ACTIVE);
+
+#define show_tzt_type(type)					\
+	__print_symbolic(type,					\
+			 { THERMAL_TRIP_CRITICAL, "CRITICAL"},	\
+			 { THERMAL_TRIP_HOT,      "HOT"},	\
+			 { THERMAL_TRIP_PASSIVE,  "PASSIVE"},	\
+			 { THERMAL_TRIP_ACTIVE,   "ACTIVE"})
+
 TRACE_EVENT(thermal_temperature,
 
 	TP_PROTO(struct thermal_zone_device *tz),
@@ -73,9 +85,9 @@ TRACE_EVENT(thermal_zone_trip,
 		__entry->trip_type = trip_type;
 	),
 
-	TP_printk("thermal_zone=%s id=%d trip=%d trip_type=%d",
+	TP_printk("thermal_zone=%s id=%d trip=%d trip_type=%s",
 		__get_str(thermal_zone), __entry->id, __entry->trip,
-		__entry->trip_type)
+		show_tzt_type(__entry->trip_type))
 );
 
 TRACE_EVENT(thermal_power_cpu_get_power,
-- 
1.9.1

