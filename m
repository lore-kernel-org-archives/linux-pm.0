From: Daniel Vetter <daniel.vetter@ffwll.ch>
Subject: [PATCH 04/12] cpufreq: use for_each_if
Date: Mon,  9 Jul 2018 10:36:42 +0200
Message-ID: <20180709083650.23549-4-daniel.vetter@ffwll.ch>
References: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180709083650.23549-1-daniel.vetter@ffwll.ch>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: DRI Development <dri-devel@lists.freedesktop.org>, Intel Graphics Development <intel-gfx@lists.freedesktop.org>, Daniel Vetter <daniel.vetter@ffwll.ch>, Daniel Vetter <daniel.vetter@intel.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Avoids the inverted condition compared to the open coded version.

Signed-off-by: Daniel Vetter <daniel.vetter@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-pm@vger.kernel.org
---
 include/linux/cpufreq.h | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 882a9b9e34bc..f2028c229b96 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -649,9 +649,7 @@ static inline void dev_pm_opp_free_cpufreq_table(struct device *dev,
 
 #define cpufreq_for_each_valid_entry(pos, table)			\
 	for (pos = table; pos->frequency != CPUFREQ_TABLE_END; pos++)	\
-		if (pos->frequency == CPUFREQ_ENTRY_INVALID)		\
-			continue;					\
-		else
+		for_each_if (pos->frequency != CPUFREQ_ENTRY_INVALID)
 
 /*
  * cpufreq_for_each_valid_entry_idx -     iterate with index over a cpufreq
@@ -663,9 +661,7 @@ static inline void dev_pm_opp_free_cpufreq_table(struct device *dev,
 
 #define cpufreq_for_each_valid_entry_idx(pos, table, idx)		\
 	cpufreq_for_each_entry_idx(pos, table, idx)			\
-		if (pos->frequency == CPUFREQ_ENTRY_INVALID)		\
-			continue;					\
-		else
+		for_each_if (pos->frequency == CPUFREQ_ENTRY_INVALID)
 
 
 int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
-- 
2.18.0
