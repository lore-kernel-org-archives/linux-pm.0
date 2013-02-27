From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/3] workqueue: define mod_scheduled_delayed_work[_on]() helpers
Date: Wed, 27 Feb 2013 16:59:10 +0530
Message-ID: <5249868a014d716eb38cc90e04ed0f6051e65fc3.1361964515.git.viresh.kumar@linaro.org>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:58085 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758129Ab3B0L33 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Feb 2013 06:29:29 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@sisk.pl
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, rickard.andersson@stericsson.com, fabio.baltieri@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>, Tejun Heo <tj@kernel.org>

The only difference between schedule_delayed_work[_on]() and
queue_delayed_work[_on]() is the workqueue, work is scheduled on. We may ne=
ed to
modify the delay for works queued with schedule_delayed_work[_on]() calls a=
nd
thus adding these helpers.

First users of these new helpers is cpufreq governors which need to modify =
the
delay for its works.

Cc: Tejun Heo <tj@kernel.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/workqueue.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index 2b58905..864c2b3 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -412,6 +412,7 @@ extern bool schedule_delayed_work_on(int cpu, struct de=
layed_work *work,
 extern bool schedule_delayed_work(struct delayed_work *work,
 =09=09=09=09  unsigned long delay);
 extern int schedule_on_each_cpu(work_func_t func);
+
 extern int keventd_up(void);
=20
 int execute_in_process_context(work_func_t fn, struct execute_work *);
@@ -465,6 +466,11 @@ static inline long work_on_cpu(unsigned int cpu, long =
(*fn)(void *), void *arg)
 long work_on_cpu(unsigned int cpu, long (*fn)(void *), void *arg);
 #endif /* CONFIG_SMP */
=20
+#define mod_scheduled_delayed_work_on(cpu, dwork, delay)=09\
+=09mod_delayed_work_on(cpu, system_wq, dwork, delay)
+#define mod_scheduled_delayed_work(dwork, delay)=09=09\
+=09mod_delayed_work(system_wq, dwork, delay)
+
 #ifdef CONFIG_FREEZER
 extern void freeze_workqueues_begin(void);
 extern bool freeze_workqueues_busy(void);
--=20
1.7.12.rc2.18.g61b472e


