From: Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: [PATCH v3 04/10] cpufreq: dt: invoke frequency-invariance setter function
Date: Thu, 27 Jul 2017 20:33:06 +0100
Message-ID: <20170727193312.9849-5-dietmar.eggemann@arm.com>
References: <20170727193312.9849-1-dietmar.eggemann@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170727193312.9849-1-dietmar.eggemann@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: linux-pm@vger.kernel.org, linux@arm.linux.org.uk, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk+kernel@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, Juri Lelli <juri.lelli@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Peter Zijlstra <peterz@infradead.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>
List-Id: linux-pm@vger.kernel.org

Call the frequency-invariance setter function arch_set_freq_scale()
if the new frequency has been successfully set which is indicated by
dev_pm_opp_set_rate() returning 0.

Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
---
 drivers/cpufreq/cpufreq-dt.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index fef3c2160691..cbac8a7dbc50 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -43,9 +43,17 @@ static struct freq_attr *cpufreq_dt_attr[] = {
 static int set_target(struct cpufreq_policy *policy, unsigned int index)
 {
 	struct private_data *priv = policy->driver_data;
+	unsigned long freq = policy->freq_table[index].frequency;
+	int ret;
+
+	ret = dev_pm_opp_set_rate(priv->cpu_dev, freq * 1000);
 
-	return dev_pm_opp_set_rate(priv->cpu_dev,
-				   policy->freq_table[index].frequency * 1000);
+	if (!ret) {
+		arch_set_freq_scale(policy->related_cpus, freq,
+				    policy->cpuinfo.max_freq);
+	}
+
+	return ret;
 }
 
 /*
-- 
2.11.0
