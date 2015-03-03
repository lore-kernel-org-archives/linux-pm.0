From: Leo Yan <leo.yan@linaro.org>
Subject: [PATCH 2/2] ARM: mvebu: update cpufreq-dt's platform data
Date: Tue,  3 Mar 2015 21:03:37 +0800
Message-ID: <1425387817-11382-3-git-send-email-leo.yan@linaro.org>
References: <1425387817-11382-1-git-send-email-leo.yan@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425387817-11382-1-git-send-email-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawn.guo@linaro.org>, Thomas Petazzoni <thomas.petazzoni@free-electrons.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: Leo Yan <leo.yan@linaro.org>
List-Id: linux-pm@vger.kernel.org

Change to use cpufreq-dt's platform data of clk_domain_boundary; in
the old code the initial value is true, that means every CPU has the
dedicated clock. So assign as CPUFREQ_DT_CLK_PER_CPU.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 arch/arm/mach-mvebu/pmsu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-mvebu/pmsu.c b/arch/arm/mach-mvebu/pmsu.c
index 8b9f5e2..1fd3f89 100644
--- a/arch/arm/mach-mvebu/pmsu.c
+++ b/arch/arm/mach-mvebu/pmsu.c
@@ -573,7 +573,7 @@ int mvebu_pmsu_dfs_request(int cpu)
 }
 
 struct cpufreq_dt_platform_data cpufreq_dt_pd = {
-	.independent_clocks = true,
+	.clk_domain_boundary = CPUFREQ_DT_CLK_PER_CPU,
 };
 
 static int __init armada_xp_pmsu_cpufreq_init(void)
-- 
1.9.1
