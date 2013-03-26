From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: cpu0: Fix mistake in Documentation example
Date: Tue, 26 Mar 2013 20:10:46 +0530
Message-ID: <225d20676ec96aa81683f23485f0339e32a22917.1364308732.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl, shawn.guo@linaro.org
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linaro-kernel@lists.linaro.org, arvind.chauhan@arm.com, robin.randhawa@arm.com, Steve.Bannister@arm.com, Liviu.Dudau@arm.com, charles.garcia-tobin@arm.com, rob.herring@calxeda.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

"clock-latency" is incorrectly written as "transition-latency" in an example
present in Documentation of cpufreq-cpu0. Fix it.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
index 4416ccc..051f764 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-cpu0.txt
@@ -32,7 +32,7 @@ cpus {
 			396000  950000
 			198000  850000
 		>;
-		transition-latency = <61036>; /* two CLK32 periods */
+		clock-latency = <61036>; /* two CLK32 periods */
 	};
 
 	cpu@1 {
-- 
1.7.12.rc2.18.g61b472e

