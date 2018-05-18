From: Dmitry Osipenko <digetx@gmail.com>
Subject: [PATCH v2 07/11] cpufreq: tegra20: Remove unnecessary parentheses
Date: Fri, 18 May 2018 23:06:38 +0300
Message-ID: <20180518200642.24815-8-digetx@gmail.com>
References: <20180518200642.24815-1-digetx@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180518200642.24815-1-digetx@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>
List-Id: linux-pm@vger.kernel.org

Remove unnecessary parentheses as suggested by the checkpatch script.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/cpufreq/tegra20-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/tegra20-cpufreq.c b/drivers/cpufreq/tegra20-cpufreq.c
index df25e350c8e6..4b85a6733533 100644
--- a/drivers/cpufreq/tegra20-cpufreq.c
+++ b/drivers/cpufreq/tegra20-cpufreq.c
@@ -50,7 +50,7 @@ static unsigned int tegra_get_intermediate(struct cpufreq_policy *policy,
 	 * - we are already at it, i.e. policy->cur == ifreq
 	 * - index corresponds to ifreq
 	 */
-	if ((freq_table[index].frequency == ifreq) || (policy->cur == ifreq))
+	if (freq_table[index].frequency == ifreq || policy->cur == ifreq)
 		return 0;
 
 	return ifreq;
-- 
2.17.0
