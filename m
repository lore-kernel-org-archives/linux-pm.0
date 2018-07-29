From: oceanhe@zoho.com.cn
Subject: [PATCH] cpufreq: intel_pstate: warn if HWP Native mode and OOB mode are both set
Date: Sun, 29 Jul 2018 00:14:56 -0400
Message-ID: <1532837696-11505-1-git-send-email-oceanhe@zoho.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: srinivas.pandruvada@linux.intel.com, lenb@kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Ocean He <hehy1@lenovo.com>
List-Id: linux-pm@vger.kernel.org

From: Ocean He <hehy1@lenovo.com>

Refer to Intel HWPM Compliance Guide (Document Number: 566474): Bit[6] or
bit[8] of MSR MISC_PWR_MGMT is set only when BIOS select either HWP Native
mode or HWP OOB mode. Bit[6] and bit[8] cannot be set both at the same
time.

Add a warning message if intel_pstate detects both HWP Native mode and
HWP OOB mode are set at the same time.

Signed-off-by: Ocean He <hehy1@lenovo.com>
---
 drivers/cpufreq/intel_pstate.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 3c39712..678d3f2 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2455,8 +2455,12 @@ static bool __init intel_pstate_platform_pwr_mgmt_exists(void)
 	id = x86_match_cpu(intel_pstate_cpu_oob_ids);
 	if (id) {
 		rdmsrl(MSR_MISC_PWR_MGMT, misc_pwr);
-		if ( misc_pwr & (1 << 8))
+		if (misc_pwr & (1 << 8)) {
+			if (misc_pwr & (1 << 6))
+				pr_warn(FW_WARN
+					"HWP Native mode and OOB mode cannot be set both at the same time.\n");
 			return true;
+		}
 	}
 
 	idx = acpi_match_platform_list(plat_info);
-- 
1.8.3.1
