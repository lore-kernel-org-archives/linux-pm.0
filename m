From: david singleton <dsingleton@mvista.com>
Subject: Re: Dynanic On-The-Fly Operating points for PowerOP
Date: Sat, 12 Aug 2006 14:40:32 -0700
Message-ID: <13a1aa1bd0a272ad50ad5fb4ebf64629@mvista.com>
References: <44D8D40F.50005@mvista.com>
	<bb52214749a48f317fba09eb522537bb@nomadgs.com>
	<5da81756733c335565f969bab0c9b934@mvista.com>
	<26d93dc005e384544d9ea702baa4a4af@nomadgs.com>
	<acd2a5930608120107k36653863vdfc8bd3875d395a9@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: multipart/mixed; boundary=Apple-Mail-4-1017973472
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <acd2a5930608120107k36653863vdfc8bd3875d395a9@mail.gmail.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org


--Apple-Mail-4-1017973472
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed


Here's the powerop-cpufreq.patch.  It hasn't changed from the 
2.6.18-rc1 version (I think).


David



--Apple-Mail-4-1017973472
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream; x-unix-mode=0644;
	name="powerop-cpufreq.patch"
Content-Disposition: attachment;
	filename=powerop-cpufreq.patch


Signed-Off-by: David Singleton <dsingleton@mvista.com>

 drivers/cpufreq/cpufreq.c |   40 ++++++++++++++++++++++++++++++++++++++--
 include/linux/cpufreq.h   |    2 ++
 2 files changed, 40 insertions(+), 2 deletions(-)

Index: linux-2.6.17/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-2.6.17.orig/drivers/cpufreq/cpufreq.c
+++ linux-2.6.17/drivers/cpufreq/cpufreq.c
@@ -213,19 +213,48 @@ static void adjust_jiffies(unsigned long
 	if (!l_p_j_ref_freq) {
 		l_p_j_ref = loops_per_jiffy;
 		l_p_j_ref_freq = ci->old;
-		dprintk("saving %lu as reference value for loops_per_jiffy; freq is %u kHz\n", l_p_j_ref, l_p_j_ref_freq);
+		printk("saving %lu as reference value for loops_per_jiffy; freq is %u kHz\n", l_p_j_ref, l_p_j_ref_freq);
 	}
 	if ((val == CPUFREQ_PRECHANGE  && ci->old < ci->new) ||
 	    (val == CPUFREQ_POSTCHANGE && ci->old > ci->new) ||
 	    (val == CPUFREQ_RESUMECHANGE || val == CPUFREQ_SUSPENDCHANGE)) {
 		loops_per_jiffy = cpufreq_scale(l_p_j_ref, l_p_j_ref_freq, ci->new);
-		dprintk("scaling loops_per_jiffy to %lu for frequency %u kHz\n", loops_per_jiffy, ci->new);
+		printk("scaling loops_per_jiffy to %lu for frequency %u kHz\n", loops_per_jiffy, ci->new);
 	}
 }
 #else
 static inline void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci) { return; }
 #endif
 
+int cpufreq_prepare_transition(struct powerop *cur, struct powerop *new)
+{
+	struct cpufreq_freqs freqs;
+
+	freqs.old = cur->frequency;
+	freqs.new = new->frequency;
+	freqs.cpu = 0;
+	freqs.flags = cpufreq_driver->flags;
+	blocking_notifier_call_chain(&cpufreq_transition_notifier_list,
+			CPUFREQ_PRECHANGE, &freqs);
+	adjust_jiffies(CPUFREQ_PRECHANGE, &freqs);
+	return 0;
+}
+EXPORT_SYMBOL(cpufreq_prepare_transition);
+
+int cpufreq_finish_transition(struct powerop *cur, struct powerop *new)
+{
+	struct cpufreq_freqs freqs;
+
+	freqs.old = cur->frequency;
+	freqs.new = new->frequency;
+	freqs.cpu = 0;
+	freqs.flags = cpufreq_driver->flags;
+	adjust_jiffies(CPUFREQ_POSTCHANGE, &freqs);
+	blocking_notifier_call_chain(&cpufreq_transition_notifier_list,
+			CPUFREQ_POSTCHANGE, &freqs);
+	return 0;
+}
+EXPORT_SYMBOL(cpufreq_finish_transition);
 
 /**
  * cpufreq_notify_transition - call notifier chain and adjust_jiffies
@@ -920,6 +949,12 @@ static void cpufreq_out_of_sync(unsigned
 }
 
 
+#ifdef CONFIG_PM
+unsigned int cpufreq_quick_get(unsigned int cpu)
+{
+	return (current_state->frequency * 1000);
+}
+#else
 /**
  * cpufreq_quick_get - get the CPU frequency (in kHz) frpm policy->cur
  * @cpu: CPU number
@@ -941,6 +976,7 @@ unsigned int cpufreq_quick_get(unsigned 
 
 	return (ret);
 }
+#endif
 EXPORT_SYMBOL(cpufreq_quick_get);
 
 
Index: linux-2.6.17/include/linux/cpufreq.h
===================================================================
--- linux-2.6.17.orig/include/linux/cpufreq.h
+++ linux-2.6.17/include/linux/cpufreq.h
@@ -268,6 +268,8 @@ static inline unsigned int cpufreq_quick
 	return 0;
 }
 #endif
+int cpufreq_prepare_transition(struct powerop *cur, struct powerop *new);
+int cpufreq_finish_transition(struct powerop *cur, struct powerop *new);
 
 
 /*********************************************************************

--Apple-Mail-4-1017973472
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--Apple-Mail-4-1017973472--
