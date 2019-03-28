From: Quentin Perret <quentin.perret@arm.com>
Subject: [PATCH 2/3] PM / EM: Expose perf domain struct
Date: Thu, 28 Mar 2019 10:13:51 +0000
Message-ID: <20190328101352.25657-3-quentin.perret@arm.com>
References: <20190328101352.25657-1-quentin.perret@arm.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190328101352.25657-1-quentin.perret@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com, javi.merino@kernel.org, viresh.kumar@linaro.org, amit.kachhap@gmail.com, rjw@rjwysocki.net, will.deacon@arm.com, catalin.marinas@arm.com
Cc: daniel.lezcano@linaro.org, dietmar.eggemann@arm.com, ionela.voinescu@arm.com, quentin.perret@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

In the current state, the perf_domain struct is fully defined only when
CONFIG_ENERGY_MODEL=y. Since we need to write code that compiles both
with or without that option in the thermal framework, make sure to
actually define the struct regardless of the config option. That allows
to avoid using stubbed accessor functions all the time in code paths
that use the EM.

Signed-off-by: Quentin Perret <quentin.perret@arm.com>
---
 include/linux/energy_model.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/energy_model.h b/include/linux/energy_model.h
index aa027f7bcb3e..fb32b86a467d 100644
--- a/include/linux/energy_model.h
+++ b/include/linux/energy_model.h
@@ -9,7 +9,6 @@
 #include <linux/sched/topology.h>
 #include <linux/types.h>
 
-#ifdef CONFIG_ENERGY_MODEL
 /**
  * em_cap_state - Capacity state of a performance domain
  * @frequency:	The CPU frequency in KHz, for consistency with CPUFreq
@@ -40,6 +39,7 @@ struct em_perf_domain {
 	unsigned long cpus[0];
 };
 
+#ifdef CONFIG_ENERGY_MODEL
 #define EM_CPU_MAX_POWER 0xFFFF
 
 struct em_data_callback {
@@ -160,7 +160,6 @@ static inline int em_pd_nr_cap_states(struct em_perf_domain *pd)
 }
 
 #else
-struct em_perf_domain {};
 struct em_data_callback {};
 #define EM_DATA_CB(_active_power_cb) { }
 
-- 
2.21.0
