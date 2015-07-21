From: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
Subject: [PATCH] intel_pstate: Add get_scaling cpu_defaults param to Knights Landing
Date: Tue, 21 Jul 2015 10:41:13 +0200
Message-ID: <1437468073-9668-1-git-send-email-lukasz.anaczkowski@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: kristen@linux.intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, yishimat@redhat.com, Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>, Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
List-Id: linux-pm@vger.kernel.org

Scaling for Knights Landing is same as the default scaling (100000).
When Knigts Landing support was added to the pstate driver, this
parameter was omitted resulting in a kernel panic during boot.

Reported-by: Yasuaki Ishimatsu <yishimat@redhat.com>
Signed-off-by: Dasaratharaman Chandramouli <dasaratharaman.chandramouli@intel.com>
Signed-off-by: Lukasz Anaczkowski <lukasz.anaczkowski@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 15ada47..fcb929e 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -681,6 +681,7 @@ static struct cpu_defaults knl_params = {
 		.get_max = core_get_max_pstate,
 		.get_min = core_get_min_pstate,
 		.get_turbo = knl_get_turbo_pstate,
+		.get_scaling = core_get_scaling,
 		.set = core_set_pstate,
 	},
 };
-- 
1.8.3.1
