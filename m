From: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Subject: [PATCH v2 5/5] cpufreq: arm_big_little_dt: return success if OPP list already exists
Date: Tue,  1 Oct 2013 14:33:02 +0100
Message-ID: <1380634382-15609-6-git-send-email-Sudeep.KarkadaNagesha@arm.com>
References: <1380634382-15609-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1380634382-15609-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
Sender: cpufreq-owner@vger.kernel.org
To: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org
Cc: Sudeep.KarkadaNagesha@arm.com, Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

of_init_opp_table returns -EEXIST if an OPP list is already associated
with the device, before attempting to re-initialise it. In such cases,
dt_init_opp_table must return success as OPP table is initialised.

Cc: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>
---
 drivers/cpufreq/arm_big_little_dt.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/arm_big_little_dt.c b/drivers/cpufreq/arm_big_little_dt.c
index b03d4fe..cc5d92e 100644
--- a/drivers/cpufreq/arm_big_little_dt.c
+++ b/drivers/cpufreq/arm_big_little_dt.c
@@ -56,6 +56,8 @@ static int dt_init_opp_table(struct device *cpu_dev)
 	}
 
 	ret = of_init_opp_table(cpu_dev);
+	if (ret == -EEXIST)
+		ret = 0;
 	of_node_put(np);
 
 	return ret;
-- 
1.8.1.2

