From: Jisheng Zhang <jszhang@marvell.com>
Subject: [PATCH v2 3/3] intel_pstate: Declare pid_params/pstate_funcs/hwp_active __read_mostly
Date: Mon, 27 Jun 2016 18:07:18 +0800
Message-ID: <1467022038-924-4-git-send-email-jszhang@marvell.com>
References: <1467022038-924-1-git-send-email-jszhang@marvell.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-0016f401.pphosted.com ([67.231.148.174]:46019 "EHLO
	mx0a-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751748AbcF0KLf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jun 2016 06:11:35 -0400
In-Reply-To: <1467022038-924-1-git-send-email-jszhang@marvell.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com, lenb@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Jisheng Zhang <jszhang@marvell.com>

pid_params is written once by copy_pid_params() during initialization,
and thereafter is mostly read by hot path intel_pstate_update_util().
The read of pid_params gets more after commit a4675fbc4a7a ("cpufreq:
intel_pstate: Replace timers with utilization update callbacks")

pstate_funcs is written once by copy_cpu_funcs() during initialization,
and thereafter is mostly read by hot path intel_pstate_update_util()

hwp_active is written to once during initialization and thereafter is
mostly read by hot path intel_pstate_update_util().

The fact that they are mostly read and not written to makes them
candidates for __read_mostly declarations.

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/cpufreq/intel_pstate.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 861bcba..2eda50d 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -281,9 +281,9 @@ struct cpu_defaults {
 static inline int32_t get_target_pstate_use_performance(struct cpudata *cpu);
 static inline int32_t get_target_pstate_use_cpu_load(struct cpudata *cpu);
 
-static struct pstate_adjust_policy pid_params;
-static struct pstate_funcs pstate_funcs;
-static int hwp_active;
+static struct pstate_adjust_policy pid_params __read_mostly;
+static struct pstate_funcs pstate_funcs __read_mostly;
+static int hwp_active __read_mostly;
 
 #ifdef CONFIG_ACPI
 static bool acpi_ppc;
-- 
2.8.1

