From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.0 25/67] thermal/intel_powerclamp: fix truncated kthread name
Date: Fri, 29 Mar 2019 20:50:05 -0400
Message-ID: <20190330005047.25998-25-sashal@kernel.org>
References: <20190330005047.25998-1-sashal@kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190330005047.25998-1-sashal@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Zhang Rui <rui.zhang@intel.com>, Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

From: Zhang Rui <rui.zhang@intel.com>

[ Upstream commit e925b5be5751f6a7286bbd9a4cbbc4ac90cc5fa6 ]

kthread name only allows 15 characters (TASK_COMMON_LEN is 16).
Thus rename the kthreads created by intel_powerclamp driver from
"kidle_inject/ + decimal cpuid" to "kidle_inj/ + decimal cpuid"
to avoid truncated kthead name for cpu 100 and later.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/intel/intel_powerclamp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/intel/intel_powerclamp.c b/drivers/thermal/intel/intel_powerclamp.c
index b12ecd436e23..ac7256b5f020 100644
--- a/drivers/thermal/intel/intel_powerclamp.c
+++ b/drivers/thermal/intel/intel_powerclamp.c
@@ -494,7 +494,7 @@ static void start_power_clamp_worker(unsigned long cpu)
 	struct powerclamp_worker_data *w_data = per_cpu_ptr(worker_data, cpu);
 	struct kthread_worker *worker;
 
-	worker = kthread_create_worker_on_cpu(cpu, 0, "kidle_inject/%ld", cpu);
+	worker = kthread_create_worker_on_cpu(cpu, 0, "kidle_inj/%ld", cpu);
 	if (IS_ERR(worker))
 		return;
 
-- 
2.19.1
