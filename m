From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: [PATCH 1/7] cpufreq: intel_pstate: Remove duplicate CPU ID check
Date: Tue, 10 Jun 2014 00:00:09 +0300
Message-ID: <53962059.6070306@semaphore.gr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Dirk Brandewie <dirk.j.brandewie@intel.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

We check the CPU ID during driver init. There is no need
to do it again per logical CPU initialization.

So, remove the duplicate check.

Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
---
 drivers/cpufreq/intel_pstate.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index aebd457..4e7f492 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -691,14 +691,8 @@ MODULE_DEVICE_TABLE(x86cpu, intel_pstate_cpu_ids);
 
 static int intel_pstate_init_cpu(unsigned int cpunum)
 {
-
-	const struct x86_cpu_id *id;
 	struct cpudata *cpu;
 
-	id = x86_match_cpu(intel_pstate_cpu_ids);
-	if (!id)
-		return -ENODEV;
-
 	all_cpu_data[cpunum] = kzalloc(sizeof(struct cpudata), GFP_KERNEL);
 	if (!all_cpu_data[cpunum])
 		return -ENOMEM;
-- 
1.9.3
