From: Mohan Kumar <mohankumar718@gmail.com>
Subject: [PATCH] drivers: cpufreq: use kstrtoul instead of obsolete simple_strtoul
Date: Fri, 19 Apr 2019 13:28:58 +0300
Message-ID: <1555669738-3869-1-git-send-email-mohankumar718@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Replace the obsolte simple_strtoul function with kstrtoul.

Signed-off-by: Mohan Kumar <mohankumar718@gmail.com>
---
 drivers/cpufreq/elanfreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/elanfreq.c b/drivers/cpufreq/elanfreq.c
index 03419f0..bed76da 100644
--- a/drivers/cpufreq/elanfreq.c
+++ b/drivers/cpufreq/elanfreq.c
@@ -184,7 +184,7 @@ static int elanfreq_cpu_init(struct cpufreq_policy *policy)
  */
 static int __init elanfreq_setup(char *str)
 {
-	max_freq = simple_strtoul(str, &str, 0);
+	max_freq = kstrtoul(str, 0, (unsigned long *)&val);
 	pr_warn("You're using the deprecated elanfreq command line option. Use elanfreq.max_freq instead, please!\n");
 	return 1;
 }
-- 
2.7.4
