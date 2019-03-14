From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 1/7] cpufreq: Pass policy->related_cpus to transition notifiers
Date: Thu, 14 Mar 2019 12:12:47 +0530
Message-ID: <3b6663b03fe837615ba608aff50b4b2a27ab2ab3.1552545525.git.viresh.kumar@linaro.org>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1552545525.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Currently we call these notifiers once for each CPU of the policy->cpus
cpumask, which isn't that efficient.

This patch adds a cpumask pointer to struct cpufreq_freqs and copies
policy->related_cpus to it. The notifiers will have information about
all the affected CPUs now with the first call itself and once all the
notifier callbacks are updated to use the new field, we can remove the
"cpu" field from struct cpufreq_freqs and call the notifier only once
per policy.

Some of the transition notifier users use per-cpu data to read and store
their data and they rely on it being correct. With CPU offline/online
sequences we may end up with using stale data for those CPUs (which are
offlined/onlined). In order to avoid such corner cases, this patch uses
policy->related_cpus instead of policy->cpus.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 1 +
 include/linux/cpufreq.h   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 0e626b00053b..b1b012169f00 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -311,6 +311,7 @@ static void cpufreq_notify_transition(struct cpufreq_policy *policy,
 	if (cpufreq_disabled())
 		return;
 
+	freqs->cpus = policy->related_cpus;
 	freqs->flags = cpufreq_driver->flags;
 	pr_debug("notification %u of frequency transition to %u kHz\n",
 		 state, freqs->new);
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index b160e98076e3..dd318363dfc2 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -43,6 +43,7 @@ enum cpufreq_table_sorting {
 };
 
 struct cpufreq_freqs {
+	struct cpumask *cpus;
 	unsigned int cpu;	/* cpu nr */
 	unsigned int old;
 	unsigned int new;
-- 
2.21.0.rc0.269.g1a574e7a288b
