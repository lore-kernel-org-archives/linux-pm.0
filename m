From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] tracing: Remove unused clock events
Date: Thu, 12 Oct 2017 12:44:46 -0400
Message-ID: <20171012124446.4a4fb056@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40778 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752204AbdJLQot (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 12 Oct 2017 12:44:49 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: LKML <linux-kernel@vger.kernel.org>, discuss@lesswatts.org, linux-pm@vger.kernel.org, Thomas Renninger <trenn@suse.de>, Arjan van de Ven <arjan@linux.intel.com>, Peter Zijlstra <peterz@infradead.org>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@deeprootsystems.com>, Ingo Molnar <mingo@kernel.org>


[ Resending again, including linux-pm@vger.kernel.org this time ]

From: Steven Rostedt (VMware) <rostedt@goodmis.org>

Commit 74704ac6 ("tracing, perf: Add more power related events") added
new events, among them were trace_clock_enable, trace_clock_disable and
trace_clock_set_rate. In the last 7 years, nothing has used them. As
they take up space, and nobody cares about these events, remove them.

Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---
diff --git a/include/trace/events/power.h b/include/trace/events/power.h
index 54e3aad..d900cb7 100644
--- a/include/trace/events/power.h
+++ b/include/trace/events/power.h
@@ -254,53 +254,6 @@ DEFINE_EVENT(wakeup_source,
wakeup_source_deactivate, );
 
 /*
- * The clock events are used for clock enable/disable and for
- *  clock rate change
- */
-DECLARE_EVENT_CLASS(clock,
-
-	TP_PROTO(const char *name, unsigned int state, unsigned int
cpu_id), -
-	TP_ARGS(name, state, cpu_id),
-
-	TP_STRUCT__entry(
-		__string(       name,           name            )
-		__field(        u64,            state           )
-		__field(        u64,            cpu_id          )
-	),
-
-	TP_fast_assign(
-		__assign_str(name, name);
-		__entry->state = state;
-		__entry->cpu_id = cpu_id;
-	),
-
-	TP_printk("%s state=%lu cpu_id=%lu", __get_str(name),
-		(unsigned long)__entry->state, (unsigned
long)__entry->cpu_id) -);
-
-DEFINE_EVENT(clock, clock_enable,
-
-	TP_PROTO(const char *name, unsigned int state, unsigned int
cpu_id), -
-	TP_ARGS(name, state, cpu_id)
-);
-
-DEFINE_EVENT(clock, clock_disable,
-
-	TP_PROTO(const char *name, unsigned int state, unsigned int
cpu_id), -
-	TP_ARGS(name, state, cpu_id)
-);
-
-DEFINE_EVENT(clock, clock_set_rate,
-
-	TP_PROTO(const char *name, unsigned int state, unsigned int
cpu_id), -
-	TP_ARGS(name, state, cpu_id)
-);
-
-/*
  * The power domain events are used for power domains transitions
  */
 DECLARE_EVENT_CLASS(power_domain,
