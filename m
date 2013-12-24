From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: =?UTF-8?q?=5BPATCH=202/2=5D=20cpufreq=3A=20preserve=20user=5Fpolicy=20across=20suspend/resume?=
Date: Tue, 24 Dec 2013 07:11:01 +0530
Message-ID: <03303e46795a89272ba66d5fa230cbfdb9a177a9.1387848958.git.viresh.kumar@linaro.org>
References: <f9d7b0d5424e4443597d2ed39bec3fedd2b10d1e.1387848958.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pb0-f42.google.com ([209.85.160.42]:65210 "EHLO
	mail-pb0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752817Ab3LXBlS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2013 20:41:18 -0500
Received: by mail-pb0-f42.google.com with SMTP id uo5so5917296pbc.29
        for <linux-pm@vger.kernel.org>; Mon, 23 Dec 2013 17:41:18 -0800 (PST)
In-Reply-To: <f9d7b0d5424e4443597d2ed39bec3fedd2b10d1e.1387848958.git.viresh.kumar@linaro.org>
In-Reply-To: <f9d7b0d5424e4443597d2ed39bec3fedd2b10d1e.1387848958.git.viresh.kumar@linaro.org>
References: <f9d7b0d5424e4443597d2ed39bec3fedd2b10d1e.1387848958.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, bjorn@mork.no, Viresh Kumar <viresh.kumar@linaro.org>

In __cpufreq_add_dev() we are reinitializing user_policy with default v=
alues and
hence would loose values of user_policy.{min|max|policy|governor} field=
s.

Preserve them by not overriding these for suspend/resume.

Reported-by: Bj=C3=B8rn Mork <bjorn@mork.no>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0a48e71..59e918e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -839,9 +839,6 @@ static void cpufreq_init_policy(struct cpufreq_poli=
cy *policy)
=20
 	/* set default policy */
 	ret =3D cpufreq_set_policy(policy, &new_policy);
-	policy->user_policy.policy =3D policy->policy;
-	policy->user_policy.governor =3D policy->governor;
-
 	if (ret) {
 		pr_debug("setting policy failed\n");
 		if (cpufreq_driver->exit)
@@ -1077,8 +1074,10 @@ static int __cpufreq_add_dev(struct device *dev,=
 struct subsys_interface *sif,
 	 */
 	cpumask_and(policy->cpus, policy->cpus, cpu_online_mask);
=20
-	policy->user_policy.min =3D policy->min;
-	policy->user_policy.max =3D policy->max;
+	if (!frozen) {
+		policy->user_policy.min =3D policy->min;
+		policy->user_policy.max =3D policy->max;
+	}
=20
 	blocking_notifier_call_chain(&cpufreq_policy_notifier_list,
 				     CPUFREQ_START, policy);
@@ -1109,6 +1108,11 @@ static int __cpufreq_add_dev(struct device *dev,=
 struct subsys_interface *sif,
=20
 	cpufreq_init_policy(policy);
=20
+	if (!frozen) {
+		policy->user_policy.policy =3D policy->policy;
+		policy->user_policy.governor =3D policy->governor;
+	}
+
 	kobject_uevent(&policy->kobj, KOBJ_ADD);
 	up_read(&cpufreq_rwsem);
=20
--=20
1.7.12.rc2.18.g61b472e

