From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Don't update new_policy on failures
Date: Mon,  7 Jan 2019 12:28:54 +0530
Message-ID: <af05a5d2d3ef76402f54448a66cbd20ee98bceb8.1546844324.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The local variable "new_policy" isn't getting used in the error path
since the commit f9f41e3ef99a ("cpufreq: Remove policy create/remove
notifiers"). Don't update it in error path.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 7aa3dcad2175..9a5f82ef40e8 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1305,8 +1305,6 @@ static int cpufreq_online(unsigned int cpu)
 	if (ret) {
 		pr_err("%s: Failed to initialize policy for cpu: %d (%d)\n",
 		       __func__, cpu, ret);
-		/* cpufreq_policy_free() will notify based on this */
-		new_policy = false;
 		goto out_destroy_policy;
 	}
 
-- 
2.19.1.568.g152ad8e3369a
