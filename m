From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/6] cpufreq: governor: Remove unnecessary bits from print message
Date: Wed, 18 May 2016 17:55:27 +0530
Message-ID: <a676e03e63c25c0fed482706d98317b66a277252.1463574213.git.viresh.kumar@linaro.org>
References: <cover.1463574213.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1463574213.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1463574213.git.viresh.kumar@linaro.org>
References: <cover.1463574213.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

pr_*() helpers already prefix the print messages with
"cpufreq_governor:" and similar details aren't required in the actual
message.

For example, the print message getting fixed looks like this before this
patch:

cpufreq_governor: cpufreq: Governor initialization failed (dbs_data kobject init error 0)

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq_governor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq_governor.c b/drivers/cpufreq/cpufreq_governor.c
index be498d56dd69..45ca5aff88b2 100644
--- a/drivers/cpufreq/cpufreq_governor.c
+++ b/drivers/cpufreq/cpufreq_governor.c
@@ -458,7 +458,7 @@ static int cpufreq_governor_init(struct cpufreq_policy *policy)
 		goto out;
 
 	/* Failure, so roll back. */
-	pr_err("cpufreq: Governor initialization failed (dbs_data kobject init error %d)\n", ret);
+	pr_err("initialization failed (dbs_data kobject init error %d)\n", ret);
 
 	policy->governor_data = NULL;
 
-- 
2.7.1.410.g6faf27b
