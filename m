From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 3/7] ARM: twd: Update cpufreq transition notifier to handle multiple CPUs
Date: Thu, 14 Mar 2019 12:12:49 +0530
Message-ID: <3c977305886032ba871bd266d555ede47b4576fc.1552545525.git.viresh.kumar@linaro.org>
References: <cover.1552545525.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1552545525.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Russell King <linux@armlinux.org.uk>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The cpufreq core currently calls the cpufreq transition notifier
callback once for each affected CPU. This is going to change soon and
the cpufreq core will call the callback only once for each cpufreq
policy. The callback must look at the newly added field in struct
cpufreq_freqs, "cpus", which contains policy->related_cpus (both
online/offline CPUs) and perform per-cpu actions for them if any.

This patch updates twd_cpufreq_transition() to use the new "cpus" field
and run twd_update_frequency() for each online CPU present in the
freqs->cpus.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 arch/arm/kernel/smp_twd.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/smp_twd.c b/arch/arm/kernel/smp_twd.c
index b30eafeef096..df7db45d931b 100644
--- a/arch/arm/kernel/smp_twd.c
+++ b/arch/arm/kernel/smp_twd.c
@@ -162,15 +162,18 @@ static int twd_cpufreq_transition(struct notifier_block *nb,
 	unsigned long state, void *data)
 {
 	struct cpufreq_freqs *freqs = data;
+	int cpu;
 
 	/*
 	 * The twd clock events must be reprogrammed to account for the new
 	 * frequency.  The timer is local to a cpu, so cross-call to the
 	 * changing cpu.
 	 */
-	if (state == CPUFREQ_POSTCHANGE)
-		smp_call_function_single(freqs->cpu, twd_update_frequency,
-			NULL, 1);
+	if (state != CPUFREQ_POSTCHANGE)
+		return NOTIFY_OK;
+
+	for_each_cpu_and(cpu, freqs->cpus, cpu_online_mask)
+		smp_call_function_single(cpu, twd_update_frequency, NULL, 1);
 
 	return NOTIFY_OK;
 }
-- 
2.21.0.rc0.269.g1a574e7a288b
