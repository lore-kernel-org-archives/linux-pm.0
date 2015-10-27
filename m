From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 02/70] cpufreq interactive governor: event tracing
Date: Tue, 27 Oct 2015 18:29:50 +0100
Message-ID: <1445967059-6897-2-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33472 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964956AbbJ0Rbe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 13:31:34 -0400
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Todd Poynor <toddpoynor@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>

=46rom: Todd Poynor <toddpoynor@google.com>

Change-Id: Ic13614a3da2faa2d4bd215ca3eb7191614f0cf66
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c      |   19 +++++-
 include/trace/events/cpufreq_interactive.h |   87 ++++++++++++++++++++=
++++++++
 2 files changed, 105 insertions(+), 1 deletion(-)
 create mode 100644 include/trace/events/cpufreq_interactive.h

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 8fc147c..62e7456 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -30,6 +30,9 @@
 #include <linux/kthread.h>
 #include <linux/mutex.h>
=20
+#define CREATE_TRACE_POINTS
+#include <trace/events/cpufreq_interactive.h>
+
 #include <asm/cputime.h>
=20
 static atomic_t active_count =3D ATOMIC_INIT(0);
@@ -182,7 +185,11 @@ static void cpufreq_interactive_timer(unsigned lon=
g data)
 	new_freq =3D pcpu->freq_table[index].frequency;
=20
 	if (pcpu->target_freq =3D=3D new_freq)
+	{
+		trace_cpufreq_interactive_already(data, cpu_load,
+						  pcpu->target_freq, new_freq);
 		goto rearm_if_notmax;
+	}
=20
 	/*
 	 * Do not scale down unless we have been at this frequency for the
@@ -190,10 +197,16 @@ static void cpufreq_interactive_timer(unsigned lo=
ng data)
 	 */
 	if (new_freq < pcpu->target_freq) {
 		if (pcpu->timer_run_time - pcpu->freq_change_time
-		    < min_sample_time)
+		    < min_sample_time) {
+			trace_cpufreq_interactive_notyet(data, cpu_load,
+					 pcpu->target_freq, new_freq);
 			goto rearm;
+		}
 	}
=20
+	trace_cpufreq_interactive_target(data, cpu_load, pcpu->target_freq,
+					 new_freq);
+
 	if (new_freq < pcpu->target_freq) {
 		pcpu->target_freq =3D new_freq;
 		spin_lock_irqsave(&down_cpumask_lock, flags);
@@ -381,6 +394,8 @@ static int cpufreq_interactive_up_task(void *data)
 			pcpu->freq_change_time_in_idle =3D
 				get_cpu_idle_time_us(cpu,
 						     &pcpu->freq_change_time);
+			trace_cpufreq_interactive_up(cpu, pcpu->target_freq,
+						     pcpu->policy->cur);
 		}
 	}
=20
@@ -427,6 +442,8 @@ static void cpufreq_interactive_freq_down(struct wo=
rk_struct *work)
 		pcpu->freq_change_time_in_idle =3D
 			get_cpu_idle_time_us(cpu,
 					     &pcpu->freq_change_time);
+		trace_cpufreq_interactive_down(cpu, pcpu->target_freq,
+					       pcpu->policy->cur);
 	}
 }
=20
diff --git a/include/trace/events/cpufreq_interactive.h b/include/trace=
/events/cpufreq_interactive.h
new file mode 100644
index 0000000..3a90d3d
--- /dev/null
+++ b/include/trace/events/cpufreq_interactive.h
@@ -0,0 +1,87 @@
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM cpufreq_interactive
+
+#if !defined(_TRACE_CPUFREQ_INTERACTIVE_H) || defined(TRACE_HEADER_MUL=
TI_READ)
+#define _TRACE_CPUFREQ_INTERACTIVE_H
+
+#include <linux/tracepoint.h>
+
+DECLARE_EVENT_CLASS(set,
+	TP_PROTO(u32 cpu_id, unsigned long targfreq,
+	         unsigned long actualfreq),
+	TP_ARGS(cpu_id, targfreq, actualfreq),
+
+	TP_STRUCT__entry(
+	    __field(          u32, cpu_id    )
+	    __field(unsigned long, targfreq   )
+	    __field(unsigned long, actualfreq )
+	   ),
+
+	TP_fast_assign(
+	    __entry->cpu_id =3D (u32) cpu_id;
+	    __entry->targfreq =3D targfreq;
+	    __entry->actualfreq =3D actualfreq;
+	),
+
+	TP_printk("cpu=3D%u targ=3D%lu actual=3D%lu",
+	      __entry->cpu_id, __entry->targfreq,
+	      __entry->actualfreq)
+);
+
+DEFINE_EVENT(set, cpufreq_interactive_up,
+	TP_PROTO(u32 cpu_id, unsigned long targfreq,
+	     unsigned long actualfreq),
+	TP_ARGS(cpu_id, targfreq, actualfreq)
+);
+
+DEFINE_EVENT(set, cpufreq_interactive_down,
+	TP_PROTO(u32 cpu_id, unsigned long targfreq,
+	     unsigned long actualfreq),
+	TP_ARGS(cpu_id, targfreq, actualfreq)
+);
+
+DECLARE_EVENT_CLASS(loadeval,
+	    TP_PROTO(unsigned long cpu_id, unsigned long load,
+		     unsigned long curfreq, unsigned long targfreq),
+	    TP_ARGS(cpu_id, load, curfreq, targfreq),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned long, cpu_id    )
+		    __field(unsigned long, load      )
+		    __field(unsigned long, curfreq   )
+		    __field(unsigned long, targfreq  )
+	    ),
+
+	    TP_fast_assign(
+		    __entry->cpu_id =3D cpu_id;
+		    __entry->load =3D load;
+		    __entry->curfreq =3D curfreq;
+		    __entry->targfreq =3D targfreq;
+	    ),
+
+	    TP_printk("cpu=3D%lu load=3D%lu cur=3D%lu targ=3D%lu",
+		      __entry->cpu_id, __entry->load, __entry->curfreq,
+		      __entry->targfreq)
+);
+
+DEFINE_EVENT(loadeval, cpufreq_interactive_target,
+	    TP_PROTO(unsigned long cpu_id, unsigned long load,
+		     unsigned long curfreq, unsigned long targfreq),
+	    TP_ARGS(cpu_id, load, curfreq, targfreq)
+);
+
+DEFINE_EVENT(loadeval, cpufreq_interactive_already,
+	    TP_PROTO(unsigned long cpu_id, unsigned long load,
+		     unsigned long curfreq, unsigned long targfreq),
+	    TP_ARGS(cpu_id, load, curfreq, targfreq)
+);
+
+DEFINE_EVENT(loadeval, cpufreq_interactive_notyet,
+	    TP_PROTO(unsigned long cpu_id, unsigned long load,
+		     unsigned long curfreq, unsigned long targfreq),
+	    TP_ARGS(cpu_id, load, curfreq, targfreq)
+);
+#endif /* _TRACE_CPUFREQ_INTERACTIVE_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
--=20
1.7.9.5

