From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 02/17] thermal: cpu_cooling: rearrange globals
Date: Mon, 17 Apr 2017 11:31:47 +0530
Message-ID: <82d7a271bde0f9e4d5debd10a42ffb67b31aedad.1492408342.git.viresh.kumar@linaro.org>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1492408342.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1492408342.git.viresh.kumar@linaro.org>
References: <cover.1492408342.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, Rafael Wysocki <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
List-Id: linux-pm@vger.kernel.org

Just to make it look better.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index be29489dd247..ce94aafed25d 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -105,8 +105,8 @@ struct cpufreq_cooling_device {
 	struct device *cpu_dev;
 	get_static_t plat_get_static_power;
 };
-static DEFINE_IDA(cpufreq_ida);
 
+static DEFINE_IDA(cpufreq_ida);
 static DEFINE_MUTEX(cooling_list_lock);
 static LIST_HEAD(cpufreq_dev_list);
 
-- 
2.12.0.432.g71c3a4f4ba37
