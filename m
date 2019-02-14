From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH] cpufreq: Replace double NOT (!!) with single NOT (!)
Date: Thu, 14 Feb 2019 16:16:21 +0530
Message-ID: <e0ea5fc21f9d3bd38eb4eb678d39359d66c8e79e.1550141092.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Double NOT (!!) operation is normally done to convert a non-zero value
to 1 and keep zero as is, but that isn't the requirement in this case.
All we wanted was to make sure that only one of the two routines isn't
set, i.e. either both function pointers are set or both are unset.

This can be done with a single NOT (!) operation as well.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 55e9795801a4..ad4e9991c3cc 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -2505,7 +2505,7 @@ int cpufreq_register_driver(struct cpufreq_driver *driver_data)
 		    driver_data->target) ||
 	     (driver_data->setpolicy && (driver_data->target_index ||
 		    driver_data->target)) ||
-	     (!!driver_data->get_intermediate != !!driver_data->target_intermediate) ||
+	     (!driver_data->get_intermediate != !driver_data->target_intermediate) ||
 	     (!driver_data->online != !driver_data->offline))
 		return -EINVAL;
 
-- 
2.21.0.rc0.269.g1a574e7a288b
