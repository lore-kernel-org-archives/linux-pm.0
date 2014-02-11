From: Josh Cartwright <joshc@codeaurora.org>
Subject: [PATCH 8/8] cpufreq: ppc: make use of of_find_matching_node_and_match
Date: Tue, 11 Feb 2014 10:24:06 -0600
Message-ID: <1392135847-30791-9-git-send-email-joshc@codeaurora.org>
References: <1392135847-30791-1-git-send-email-joshc@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1392135847-30791-1-git-send-email-joshc@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Instead of the of_find_matching_node()/of_match_node() pair, which requires two
iterations through the match table, make use of of_find_matching_node_and_match(),
which only iterates through the table once.

Signed-off-by: Josh Cartwright <joshc@codeaurora.org>
---
 drivers/cpufreq/ppc-corenet-cpufreq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/cpufreq/ppc-corenet-cpufreq.c b/drivers/cpufreq/ppc-corenet-cpufreq.c
index 051000f..041ef3a 100644
--- a/drivers/cpufreq/ppc-corenet-cpufreq.c
+++ b/drivers/cpufreq/ppc-corenet-cpufreq.c
@@ -278,7 +278,7 @@ static int __init ppc_corenet_cpufreq_init(void)
 	const struct soc_data *data;
 	unsigned int cpu;
 
-	np = of_find_matching_node(NULL, node_matches);
+	np = of_find_matching_node_and_match(NULL, node_matches, &match);
 	if (!np)
 		return -ENODEV;
 
@@ -288,7 +288,6 @@ static int __init ppc_corenet_cpufreq_init(void)
 		cpumask_copy(per_cpu(cpu_mask, cpu), cpu_core_mask(cpu));
 	}
 
-	match = of_match_node(node_matches, np);
 	data = match->data;
 	if (data) {
 		if (data->flag)
-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
