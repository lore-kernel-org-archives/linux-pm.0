From: Ed Swarthout <Ed.Swarthout@freescale.com>
Subject: [PATCH] cpufreq: ppc-corenet-cpu-freq: do_div use quotient
Date: Thu, 5 Jun 2014 18:56:17 -0500
Message-ID: <1402012577-27354-1-git-send-email-Ed.Swarthout@freescale.com>
References: <1401917713-20792-1-git-send-email-Ed.Swarthout@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bn1lp0140.outbound.protection.outlook.com ([207.46.163.140]:57813
	"EHLO na01-bn1-obe.outbound.protection.outlook.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751419AbaFEX4f (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 5 Jun 2014 19:56:35 -0400
In-Reply-To: <1401917713-20792-1-git-send-email-Ed.Swarthout@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: scottwood@freescale.com, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, Ed Swarthout <Ed.Swarthout@freescale.com>

6712d2931933ada259b82f06c03a855b19937074 (cpufreq:
ppc-corenet-cpufreq: Fix __udivdi3 modpost error) used the remainder
from do_div instead of the quotient. Fix that and add one to ensure
minimum is met.

Signed-off-by: Ed Swarthout <Ed.Swarthout@freescale.com>
---

Resend to include linux-pm list.

Decided to rename the temporary variable since the value isn't
a latency until after the division and then it is in nsec.

Tested on t4240qds and p4080ds.

https://patchwork.kernel.org/patch/4296811/
http://patchwork.ozlabs.org/patch/356096/

 drivers/cpufreq/ppc-corenet-cpufreq.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
index 0af618a..3607070 100644
--- a/drivers/cpufreq/ppc-corenet-cpufreq.c
+++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
@@ -138,7 +138,7 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	struct cpufreq_frequency_table *table;
 	struct cpu_data *data;
 	unsigned int cpu = policy->cpu;
-	u64 transition_latency_hz;
+	u64 u64temp;
 
 	np = of_get_cpu_node(cpu, NULL);
 	if (!np)
@@ -206,9 +206,10 @@ static int corenet_cpufreq_cpu_init(struct cpufreq_policy *policy)
 	for_each_cpu(i, per_cpu(cpu_mask, cpu))
 		per_cpu(cpu_data, i) = data;
 
-	transition_latency_hz = 12ULL * NSEC_PER_SEC;
-	policy->cpuinfo.transition_latency =
-		do_div(transition_latency_hz, fsl_get_sys_freq());
+	/* Minimum transition latency is 12 platform clocks */
+	u64temp = 12ULL * NSEC_PER_SEC;
+	do_div(u64temp, fsl_get_sys_freq());
+	policy->cpuinfo.transition_latency = u64temp + 1;
 
 	of_node_put(np);
 
-- 
1.9.1

