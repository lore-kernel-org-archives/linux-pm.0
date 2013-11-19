From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: [PATCH 1/1] cpufreq: exynos: Fix line over 80 characters warning
Date: Tue, 19 Nov 2013 10:37:19 +0530
Message-ID: <1384837639-9252-1-git-send-email-sachin.kamat@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: cpufreq@vger.kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org, sachin.kamat@linaro.org, Jonghwan Choi <jhbird.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

Silences the checkpatch warning introduced by
commit 94aa44090eda ("cpufreq: exynos: Add missing static").

Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
Cc: Jonghwan Choi <jhbird.choi@samsung.com>
---
 drivers/cpufreq/exynos5250-cpufreq.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/exynos5250-cpufreq.c b/drivers/cpufreq/exynos5250-cpufreq.c
index 8feda86fe42c..ebbcbb7e1926 100644
--- a/drivers/cpufreq/exynos5250-cpufreq.c
+++ b/drivers/cpufreq/exynos5250-cpufreq.c
@@ -144,7 +144,8 @@ static void set_apll(unsigned int new_index,
 
 }
 
-static bool exynos5250_pms_change(unsigned int old_index, unsigned int new_index)
+static bool exynos5250_pms_change(unsigned int old_index,
+				  unsigned int new_index)
 {
 	unsigned int old_pm = apll_freq_5250[old_index].mps >> 8;
 	unsigned int new_pm = apll_freq_5250[new_index].mps >> 8;
-- 
1.7.9.5

