From: David Singleton <dsingleton@mvista.com>
Subject: Cpufreq addition for PowerOp patch
Date: Tue, 08 Aug 2006 11:14:31 -0700
Message-ID: <44D8D487.9060106@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

This patch adds support to be able to use the cpufreq =

'prepare-to-transition'
and 'finish-transition' nofifier lists for PowerOp transitions.


Signed-Off-by: David Singleton <dsingleton@mvista.com>

 drivers/cpufreq/cpufreq.c |   36 ++++++++++++++++++++++++++++++++++++
 include/linux/cpufreq.h   |    2 ++
 2 files changed, 38 insertions(+)

Index: linux-2.6.17/drivers/cpufreq/cpufreq.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.orig/drivers/cpufreq/cpufreq.c
+++ linux-2.6.17/drivers/cpufreq/cpufreq.c
@@ -226,6 +226,35 @@ static void adjust_jiffies(unsigned long
 static inline void adjust_jiffies(unsigned long val, struct =

cpufreq_freqs *ci) { return; }
 #endif

+int cpufreq_prepare_transition(struct powerop *cur, struct powerop *new)
+{
+       struct cpufreq_freqs freqs;
+
+       freqs.old =3D cur->frequency;
+       freqs.new =3D new->frequency;
+       freqs.cpu =3D 0;
+       freqs.flags =3D cpufreq_driver->flags;
+       blocking_notifier_call_chain(&cpufreq_transition_notifier_list,
+                       CPUFREQ_PRECHANGE, &freqs);
+       adjust_jiffies(CPUFREQ_PRECHANGE, &freqs);
+       return 0;
+}
+EXPORT_SYMBOL(cpufreq_prepare_transition);
+
+int cpufreq_finish_transition(struct powerop *cur, struct powerop *new)
+{
+       struct cpufreq_freqs freqs;
+
+       freqs.old =3D cur->frequency;
+       freqs.new =3D new->frequency;
+       freqs.cpu =3D 0;
+       freqs.flags =3D cpufreq_driver->flags;
+       adjust_jiffies(CPUFREQ_POSTCHANGE, &freqs);
+       blocking_notifier_call_chain(&cpufreq_transition_notifier_list,
+                       CPUFREQ_POSTCHANGE, &freqs);
+       return 0;
+}
+EXPORT_SYMBOL(cpufreq_finish_transition);

 /**
  * cpufreq_notify_transition - call notifier chain and adjust_jiffies
@@ -884,6 +913,12 @@ static void cpufreq_out_of_sync(unsigned
 }


+#ifdef CONFIG_PM
+unsigned int cpufreq_quick_get(unsigned int cpu)
+{
+       return (current_state->frequency * 1000);
+}
+#else
 /**
  * cpufreq_quick_get - get the CPU frequency (in kHz) frpm policy->cur
  * @cpu: CPU number
@@ -905,6 +940,7 @@ unsigned int cpufreq_quick_get(unsigned

        return (ret);
 }
+#endif
 EXPORT_SYMBOL(cpufreq_quick_get);


Index: linux-2.6.17/include/linux/cpufreq.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.17.orig/include/linux/cpufreq.h
+++ linux-2.6.17/include/linux/cpufreq.h
@@ -271,6 +271,8 @@ static inline unsigned int cpufreq_quick
        return 0;
 }
 #endif
+int cpufreq_prepare_transition(struct powerop *cur, struct powerop *new);
+int cpufreq_finish_transition(struct powerop *cur, struct powerop *new);


 /*********************************************************************
