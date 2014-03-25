From: Vinson Lee <vlee@twopensource.com>
Subject: [PATCH] acpi-cpufreq: set current frequency based on target P-State
Date: Tue, 25 Mar 2014 15:04:17 -0700
Message-ID: <1395785057-28903-2-git-send-email-vlee@twopensource.com>
References: <20131220081912.GA13684@hobo.Home>
 <1395785057-28903-1-git-send-email-vlee@twopensource.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1395785057-28903-1-git-send-email-vlee@twopensource.com>
Sender: stable-owner@vger.kernel.org
To: stable@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Len Brown <len.brown@intel.com>, Ross Lagerwall <rosslagerwall@gmail.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Shatil Rafiullah <srafiullah@twopensource.com>, Vinson Lee <vlee@twitter.com>
List-Id: linux-pm@vger.kernel.org

From: Ross Lagerwall <rosslagerwall@gmail.com>

commit 8673b83bf2f013379453b4779047bf3c6ae387e4 upstream.

Commit 4b31e774 (Always set P-state on initialization) fixed bug
#4634 and caused the driver to always set the target P-State at
least once since the initial P-State may not be the desired one.
Commit 5a1c0228 (cpufreq: Avoid calling cpufreq driver's target()
routine if target_freq == policy->cur) caused a regression in
this behavior.

This fixes the regression by setting policy->cur based on the CPU's
target frequency rather than the CPU's current reported frequency
(which may be different).  This means that the P-State will be set
initially if the CPU's target frequency is different from the
governor's target frequency.

This fixes an issue where setting the default governor to
performance wouldn't correctly enable turbo mode on all cores.

Signed-off-by: Ross Lagerwall <rosslagerwall@gmail.com>
Reviewed-by: Len Brown <len.brown@intel.com>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Cc: 3.8+ <stable@vger.kernel.org>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
[ srafiullah: Backported to <= 3.6:
  - SYSTEM_AMD_MSR_CAPABLE does not exist. ]
Tested-by: Shatil Rafiullah <srafiullah@twopensource.com>
Signed-off-by: Shatil Rafiullah <srafiullah@twopensource.com>
Signed-off-by: Vinson Lee <vlee@twitter.com>
---
 drivers/cpufreq/acpi-cpufreq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
index 56c6c6b..227a316 100644
--- a/drivers/cpufreq/acpi-cpufreq.c
+++ b/drivers/cpufreq/acpi-cpufreq.c
@@ -215,7 +215,7 @@ static u32 get_cur_val(const struct cpumask *mask)
 	switch (per_cpu(acfreq_data, cpumask_first(mask))->cpu_feature) {
 	case SYSTEM_INTEL_MSR_CAPABLE:
 		cmd.type = SYSTEM_INTEL_MSR_CAPABLE;
-		cmd.addr.msr.reg = MSR_IA32_PERF_STATUS;
+		cmd.addr.msr.reg = MSR_IA32_PERF_CTL;
 		break;
 	case SYSTEM_IO_CAPABLE:
 		cmd.type = SYSTEM_IO_CAPABLE;
-- 
1.8.3.2
