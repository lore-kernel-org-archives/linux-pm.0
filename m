From: Paul Bolle <pebolle@tiscali.nl>
Subject: [PATCH] cpufreq: s5pv210: remove unused call of pr_err()
Date: Wed, 21 May 2014 21:53:56 +0200
Message-ID: <1400702036.30334.6.camel@x220>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

A call of pr_err() was added in v3.1. It was guarded by a check for
CONFIG_PM_VERBOSE. The Kconfig symbol PM_VERBOSE was removed in v3.0. So
this call of pr_err() has never been used. Remove it.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 drivers/cpufreq/s5pv210-cpufreq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
index ab2c1a40d437..0873729135df 100644
--- a/drivers/cpufreq/s5pv210-cpufreq.c
+++ b/drivers/cpufreq/s5pv210-cpufreq.c
@@ -175,10 +175,6 @@ static int s5pv210_target(struct cpufreq_policy *policy, unsigned int index)
 	mutex_lock(&set_freq_lock);
 
 	if (no_cpufreq_access) {
-#ifdef CONFIG_PM_VERBOSE
-		pr_err("%s:%d denied access to %s as it is disabled"
-				"temporarily\n", __FILE__, __LINE__, __func__);
-#endif
 		ret = -EINVAL;
 		goto exit;
 	}
-- 
1.9.0
