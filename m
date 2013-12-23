From: viresh kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH Resend] cpufreq: remove sysfs files for CPU which failed
 to come back after resume
Date: Mon, 23 Dec 2013 13:25:45 +0530
Message-ID: <52B7EC81.6060202@linaro.org>
References: <610b63b7594e5cd364c498f60e69b9e174db9257.1387554926.git.viresh.kumar@linaro.org>	<1651441.C2UQleWVoy@vostro.rjw.lan> <871u14i00j.fsf@nemi.mork.no>	<CAKohpok1dGMPSAehwsVeiyHzxaHupenA4sP5cxCrjVYQMyrVWA@mail.gmail.com> <87d2kokqdl.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qe0-f54.google.com ([209.85.128.54]:65424 "EHLO
	mail-qe0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752982Ab3LWHzv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 23 Dec 2013 02:55:51 -0500
Received: by mail-qe0-f54.google.com with SMTP id cy11so4877831qeb.27
        for <linux-pm@vger.kernel.org>; Sun, 22 Dec 2013 23:55:51 -0800 (PST)
In-Reply-To: <87d2kokqdl.fsf@nemi.mork.no>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Monday 23 December 2013 12:25 PM, Bj=C3=B8rn Mork wrote:
> That's correct.  The immediate result of the failure is exactly the
> same.

Okay..

> The difference is that a subsequent resume would restore the cpufreq
> device whether it existed or not.  That made a complete suspend/resum=
e
> fix up any missing cpufreq device, e.g. one that was removed by a
> previous error.

I see.. Please see if below patch fixes it for you, it should :)


=46rom: Viresh Kumar <viresh.kumar@linaro.org>
Date: Mon, 23 Dec 2013 13:19:47 +0530
Subject: [PATCH] cpufreq: try to resume policies which failed on last r=
esume
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

__cpufreq_add_dev() can fail sometimes while we are resuming our system=
=2E
Currently we are clearing all sysfs nodes for cpufreq's failed policy a=
s that
could make userspace unstable. But if we suspend/resume again, we shoul=
d atleast
try to bring back those policies.

This patch fixes this issue by clearing fallback data on failure and tr=
ying to
allocate a new struct cpufreq_policy on second resume.

Reported-by: Bj=C3=B8rn Mork <bjorn@mork.no>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index fab042e..7523d35 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1010,16 +1010,24 @@ static int __cpufreq_add_dev(struct device *dev=
, struct subsys_interface *sif,
 	read_unlock_irqrestore(&cpufreq_driver_lock, flags);
 #endif

-	if (frozen)
+	if (frozen) {
 		/* Restore the saved policy when doing light-weight init */
 		policy =3D cpufreq_policy_restore(cpu);
-	else
+
+		/*
+		 * As we failed to resume cpufreq core last time, lets try to
+		 * create a new policy.
+		 */
+		if (!policy)
+			frozen =3D false;
+	}
+
+	if (!frozen)
 		policy =3D cpufreq_policy_alloc();

 	if (!policy)
 		goto nomem_out;

-
 	/*
 	 * In the resume path, since we restore a saved policy, the assignmen=
t
 	 * to policy->cpu is like an update of the existing policy, rather th=
an
@@ -1112,8 +1120,14 @@ err_get_freq:
 	if (cpufreq_driver->exit)
 		cpufreq_driver->exit(policy);
 err_set_policy_cpu:
-	if (frozen)
+	if (frozen) {
+		/*
+		 * Clear fallback data as we should try to make things work on
+		 * next suspend/resume
+		 */
+		per_cpu(cpufreq_cpu_data_fallback, cpu) =3D NULL;
 		cpufreq_policy_put_kobj(policy);
+	}
 	cpufreq_policy_free(policy);

 nomem_out:

