From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH 1/3 linux-next] cpufreq: conservative: Fix sampling_down_factor
 functionality
Date: Wed, 06 Mar 2013 00:06:29 +0200
Message-ID: <51366C65.7070802@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Rob Landley <rob@landley.net>
Cc: linux-doc@vger.kernel.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

sampling_down_factor tunable is unused since commit
8e677ce83bf41ba9c74e5b6d9ee60b07d4e5ed93 (4 years ago).

This patch restores the original functionality and documents the
tunable.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 Documentation/cpu-freq/governors.txt   |  6 ++++++
 drivers/cpufreq/cpufreq_conservative.c | 11 ++++++++---
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/Documentation/cpu-freq/governors.txt b/Documentation/cpu-freq/governors.txt
index c7a2eb8..4dfed30 100644
--- a/Documentation/cpu-freq/governors.txt
+++ b/Documentation/cpu-freq/governors.txt
@@ -191,6 +191,12 @@ governor but for the opposite direction.  For example when set to its
 default value of '20' it means that if the CPU usage needs to be below
 20% between samples to have the frequency decreased.
 
+sampling_down_factor: similar functionality as in "ondemand" governor.
+But in "conservative", it controls the rate at which the kernel makes
+a decision on when to decrease the frequency while running in any
+speed. Load for frequency increase is still evaluated every
+sampling rate.
+
 3. The Governor Interface in the CPUfreq Core
 =============================================
 
diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index 4fd0006..1e3be56 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -44,9 +44,9 @@ static struct cs_dbs_tuners cs_tuners = {
 
 /*
  * Every sampling_rate, we check, if current idle time is less than 20%
- * (default), then we try to increase frequency Every sampling_rate *
- * sampling_down_factor, we check, if current idle time is more than 80%, then
- * we try to decrease frequency
+ * (default), then we try to increase frequency. Every sampling_rate *
+ * sampling_down_factor, we check, if current idle time is more than 80%
+ * (default), then we try to decrease frequency
  *
  * Any frequency increase takes it to the maximum frequency. Frequency reduction
  * happens at minimum steps of 5% (default) of maximum frequency
@@ -87,6 +87,11 @@ static void cs_check_cpu(int cpu, unsigned int load)
 		return;
 	}
 
+	/* if sampling_down_factor is active break out early */
+	if (++dbs_info->down_skip < cs_tuners.sampling_down_factor)
+		return;
+	dbs_info->down_skip = 0;
+
 	/*
 	 * The optimal frequency is the frequency that is the lowest that can
 	 * support the current CPU usage without triggering the up policy. To be
-- 
1.8.1.4

