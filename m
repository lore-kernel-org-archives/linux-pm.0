From: Steve Muckle <steve.muckle@linaro.org>
Subject: [PATCH v3 3/3] cpufreq: acpi-cpufreq: use cached frequency mapping when possible
Date: Wed, 13 Jul 2016 13:25:27 -0700
Message-ID: <1468441527-23534-4-git-send-email-smuckle@linaro.org>
References: <1468441527-23534-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f54.google.com ([209.85.220.54]:36791 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750996AbcGMUZq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2016 16:25:46 -0400
Received: by mail-pa0-f54.google.com with SMTP id pp5so14118334pac.3
        for <linux-pm@vger.kernel.org>; Wed, 13 Jul 2016 13:25:45 -0700 (PDT)
In-Reply-To: <1468441527-23534-1-git-send-email-smuckle@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>

A call to cpufreq_driver_resolve_freq will cache the mapping from
the desired target frequency to the frequency table index. If there
is a mapping for the desired target frequency then use it instead of
looking up the mapping again.

Signed-off-by: Steve Muckle <smuckle@linaro.org>
---
 drivers/cpufreq/acpi-cpufreq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 11c9a078e0fd..297e9128fe9f 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -473,7 +473,10 @@ unsigned int acpi_cpufreq_fast_switch(struct cpufreq_policy *policy,
 	/*
 	 * Find the closest frequency above target_freq.
 	 */
-	index = cpufreq_table_find_index_dl(policy, target_freq);
+	if (policy->cached_target_freq == target_freq)
+		index = policy->cached_resolved_idx;
+	else
+		index = cpufreq_table_find_index_dl(policy, target_freq);
 
 	entry = &policy->freq_table[index];
 	next_freq = entry->frequency;
-- 
2.7.3

