From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: loongson2_cpufreq: don't declare local variable as static
Date: Wed,  2 Apr 2014 10:14:24 +0530
Message-ID: <254471b8cee296f860d24368cc467c00b5a07336.1396413826.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linaro-kernel@lists.linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lxoliva@fsfla.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Earlier commit:
	commit 652ed95d5fa6074b3c4ea245deb0691f1acb6656
	Author: Viresh Kumar <viresh.kumar@linaro.org>
	Date:   Thu Jan 9 20:38:43 2014 +0530

	    cpufreq: introduce cpufreq_generic_get() routine

did some changes to driver and by mistake made cpuclk as a 'static' local
variable, which wasn't actually required. Fix it.

Reported-by: Alexandre Oliva <lxoliva@fsfla.org>
Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/loongson2_cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/loongson2_cpufreq.c b/drivers/cpufreq/loongson2_cpufreq.c
index a3588d61..f0bc31f 100644
--- a/drivers/cpufreq/loongson2_cpufreq.c
+++ b/drivers/cpufreq/loongson2_cpufreq.c
@@ -69,7 +69,7 @@ static int loongson2_cpufreq_target(struct cpufreq_policy *policy,
 
 static int loongson2_cpufreq_cpu_init(struct cpufreq_policy *policy)
 {
-	static struct clk *cpuclk;
+	struct clk *cpuclk;
 	int i;
 	unsigned long rate;
 	int ret;
-- 
1.7.12.rc2.18.g61b472e

