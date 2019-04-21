From: mohankumar718@gmail.com
Subject: [RESEND] drivers: cpufreq: use kstrtoul instead of obsolete simple_strtoul issue fixed
Date: Sun, 21 Apr 2019 18:05:56 +0300
Message-ID: <20190421150556.23341-1-mohankumar718@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, lkp@intel.com, Mohan Kumar <mohankumar718@gmail.com>
List-Id: linux-pm@vger.kernel.org

From: Mohan Kumar <mohankumar718@gmail.com>

Replace the obsolte simple_strtoul function with kstrtoul.

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/cpufreq/elanfreq.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index 03419f064752..6d861c2364e2 100644
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -184,7 +184,8 @@ static int elanfreq_cpu_init(struct cpufreq_policy *policy)
  */
 static int __init elanfreq_setup(char *str)
 {
-	max_freq = simple_strtoul(str, &str, 0);
+	unsigned long int val = 0;
+	max_freq = kstrtoul(str, 0, &val);
 	pr_warn("You're using the deprecated elanfreq command line option. Use elanfreq.max_freq instead, please!\n");
 	return 1;
 }
-- 
2.17.1
