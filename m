From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Fix typos
Date: Fri,  3 Feb 2017 15:26:25 +0530
Message-ID: <4164c0bc9ba2e15876c8efe868f9ae1c851f105b.1486115779.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

- s/freqnency/frequency
-s/accomodating/accommodating

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/cpufreq.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index b07838b1fc60..87165f06a307 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -31,7 +31,7 @@
 
 #define CPUFREQ_ETERNAL			(-1)
 #define CPUFREQ_NAME_LEN		16
-/* Print length for names. Extra 1 space for accomodating '\n' in prints */
+/* Print length for names. Extra 1 space for accommodating '\n' in prints */
 #define CPUFREQ_NAME_PLEN		(CPUFREQ_NAME_LEN + 1)
 
 struct cpufreq_governor;
@@ -115,7 +115,7 @@ struct cpufreq_policy {
 	 *   guarantee that frequency can be changed on any CPU sharing the
 	 *   policy and that the change will affect all of the policy CPUs then.
 	 * - fast_switch_enabled is to be set by governors that support fast
-	 *   freqnency switching with the help of cpufreq_enable_fast_switch().
+	 *   frequency switching with the help of cpufreq_enable_fast_switch().
 	 */
 	bool			fast_switch_possible;
 	bool			fast_switch_enabled;
-- 
2.7.1.410.g6faf27b
