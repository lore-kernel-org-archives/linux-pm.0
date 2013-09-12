From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 2/5] cpufreq: don't break string in print statements
Date: Thu, 12 Sep 2013 10:55:45 +0530
Message-ID: <e086b55f2ec5c7a67fa28a21f23c088b67e5191e.1378963070.git.viresh.kumar@linaro.org>
References: <cover.1378963070.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <cover.1378963070.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1378963070.git.viresh.kumar@linaro.org>
References: <cover.1378963070.git.viresh.kumar@linaro.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl, swarren@wwwdotorg.org, srivatsa.bhat@linux.vnet.ibm.com
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

As a rule its better not to break string (quoted inside "") in a print statement
even if it crosses 80 column boundary as that may introduce unwanted bugs and so
this patch rewrites one of the print statements..

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 28477eb..31f7845 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1192,8 +1192,8 @@ static int __cpufreq_remove_dev_prepare(struct device *dev,
 			unlock_policy_rwsem_write(cpu);
 
 			if (!frozen) {
-				pr_debug("%s: policy Kobject moved to cpu: %d "
-					 "from: %d\n",__func__, new_cpu, cpu);
+				pr_debug("%s: policy Kobject moved to cpu: %d from: %d\n",
+						__func__, new_cpu, cpu);
 			}
 		}
 	}
-- 
1.7.12.rc2.18.g61b472e

