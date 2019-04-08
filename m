From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: maple: Remove redundant code from maple_cpufreq_init()
Date: Mon,  8 Apr 2019 15:47:06 +0530
Message-ID: <dfb046a881d254f5133e6a1f86a04f49e73c56f9.1554718622.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The success path and error path both look the same, don't duplicate the
code.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/maple-cpufreq.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/cpufreq/maple-cpufreq.c b/drivers/cpufreq/maple-cpufreq.c
index a05f1342ec02..a94355723ef8 100644
--- a/drivers/cpufreq/maple-cpufreq.c
+++ b/drivers/cpufreq/maple-cpufreq.c
@@ -231,10 +231,6 @@ static int __init maple_cpufreq_init(void)
 
 	rc = cpufreq_register_driver(&maple_cpufreq_driver);
 
-	of_node_put(cpunode);
-
-	return rc;
-
 bail_noprops:
 	of_node_put(cpunode);
 
-- 
2.21.0.rc0.269.g1a574e7a288b
