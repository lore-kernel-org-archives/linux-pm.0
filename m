From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 26/70] cpufreq: interactive: trace actual speed in target speed decisions
Date: Tue, 27 Oct 2015 18:30:14 +0100
Message-ID: <1445967059-6897-26-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Todd Poynor <toddpoynor@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
List-Id: linux-pm@vger.kernel.org

=46rom: Todd Poynor <toddpoynor@google.com>

Tracing adds actual speed since this is expected to be key to the
choice of target speed.

Change-Id: Iec936102d0010c4e9dfa143c38a9fd0d551189c3
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 drivers/cpufreq/cpufreq_interactive.c      |   18 +++++++-------
 include/trace/events/cpufreq_interactive.h |   36 ++++++++++++++++----=
--------
 2 files changed, 31 insertions(+), 23 deletions(-)

diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index 8153769..2b4aad9 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -186,9 +186,9 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 			    new_freq > hispeed_freq &&
 			    now - pcpu->hispeed_validate_time
 			    < above_hispeed_delay_val) {
-				trace_cpufreq_interactive_notyet(data, cpu_load,
-								 pcpu->target_freq,
-								 new_freq);
+				trace_cpufreq_interactive_notyet(
+					data, cpu_load, pcpu->target_freq,
+					pcpu->policy->cur, new_freq);
 				goto rearm;
 			}
 		}
@@ -215,8 +215,9 @@ static void cpufreq_interactive_timer(unsigned long=
 data)
 	 */
 	if (new_freq < pcpu->floor_freq) {
 		if (now - pcpu->floor_validate_time < min_sample_time) {
-			trace_cpufreq_interactive_notyet(data, cpu_load,
-					 pcpu->target_freq, new_freq);
+			trace_cpufreq_interactive_notyet(
+				data, cpu_load, pcpu->target_freq,
+				pcpu->policy->cur, new_freq);
 			goto rearm;
 		}
 	}
@@ -225,13 +226,14 @@ static void cpufreq_interactive_timer(unsigned lo=
ng data)
 	pcpu->floor_validate_time =3D now;
=20
 	if (pcpu->target_freq =3D=3D new_freq) {
-		trace_cpufreq_interactive_already(data, cpu_load,
-						  pcpu->target_freq, new_freq);
+		trace_cpufreq_interactive_already(
+			data, cpu_load, pcpu->target_freq,
+			pcpu->policy->cur, new_freq);
 		goto rearm_if_notmax;
 	}
=20
 	trace_cpufreq_interactive_target(data, cpu_load, pcpu->target_freq,
-					 new_freq);
+					 pcpu->policy->cur, new_freq);
 	pcpu->target_set_time_in_idle =3D now_idle;
 	pcpu->target_set_time =3D now;
=20
diff --git a/include/trace/events/cpufreq_interactive.h b/include/trace=
/events/cpufreq_interactive.h
index ba0634e..b2ce6b0 100644
--- a/include/trace/events/cpufreq_interactive.h
+++ b/include/trace/events/cpufreq_interactive.h
@@ -36,44 +36,50 @@ DEFINE_EVENT(set, cpufreq_interactive_setspeed,
=20
 DECLARE_EVENT_CLASS(loadeval,
 	    TP_PROTO(unsigned long cpu_id, unsigned long load,
-		     unsigned long curfreq, unsigned long targfreq),
-	    TP_ARGS(cpu_id, load, curfreq, targfreq),
+		     unsigned long curtarg, unsigned long curactual,
+		     unsigned long newtarg),
+		    TP_ARGS(cpu_id, load, curtarg, curactual, newtarg),
=20
 	    TP_STRUCT__entry(
 		    __field(unsigned long, cpu_id    )
 		    __field(unsigned long, load      )
-		    __field(unsigned long, curfreq   )
-		    __field(unsigned long, targfreq  )
+		    __field(unsigned long, curtarg   )
+		    __field(unsigned long, curactual )
+		    __field(unsigned long, newtarg   )
 	    ),
=20
 	    TP_fast_assign(
 		    __entry->cpu_id =3D cpu_id;
 		    __entry->load =3D load;
-		    __entry->curfreq =3D curfreq;
-		    __entry->targfreq =3D targfreq;
+		    __entry->curtarg =3D curtarg;
+		    __entry->curactual =3D curactual;
+		    __entry->newtarg =3D newtarg;
 	    ),
=20
-	    TP_printk("cpu=3D%lu load=3D%lu cur=3D%lu targ=3D%lu",
-		      __entry->cpu_id, __entry->load, __entry->curfreq,
-		      __entry->targfreq)
+	    TP_printk("cpu=3D%lu load=3D%lu cur=3D%lu actual=3D%lu targ=3D%lu=
",
+		      __entry->cpu_id, __entry->load, __entry->curtarg,
+		      __entry->curactual, __entry->newtarg)
 );
=20
 DEFINE_EVENT(loadeval, cpufreq_interactive_target,
 	    TP_PROTO(unsigned long cpu_id, unsigned long load,
-		     unsigned long curfreq, unsigned long targfreq),
-	    TP_ARGS(cpu_id, load, curfreq, targfreq)
+		     unsigned long curtarg, unsigned long curactual,
+		     unsigned long newtarg),
+	    TP_ARGS(cpu_id, load, curtarg, curactual, newtarg)
 );
=20
 DEFINE_EVENT(loadeval, cpufreq_interactive_already,
 	    TP_PROTO(unsigned long cpu_id, unsigned long load,
-		     unsigned long curfreq, unsigned long targfreq),
-	    TP_ARGS(cpu_id, load, curfreq, targfreq)
+		     unsigned long curtarg, unsigned long curactual,
+		     unsigned long newtarg),
+	    TP_ARGS(cpu_id, load, curtarg, curactual, newtarg)
 );
=20
 DEFINE_EVENT(loadeval, cpufreq_interactive_notyet,
 	    TP_PROTO(unsigned long cpu_id, unsigned long load,
-		     unsigned long curfreq, unsigned long targfreq),
-	    TP_ARGS(cpu_id, load, curfreq, targfreq)
+		     unsigned long curtarg, unsigned long curactual,
+		     unsigned long newtarg),
+	    TP_ARGS(cpu_id, load, curtarg, curactual, newtarg)
 );
=20
 TRACE_EVENT(cpufreq_interactive_boost,
--=20
1.7.9.5
