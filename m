From: viresh kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH Resend] cpufreq: remove sysfs files for CPU which failed
 to come back after resume
Date: Mon, 23 Dec 2013 21:15:40 +0530
Message-ID: <52B85AA4.6070609@linaro.org>
References: <610b63b7594e5cd364c498f60e69b9e174db9257.1387554926.git.viresh.kumar@linaro.org>	<1651441.C2UQleWVoy@vostro.rjw.lan> <871u14i00j.fsf@nemi.mork.no>	<CAKohpok1dGMPSAehwsVeiyHzxaHupenA4sP5cxCrjVYQMyrVWA@mail.gmail.com>	<87d2kokqdl.fsf@nemi.mork.no> <52B7EC81.6060202@linaro.org>	<877gavgbuv.fsf@nemi.mork.no>	<CAKohpo=0HRihdTiQLk+mKiarUdXOPO3n7GCJ9CUoi=4xJ_AYcg@mail.gmail.com>	<87txdzx2bb.fsf@nemi.mork.no>	<CAKohpon7nn5cpJVNZzzXxbYUkACEsFgyPR20kSSMMsShw0=HVA@mail.gmail.com> <87pponx07s.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <87pponx07s.fsf@nemi.mork.no>
Sender: cpufreq-owner@vger.kernel.org
To: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday 23 December 2013 05:12 PM, Bj=C3=B8rn Mork wrote:
> That would be great.  This could be just me.  I am quite good at
> breaking stuff.

No its not you. While we tried to make sure everything is preserved,
few special things still stayed out :)

And they are solved with this patch, log should be good enough to give
proper reasoning:

=46rom: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 23 Dec 2013 20:51:54 +0530
Subject: [PATCH] cpufreq: preserve user_policy across suspend/resume

In __cpufreq_add_dev() we are reinitializing user_policy with default v=
alues and
hence would loose values of user_policy.{min|max|policy|governor} field=
s.

Preserve them by not overriding these for suspend/resume.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 16d7b4a..c5c3dac 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -839,9 +839,6 @@ static void cpufreq_init_policy(struct cpufreq_poli=
cy *policy)

 	/* set default policy */
 	ret =3D cpufreq_set_policy(policy, &new_policy);
-	policy->user_policy.policy =3D policy->policy;
-	policy->user_policy.governor =3D policy->governor;
-
 	if (ret) {
 		pr_debug("setting policy failed\n");
 		if (cpufreq_driver->exit)
@@ -1069,8 +1066,10 @@ static int __cpufreq_add_dev(struct device *dev,=
 struct subsys_interface *sif,
 	 */
 	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);

-	policy->user_policy.min =3D policy->min;
-	policy->user_policy.max =3D policy->max;
+	if (!frozen) {
+		policy->user_policy.min =3D policy->min;
+		policy->user_policy.max =3D policy->max;
+	}

 	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 				     CPUFREQ_START, policy);
@@ -1101,6 +1100,11 @@ static int __cpufreq_add_dev(struct device *dev,=
 struct subsys_interface *sif,

 	cpufreq_init_policy(policy);

+	if (!frozen) {
+		policy->user_policy.policy =3D policy->policy;
+		policy->user_policy.governor =3D policy->governor;
+	}
+
 	kobject_uevent(&policy->kobj, KOBJ_ADD);
 	up_read(&cpufreq_rwsem);


