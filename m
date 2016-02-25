From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] cpufreq: Simplify the cpufreq_for_each_valid_entry()
Date: Fri, 26 Feb 2016 00:22:57 +0100
Message-ID: <1966438.kvLUD13Eaz@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53760 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752248AbcBYXVX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 25 Feb 2016 18:21:23 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

That macro uses an internal static inline function that is first
totally unnecessary and second hard to read, so simplify it and
get rid of that monster.

No functional changes.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 include/linux/cpufreq.h |   17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

Index: linux-pm/include/linux/cpufreq.h
===================================================================
--- linux-pm.orig/include/linux/cpufreq.h
+++ linux-pm/include/linux/cpufreq.h
@@ -534,16 +534,6 @@ static inline void dev_pm_opp_free_cpufr
 }
 #endif
 
-static inline bool cpufreq_next_valid(struct cpufreq_frequency_table **pos)
-{
-	while ((*pos)->frequency != CPUFREQ_TABLE_END)
-		if ((*pos)->frequency != CPUFREQ_ENTRY_INVALID)
-			return true;
-		else
-			(*pos)++;
-	return false;
-}
-
 /*
  * cpufreq_for_each_entry -	iterate over a cpufreq_frequency_table
  * @pos:	the cpufreq_frequency_table * to use as a loop cursor.
@@ -560,8 +550,11 @@ static inline bool cpufreq_next_valid(st
  * @table:      the cpufreq_frequency_table * to iterate over.
  */
 
-#define cpufreq_for_each_valid_entry(pos, table)	\
-	for (pos = table; cpufreq_next_valid(&pos); pos++)
+#define cpufreq_for_each_valid_entry(pos, table)			\
+	for (pos = table; pos->frequency != CPUFREQ_TABLE_END; pos++)	\
+		if (pos->frequency == CPUFREQ_ENTRY_INVALID)		\
+			continue;					\
+		else
 
 int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
 				    struct cpufreq_frequency_table *table);

