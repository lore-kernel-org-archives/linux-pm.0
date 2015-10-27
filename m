From: =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>
Subject: [PATCH 14/70] cpufreq: interactive: add boost pulse interface
Date: Tue, 27 Oct 2015 18:30:02 +0100
Message-ID: <1445967059-6897-14-git-send-email-czoborbalint@gmail.com>
References: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f175.google.com ([209.85.212.175]:34743 "EHLO
	mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965233AbbJ0Rb7 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Oct 2015 13:31:59 -0400
In-Reply-To: <1445967059-6897-1-git-send-email-czoborbalint@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Todd Poynor <toddpoynor@google.com>, =?UTF-8?q?B=C3=A1lint=20Czobor?= <czoborbalint@gmail.com>

=46rom: Todd Poynor <toddpoynor@google.com>

Change-Id: Icf1e86d2065cc8f0816ba9c6b065eb056d4e8249
Signed-off-by: Todd Poynor <toddpoynor@google.com>
Signed-off-by: B=C3=A1lint Czobor <czoborbalint@gmail.com>
---
 Documentation/cpu-freq/governors.txt       |    9 ++++++--
 drivers/cpufreq/cpufreq_interactive.c      |   32 ++++++++++++++++++++=
+++-----
 include/trace/events/cpufreq_interactive.h |   20 ++++++++---------
 3 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/Documentation/cpu-freq/governors.txt b/Documentation/cpu-f=
req/governors.txt
index 4fcaa43..509b179 100644
--- a/Documentation/cpu-freq/governors.txt
+++ b/Documentation/cpu-freq/governors.txt
@@ -267,8 +267,13 @@ not idle.  Default is 20000 uS.
 input_boost: If non-zero, boost speed of all CPUs to hispeed_freq on
 touchscreen activity.  Default is 0.
=20
-boost: If non-zero, immediately boost speed of all CPUs to
-hispeed_freq.  If zero, allow CPU speeds to drop below hispeed_freq.
+boost: If non-zero, immediately boost speed of all CPUs to at least
+hispeed_freq until zero is written to this attribute.  If zero, allow
+CPU speeds to drop below hispeed_freq according to load as usual.
+
+boostpulse: Immediately boost speed of all CPUs to hispeed_freq for
+min_sample_time, after which speeds are allowed to drop below
+hispeed_freq according to load as usual.
=20
=20
 3. The Governor Interface in the CPUfreq Core
diff --git a/drivers/cpufreq/cpufreq_interactive.c b/drivers/cpufreq/cp=
ufreq_interactive.c
index fcd5b1d..fcf0f21 100644
--- a/drivers/cpufreq/cpufreq_interactive.c
+++ b/drivers/cpufreq/cpufreq_interactive.c
@@ -495,7 +495,6 @@ static void cpufreq_interactive_boost(void)
 	unsigned long flags;
 	struct cpufreq_interactive_cpuinfo *pcpu;
=20
-	trace_cpufreq_interactive_boost(hispeed_freq);
 	spin_lock_irqsave(&up_cpumask_lock, flags);
=20
 	for_each_online_cpu(i) {
@@ -534,8 +533,10 @@ static void cpufreq_interactive_input_event(struct=
 input_handle *handle,
 					    unsigned int type,
 					    unsigned int code, int value)
 {
-	if (input_boost_val && type =3D=3D EV_SYN && code =3D=3D SYN_REPORT)
+	if (input_boost_val && type =3D=3D EV_SYN && code =3D=3D SYN_REPORT) =
{
+		trace_cpufreq_interactive_boost("input");
 		cpufreq_interactive_boost();
+	}
 }
=20
 static void cpufreq_interactive_input_open(struct work_struct *w)
@@ -763,16 +764,36 @@ static ssize_t store_boost(struct kobject *kobj, =
struct attribute *attr,
=20
 	boost_val =3D val;
=20
-	if (boost_val)
+	if (boost_val) {
+		trace_cpufreq_interactive_boost("on");
 		cpufreq_interactive_boost();
-	else
-		trace_cpufreq_interactive_unboost(hispeed_freq);
+	} else {
+		trace_cpufreq_interactive_unboost("off");
+	}
=20
 	return count;
 }
=20
 define_one_global_rw(boost);
=20
+static ssize_t store_boostpulse(struct kobject *kobj, struct attribute=
 *attr,
+				const char *buf, size_t count)
+{
+	int ret;
+	unsigned long val;
+
+	ret =3D kstrtoul(buf, 0, &val);
+	if (ret < 0)
+		return ret;
+
+	trace_cpufreq_interactive_boost("pulse");
+	cpufreq_interactive_boost();
+	return count;
+}
+
+static struct global_attr boostpulse =3D
+	__ATTR(boostpulse, 0200, NULL, store_boostpulse);
+
 static struct attribute *interactive_attributes[] =3D {
 	&hispeed_freq_attr.attr,
 	&go_hispeed_load_attr.attr,
@@ -781,6 +802,7 @@ static struct attribute *interactive_attributes[] =3D=
 {
 	&timer_rate_attr.attr,
 	&input_boost.attr,
 	&boost.attr,
+	&boostpulse.attr,
 	NULL,
 };
=20
diff --git a/include/trace/events/cpufreq_interactive.h b/include/trace=
/events/cpufreq_interactive.h
index ae6f232..0791f27 100644
--- a/include/trace/events/cpufreq_interactive.h
+++ b/include/trace/events/cpufreq_interactive.h
@@ -83,27 +83,27 @@ DEFINE_EVENT(loadeval, cpufreq_interactive_notyet,
 );
=20
 TRACE_EVENT(cpufreq_interactive_boost,
-	    TP_PROTO(unsigned long freq),
-	    TP_ARGS(freq),
+	    TP_PROTO(char *s),
+	    TP_ARGS(s),
 	    TP_STRUCT__entry(
-		    __field(unsigned long, freq)
+		    __field(char *, s)
 	    ),
 	    TP_fast_assign(
-		    __entry->freq =3D freq;
+		    __entry->s =3D s;
 	    ),
-	    TP_printk("freq=3D%lu", __entry->freq)
+	    TP_printk("%s", __entry->s)
 );
=20
 TRACE_EVENT(cpufreq_interactive_unboost,
-	    TP_PROTO(unsigned long freq),
-	    TP_ARGS(freq),
+	    TP_PROTO(char *s),
+	    TP_ARGS(s),
 	    TP_STRUCT__entry(
-		    __field(unsigned long, freq)
+		    __field(char *, s)
 	    ),
 	    TP_fast_assign(
-		    __entry->freq =3D freq;
+		    __entry->s =3D s;
 	    ),
-	    TP_printk("freq=3D%lu", __entry->freq)
+	    TP_printk("%s", __entry->s)
 );
=20
 #endif /* _TRACE_CPUFREQ_INTERACTIVE_H */
--=20
1.7.9.5

