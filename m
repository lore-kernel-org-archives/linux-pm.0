From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v6 3/5] cpufreq: powernv/tracing: Add powernv_throttle tracepoint
Date: Fri, 22 Jan 2016 12:49:03 +0530
Message-ID: <1453447145-17722-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
References: <1453447145-17722-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp01.au.ibm.com ([202.81.31.143]:55721 "EHLO
	e23smtp01.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752487AbcAVHUT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jan 2016 02:20:19 -0500
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Fri, 22 Jan 2016 17:20:16 +1000
In-Reply-To: <1453447145-17722-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, pc@us.ibm.com, anton@samba.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>

This patch adds the powernv_throttle tracepoint to trace the CPU
frequency throttling event, which is used by the powernv-cpufreq
driver in POWER8.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
CC: Ingo Molnar <mingo@redhat.com>
CC: Steven Rostedt <rostedt@goodmis.org>
---
No changes since v2.

 include/trace/events/power.h | 22 ++++++++++++++++++++++
 kernel/trace/power-traces.c  |  1 +
 2 files changed, 23 insertions(+)

diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 284244e..19e5030 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -38,6 +38,28 @@ DEFINE_EVENT(cpu, cpu_idle,
 	TP_ARGS(state, cpu_id)
 );
 
+TRACE_EVENT(powernv_throttle,
+
+	TP_PROTO(int chip_id, const char *reason, int pmax),
+
+	TP_ARGS(chip_id, reason, pmax),
+
+	TP_STRUCT__entry(
+		__field(int, chip_id)
+		__string(reason, reason)
+		__field(int, pmax)
+	),
+
+	TP_fast_assign(
+		__entry->chip_id = chip_id;
+		__assign_str(reason, reason);
+		__entry->pmax = pmax;
+	),
+
+	TP_printk("Chip %d Pmax %d %s", __entry->chip_id,
+		  __entry->pmax, __get_str(reason))
+);
+
 TRACE_EVENT(pstate_sample,
 
 	TP_PROTO(u32 core_busy,
diff --git a/kernel/trace/power-traces.c b/kernel/trace/power-traces.c
index eb4220a..81b8745 100644
--- a/kernel/trace/power-traces.c
+++ b/kernel/trace/power-traces.c
@@ -15,4 +15,5 @@
 
 EXPORT_TRACEPOINT_SYMBOL_GPL(suspend_resume);
 EXPORT_TRACEPOINT_SYMBOL_GPL(cpu_idle);
+EXPORT_TRACEPOINT_SYMBOL_GPL(powernv_throttle);
 
-- 
1.9.3

