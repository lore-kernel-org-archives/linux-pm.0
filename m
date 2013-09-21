From: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
Subject: [PATCH v4 2/3] Cpufreq: s5pv210 cpufreq fixes for CCF
Date: Sat, 21 Sep 2013 19:42:21 +0200
Message-ID: <1379785342-25107-3-git-send-email-m.krawczuk@partner.samsung.com>
References: <1379785342-25107-1-git-send-email-m.krawczuk@partner.samsung.com>
Return-path: <cpufreq-owner@vger.kernel.org>
In-reply-to: <1379785342-25107-1-git-send-email-m.krawczuk@partner.samsung.com>
Sender: cpufreq-owner@vger.kernel.org
To: mturquette@linaro.org
Cc: rob@landley.net, ijc+devicetree@hellion.org.uk, swarren@wwwdotorg.org, mark.rutland@arm.com, pawel.moll@arm.com, rob.herring@calxeda.com, kgene.kim@samsung.com, ben-linux@fluff.org, kyungmin.park@samsung.com, linux@arm.linux.org.uk, tomasz.figa@gmail.com, t.figa@samsung.com, thomas.abraham@linaro.org, s.nawrocki@samsung.com, rjw@sisk.pl, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

Use common clock framework api to get clock.

Signed-off-by: Mateusz Krawczuk <m.krawczuk@partner.samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 drivers/cpufreq/s5pv210-cpufreq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index 5c77570..33948d6 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -511,17 +511,17 @@ static int __init s5pv210_cpu_init(struct cpufreq_policy *policy)
 	unsigned long mem_type;
 	int ret;
 
-	cpu_clk = clk_get(NULL, "armclk");
+	cpu_clk = clk_get_sys("s5pv210-cpufreq", "armclk");
 	if (IS_ERR(cpu_clk))
 		return PTR_ERR(cpu_clk);
 
-	dmc0_clk = clk_get(NULL, "sclk_dmc0");
+	dmc0_clk = clk_get_sys("s5pv210-cpufreq", "sclk_dmc0");
 	if (IS_ERR(dmc0_clk)) {
 		ret = PTR_ERR(dmc0_clk);
 		goto out_dmc0;
 	}
 
-	dmc1_clk = clk_get(NULL, "hclk_msys");
+	dmc1_clk = clk_get_sys("s5pv210-cpufreq", "hclk_msys");
 	if (IS_ERR(dmc1_clk)) {
 		ret = PTR_ERR(dmc1_clk);
 		goto out_dmc1;
-- 
1.8.1.2

