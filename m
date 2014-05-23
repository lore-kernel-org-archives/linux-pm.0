From: Morten Rasmussen <morten.rasmussen@arm.com>
Subject: [RFC PATCH 10/16] sched, cpufreq: Current compute capacity hack for ARM TC2
Date: Fri, 23 May 2014 19:16:37 +0100
Message-ID: <1400869003-27769-11-git-send-email-morten.rasmussen@arm.com>
References: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Content-Type: text/plain; charset=WINDOWS-1252
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from service87.mimecast.com ([91.220.42.44]:36287 "EHLO
	service87.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539AbaEWSQz (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 23 May 2014 14:16:55 -0400
In-Reply-To: <1400869003-27769-1-git-send-email-morten.rasmussen@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, peterz@infradead.org, mingo@kernel.org
Cc: rjw@rjwysocki.net, vincent.guittot@linaro.org, daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com, dietmar.eggemann@arm.com

Hack to report different cpu capacities for big and little cpus.
This is for experimentation on ARM TC2 _only_. A proper solution
has to address this problem.

Signed-off-by: Morten Rasmussen <morten.rasmussen@arm.com>
---
 drivers/cpufreq/cpufreq.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index a2b788d..134d777 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -316,7 +316,13 @@ static void __cpufreq_notify_transition(struct cpufreq=
_policy *policy,
 =09=09pr_debug("FREQ: %lu - CPU: %lu\n",
 =09=09=09 (unsigned long)freqs->new, (unsigned long)freqs->cpu);
 =09=09trace_cpu_frequency(freqs->new, freqs->cpu);
-=09=09set_curr_capacity(freqs->cpu, (freqs->new*1024)/policy->max);
+=09=09/* Massive TC2 hack */
+=09=09if (freqs->cpu =3D=3D 1 || freqs->cpu =3D=3D 2)
+=09=09=09/* A15 cpus (max_capacity =3D 2015) */
+=09=09=09set_curr_capacity(freqs->cpu, (freqs->new*2015)/1200000);
+=09=09else
+=09=09=09/* A7 cpus (nax_capacity =3D 1024) */
+=09=09=09set_curr_capacity(freqs->cpu, (freqs->new*1024)/1000000);
 =09=09srcu_notifier_call_chain(&cpufreq_transition_notifier_list,
 =09=09=09=09CPUFREQ_POSTCHANGE, freqs);
 =09=09if (likely(policy) && likely(policy->cpu =3D=3D freqs->cpu))
--=20
1.7.9.5


