From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v4 7/7] thermal:boost: Disable boost when trip point is reached
Date: Wed, 19 Jun 2013 19:12:48 +0200
Message-ID: <1371661969-7660-8-git-send-email-l.majewski@samsung.com>
References: <1370502472-7249-1-git-send-email-l.majewski@samsung.com>
 <1371661969-7660-1-git-send-email-l.majewski@samsung.com>
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <1371661969-7660-1-git-send-email-l.majewski@samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocky" <rjw@sisk.pl>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Lukasz Majewski <l.majewski@samsung.com>, Jonghwa Lee <jonghwa3.lee@samsung.com>, Myungjoo Ham <myungjoo.ham@samsung.com>, linux-kernel <linux-kernel@vger.kernel.org>, Lukasz Majewski <l.majewski@majess.pl>, Andre Przywara <andre.przywara@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kukjin Kim <kgene.kim@samsung.com>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

This patch provides support for disabling cpufreq's boost
feature when thermal trip point is reached.

Signed-off-by: Lukasz Majewski <l.majewski@samsung.com>
Signed-off-by: Myungjoo Ham <myungjoo.ham@samsung.com>

Changes for v4:
- New patch
---
 drivers/thermal/cpu_cooling.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index c94bf2e..3bdd870 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -323,6 +323,9 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 	if (cpumask_test_cpu(policy->cpu, &notify_device->allowed_cpus))
 		max_freq = notify_device->cpufreq_val;
 
+	if (cpufreq_boost_supported())
+		cpufreq_boost_trigger_state(0);
+
 	/* Never exceed user_policy.max */
 	if (max_freq > policy->user_policy.max)
 		max_freq = policy->user_policy.max;
-- 
1.7.10.4

