From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 03/14] cpufreq: Add support for per-policy driver data
Date: Tue,  1 Jul 2014 22:02:32 +0530
Message-ID: <0614df495e361dd23ebe2d4e4ee3d40cb23948da.1404231535.git.viresh.kumar@linaro.org>
References: <cover.1404231535.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1404231535.git.viresh.kumar@linaro.org>
In-Reply-To: <cover.1404231535.git.viresh.kumar@linaro.org>
References: <cover.1404231535.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, shawn.guo@linaro.org
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, arvind.chauhan@arm.com, sboyd@codeaurora.org, linux-arm-msm@vger.kernel.org, spk.linux@gmail.com, thomas.ab@samsung.com, nm@ti.com, t.figa@samsung.com, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Drivers supporting multiple clusters or multiple 'struct cpufreq_policy'
instances may need to keep per-policy data. If the core doesn't support them,
they might do it in the most unoptimized way: 'per-cpu' data.

This patch adds another field in 'struct cpufreq_policy': 'driver_data'. It
isn't accessed by core and is for driver's internal use.

Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 include/linux/cpufreq.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index ec4112d..d4b1108 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -112,6 +112,9 @@ struct cpufreq_policy {
 	spinlock_t		transition_lock;
 	wait_queue_head_t	transition_wait;
 	struct task_struct	*transition_task; /* Task which is doing the transition */
+
+	/* For cpufreq driver's internal use */
+	void			*driver_data;
 };
 
 /* Only for ACPI */
-- 
2.0.0.rc2
