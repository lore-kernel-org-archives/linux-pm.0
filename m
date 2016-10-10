From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH] cpufreq: skip invalid entries when searching the frequency
Date: Tue, 11 Oct 2016 00:38:13 +0300
Message-ID: <20161010213813.22087-1-aaro.koskinen@iki.fi>
References: <20161007225925.GI15204@raspberrypi.musicnaut.iki.fi>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:36536 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751708AbcJJViU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2016 17:38:20 -0400
In-Reply-To: <20161007225925.GI15204@raspberrypi.musicnaut.iki.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Aaro Koskinen <aaro.koskinen@iki.fi>

Skip invalid entries when searching the frequency. This fixes cpufreq
at least on loongson2 MIPS board.

Fixes: da0c6dc00c69 ("cpufreq: Handle sorted frequency tables more efficiently")
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 include/linux/cpufreq.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 631ba33b..0c1b188 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -645,6 +645,9 @@ static inline int cpufreq_table_find_index_al(struct cpufreq_policy *policy,
 	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
 		freq = table[i].frequency;
 
+		if (freq == CPUFREQ_ENTRY_INVALID)
+			continue;
+
 		if (freq >= target_freq)
 			return i;
 
@@ -665,6 +668,9 @@ static inline int cpufreq_table_find_index_dl(struct cpufreq_policy *policy,
 	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
 		freq = table[i].frequency;
 
+		if (freq == CPUFREQ_ENTRY_INVALID)
+			continue;
+
 		if (freq == target_freq)
 			return i;
 
@@ -706,6 +712,9 @@ static inline int cpufreq_table_find_index_ah(struct cpufreq_policy *policy,
 	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
 		freq = table[i].frequency;
 
+		if (freq == CPUFREQ_ENTRY_INVALID)
+			continue;
+
 		if (freq == target_freq)
 			return i;
 
@@ -735,6 +744,9 @@ static inline int cpufreq_table_find_index_dh(struct cpufreq_policy *policy,
 	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
 		freq = table[i].frequency;
 
+		if (freq == CPUFREQ_ENTRY_INVALID)
+			continue;
+
 		if (freq <= target_freq)
 			return i;
 
@@ -767,6 +779,9 @@ static inline int cpufreq_table_find_index_ac(struct cpufreq_policy *policy,
 	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
 		freq = table[i].frequency;
 
+		if (freq == CPUFREQ_ENTRY_INVALID)
+			continue;
+
 		if (freq == target_freq)
 			return i;
 
@@ -800,6 +815,9 @@ static inline int cpufreq_table_find_index_dc(struct cpufreq_policy *policy,
 	for (i = 0; table[i].frequency != CPUFREQ_TABLE_END; i++) {
 		freq = table[i].frequency;
 
+		if (freq == CPUFREQ_ENTRY_INVALID)
+			continue;
+
 		if (freq == target_freq)
 			return i;
 
-- 
2.9.2

