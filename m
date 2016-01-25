From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] cpufreq: cpufreq-dt: avoid uninitialized variable warnings:
Date: Mon, 25 Jan 2016 16:45:48 +0100
Message-ID: <1453736756-1959377-1-git-send-email-arnd@arndb.de>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

gcc warns quite a bit about values returned from allocate_resources()
in cpufreq-dt.c:

cpufreq-dt.c: In function 'cpufreq_init':
cpufreq-dt.c:327:6: error: 'cpu_dev' may be used uninitialized in this function [-Werror=maybe-uninitialized]
cpufreq-dt.c:197:17: note: 'cpu_dev' was declared here
cpufreq-dt.c:376:2: error: 'cpu_clk' may be used uninitialized in this function [-Werror=maybe-uninitialized]
cpufreq-dt.c:199:14: note: 'cpu_clk' was declared here
cpufreq-dt.c: In function 'dt_cpufreq_probe':
cpufreq-dt.c:461:2: error: 'cpu_clk' may be used uninitialized in this function [-Werror=maybe-uninitialized]
cpufreq-dt.c:447:14: note: 'cpu_clk' was declared here

The problem is that it's slightly hard for gcc to follow return
codes across PTR_ERR() calls.
This patch uses explicit assignments to the "ret" variable to make
it easier for gcc to verify that the code is actually correct,
without the need to add a bogus initialization.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/cpufreq-dt.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/cpufreq/cpufreq-dt.c b/drivers/cpufreq/cpufreq-dt.c
index 9bc37c437874..0ca74d070058 100644
--- a/drivers/cpufreq/cpufreq-dt.c
+++ b/drivers/cpufreq/cpufreq-dt.c
@@ -142,15 +142,16 @@ static int allocate_resources(int cpu, struct device **cdev,
 
 try_again:
 	cpu_reg = regulator_get_optional(cpu_dev, reg);
-	if (IS_ERR(cpu_reg)) {
+	ret = PTR_ERR_OR_ZERO(cpu_reg);
+	if (ret) {
 		/*
 		 * If cpu's regulator supply node is present, but regulator is
 		 * not yet registered, we should try defering probe.
 		 */
-		if (PTR_ERR(cpu_reg) == -EPROBE_DEFER) {
+		if (ret == -EPROBE_DEFER) {
 			dev_dbg(cpu_dev, "cpu%d regulator not ready, retry\n",
 				cpu);
-			return -EPROBE_DEFER;
+			return ret;
 		}
 
 		/* Try with "cpu-supply" */
@@ -159,18 +160,16 @@ try_again:
 			goto try_again;
 		}
 
-		dev_dbg(cpu_dev, "no regulator for cpu%d: %ld\n",
-			cpu, PTR_ERR(cpu_reg));
+		dev_dbg(cpu_dev, "no regulator for cpu%d: %d\n", cpu, ret);
 	}
 
 	cpu_clk = clk_get(cpu_dev, NULL);
-	if (IS_ERR(cpu_clk)) {
+	ret = PTR_ERR_OR_ZERO(cpu_clk);
+	if (ret) {
 		/* put regulator */
 		if (!IS_ERR(cpu_reg))
 			regulator_put(cpu_reg);
 
-		ret = PTR_ERR(cpu_clk);
-
 		/*
 		 * If cpu's clk node is present, but clock is not yet
 		 * registered, we should try defering probe.
-- 
2.7.0
