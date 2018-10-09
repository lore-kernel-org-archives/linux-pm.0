From: Thara Gopinath <thara.gopinath@linaro.org>
Subject: [RFC PATCH 4/7] sched: Initialize per cpu thermal pressure structure
Date: Tue,  9 Oct 2018 12:24:59 -0400
Message-ID: <1539102302-9057-5-git-send-email-thara.gopinath@linaro.org>
References: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1539102302-9057-1-git-send-email-thara.gopinath@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, mingo@redhat.com, peterz@infradead.org, rui.zhang@intel.com
Cc: gregkh@linuxfoundation.org, rafael@kernel.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, javi.merino@kernel.org, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, quentin.perret@arm.com, ionela.voinescu@arm.com, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

Initialize per cpu max_capacity_info during scheduler init.

Signed-off-by: Thara Gopinath <thara.gopinath@linaro.org>
---
 drivers/base/arch_topology.c | 1 +
 kernel/sched/core.c          | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index e7cb0c6..542745f 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -126,6 +126,7 @@ void topology_normalize_cpu_scale(void)
 		pr_debug("cpu_capacity: CPU%d cpu_capacity=%lu\n",
 			cpu, topology_get_cpu_scale(NULL, cpu));
 	}
+	populate_max_capacity_info();
 	mutex_unlock(&cpu_scale_mutex);
 }
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 625bc98..f0eed1a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5868,6 +5868,8 @@ void __init sched_init_smp(void)
 	init_sched_rt_class();
 	init_sched_dl_class();
 
+	populate_max_capacity_info();
+
 	sched_smp_initialized = true;
 }
 
-- 
2.1.4
