From: "Doug Smythies" <dsmythies@telus.net>
Subject: RE: Ask for help on governor
Date: Thu, 14 Dec 2017 23:37:38 -0800
Message-ID: <002001d37577$9706a730$c513f590$@net>
References: <HE1PR0402MB282866171A847AE244A9F76CF3340@HE1PR0402MB2828.eurprd04.prod.outlook.com> <000801d37364$d48f6ed0$7dae4c70$@net> <000f01d373bf$deacca10$9c065e30$@net> <20171213061759.GT25177@vireshk-i7> P0QweRTHbuQ9TP0R1eouYx <000701d37479$e0570320$a1050960$@net> PJTJeNt3QC2CsPJTOebNwi <001f01d37544$5889d410$099d7c30$@net> PfELeWRWpC2CsPfENeiuYt
Mime-Version: 1.0
Content-Type: text/plain;
        charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cmta20.telus.net ([209.171.16.93]:38593 "EHLO cmta20.telus.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754545AbdLOHhp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 15 Dec 2017 02:37:45 -0500
In-Reply-To: PfELeWRWpC2CsPfENeiuYt
Content-Language: en-ca
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Andy Tang' <andy.tang@nxp.com>
Cc: "'Rafael J. Wysocki'" <rafael@kernel.org>, "'Rafael J. Wysocki'" <rjw@rjwysocki.net>, 'Linux PM' <linux-pm@vger.kernel.org>, 'Viresh Kumar' <viresh.kumar@linaro.org>, 'Stratos Karafotis' <stratosk@semaphore.gr>

Hi Andy,

Could you please try the below reversion patch.
It is on top of kernel 4.15-rc3.

On my system, and for the intel_cpufrequ scaling driver,
the default sampling_rate goes back to 20000 (which works)
from 500 uSec (which doesn't), for both the conservative
and ondemand governors.

>From 2e914085991d02eb5e6a197aa75485f37742a535 Mon Sep 17 00:00:00 2001
From: Doug Smythies <dsmythies@telus.net>
Date: Thu, 14 Dec 2017 22:59:44 -0800
Subject: [PATCH] Revert "cpufreq: Use transition_delay_us for legacy governors as well"

This reverts commit aa7519af450d3c62a057aece24877c34562fa25a.

There were issues with the default sampling_rate becoming to
short for some versions of cpufreq conservative and ondemand
governors to operate properly. The idle periods and load
calculations broke down.
---
 drivers/cpufreq/cpufreq.c          | 26 --------------------------
 drivers/cpufreq/cpufreq_governor.c |  9 ++++++++-
 include/linux/cpufreq.h            |  1 -
 kernel/sched/cpufreq_schedutil.c   | 11 ++++++++++-
 4 files changed, 18 insertions(+), 29 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 41d148a..9489901 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -530,32 +530,6 @@ unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
 }
 EXPORT_SYMBOL_GPL(cpufreq_driver_resolve_freq);

-unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy)
-{
-       unsigned int latency;
-
-       if (policy->transition_delay_us)
-               return policy->transition_delay_us;
-
-       latency = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
-       if (latency) {
-               /*
-                * For platforms that can change the frequency very fast (< 10
-                * us), the above formula gives a decent transition delay. But
-                * for platforms where transition_latency is in milliseconds, it
-                * ends up giving unrealistic values.
-                *
-                * Cap the default transition delay to 10 ms, which seems to be
-                * a reasonable amount of time after which we should reevaluate
-                * the frequency.
-                */
-               return min(latency * LATENCY_MULTIPLIER, (unsigned int)10000);
-       }
-
-       return LATENCY_MULTIPLIER;
-}
-EXPORT_SYMBOL_GPL(cpufreq_policy_transition_delay_us);
-
 /*********************************************************************
  *                          SYSFS INTERFACE                          *
  *********************************************************************/
diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index 58d4f4e..6302eb4 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -392,6 +392,7 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
        struct dbs_governor *gov = dbs_governor_of(policy);
        struct dbs_data *dbs_data;
        struct policy_dbs_info *policy_dbs;
+       unsigned int latency;
        int ret = 0;

        /* State should be equivalent to EXIT */
@@ -430,7 +431,13 @@ int cpufreq_dbs_governor_init(struct cpufreq_policy *policy)
        if (ret)
                goto free_policy_dbs_info;

-       dbs_data->sampling_rate = cpufreq_policy_transition_delay_us(policy);
+       /* policy latency is in ns. Convert it to us first */
+       latency = policy->cpuinfo.transition_latency / 1000;
+       if (latency == 0)
+               latency = 1;
+
+       /* Bring kernel and HW constraints together */
+       dbs_data->sampling_rate = LATENCY_MULTIPLIER * latency;

        if (!have_governor_per_policy())
                gov->gdbs_data = dbs_data;
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 065f3a8..75d5bd9 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -533,7 +533,6 @@ int __cpufreq_driver_target(struct cpufreq_policy *policy,
                                   unsigned int relation);
 unsigned int cpufreq_driver_resolve_freq(struct cpufreq_policy *policy,
                                         unsigned int target_freq);
-unsigned int cpufreq_policy_transition_delay_us(struct cpufreq_policy *policy);
 int cpufreq_register_governor(struct cpufreq_governor *governor);
 void cpufreq_unregister_governor(struct cpufreq_governor *governor);

diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
index 2f52ec0..a61d7fa 100644
--- a/kernel/sched/cpufreq_schedutil.c
+++ b/kernel/sched/cpufreq_schedutil.c
@@ -583,7 +583,16 @@ static int sugov_init(struct cpufreq_policy *policy)
                goto stop_kthread;
        }

-       tunables->rate_limit_us = cpufreq_policy_transition_delay_us(policy);
+       if (policy->transition_delay_us) {
+               tunables->rate_limit_us = policy->transition_delay_us;
+       } else {
+               unsigned int lat;
+
+               tunables->rate_limit_us = LATENCY_MULTIPLIER;
+               lat = policy->cpuinfo.transition_latency / NSEC_PER_USEC;
+               if (lat)
+                       tunables->rate_limit_us *= lat;
+       }

        policy->governor_data = sg_policy;
        sg_policy->tunables = tunables;
--
2.7.4
