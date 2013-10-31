From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH] cpufreq: ondemand: Remove redundant return statement
Date: Thu, 31 Oct 2013 20:27:36 +0200
Message-ID: <5272A118.1090908@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Henrik Nilsson <Karl.Henrik.Nilsson@gmail.com>
List-Id: linux-pm@vger.kernel.org

After commit dfa5bb622555d9da0df21b50f46ebdeef390041b
"cpufreq: ondemand: Change the calculation of target frequency",
this return statement is no longer needed.

Reported-by: Henrik Nilsson <Karl.Henrik.Nilsson@gmail.com>
Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/cpufreq/cpufreq_ondemand.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index 32f26f6..18d4091 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -168,7 +168,6 @@ static void od_check_cpu(int cpu, unsigned int load)
 			dbs_info->rate_mult =
 				od_tuners->sampling_down_factor;
 		dbs_freq_increase(policy, policy->max);
-		return;
 	} else {
 		/* Calculate the next frequency proportional to load */
 		unsigned int freq_next;
-- 
1.8.3.1
