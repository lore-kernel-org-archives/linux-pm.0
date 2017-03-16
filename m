From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 02/17] thermal: cpu_cooling: rearrange globals
Date: Thu, 16 Mar 2017 10:59:37 +0530
Message-ID: <2ec1e1f373acb4471db3b15d14207c31b73c372f.1489640000.git.viresh.kumar@linaro.org>
References: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <be952dc502195304ddecfe4eefa7043eb71d0c6b.1489639999.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1489639999.git.viresh.kumar@linaro.org>
References: <cover.1489639999.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

Just to make it look better.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 6fd258d62e47..7ce73eee866f 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -105,10 +105,9 @@ struct cpufreq_cooling_device {
 	struct device *cpu_dev;
 	get_static_t plat_get_static_power;
 };
-static DEFINE_IDA(cpufreq_ida);
 
 static unsigned int cpufreq_dev_count;
-
+static DEFINE_IDA(cpufreq_ida);
 static DEFINE_MUTEX(cooling_list_lock);
 static LIST_HEAD(cpufreq_dev_list);
 
-- 
2.7.1.410.g6faf27b
