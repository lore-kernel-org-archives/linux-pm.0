From: Javi Merino <javi.merino@arm.com>
Subject: [PATCH v3 5/5] thermal: cpu_cooling: update the cpu device when cpufreq updates the policy cpu
Date: Mon,  2 Mar 2015 17:17:23 +0000
Message-ID: <1425316643-31991-6-git-send-email-javi.merino@arm.com>
References: <1425316643-31991-1-git-send-email-javi.merino@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1425316643-31991-1-git-send-email-javi.merino@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, punit.agrawal@arm.com, lina.iyer@linaro.org, broonie@kernel.org, tixy@linaro.org, Kapileshwar Singh <kapileshwar.singh@arm.com>
List-Id: linux-pm@vger.kernel.org

From: Kapileshwar Singh <kapileshwar.singh@arm.com>

When cpufreq changes the policy cpu, we need to update our cached cpu
device accordingly.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Kapileshwar Singh <kapileshwar.singh@arm.com>
---
 drivers/thermal/cpu_cooling.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index c4974144c787..e306d6bc3cf1 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -269,6 +269,9 @@ static int cpufreq_thermal_notifier(struct notifier_block *nb,
 		mutex_unlock(&cooling_cpufreq_lock);
 		break;
 
+	case CPUFREQ_UPDATE_POLICY_CPU:
+		update_cpu_device(policy->cpu);
+		break;
 	case CPUFREQ_CREATE_POLICY:
 		update_cpu_device(policy->cpu);
 		break;
-- 
1.9.1
