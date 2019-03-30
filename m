From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] cpufreq/intel_pstate: Do not issue the not supported message on !Intel
Date: Sat, 30 Mar 2019 11:02:25 +0100
Message-ID: <20190330100225.14744-1-bp@alien8.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: LKML <linux-kernel@vger.kernel.org>
Cc: Erwan Velu <e.velu@criteo.com>, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

Issue the CPU-not-supported message only on Intel machines as this
driver is Intel-only. Which means, the print statement can remain
KERN_INFO for ease of debugging (no need to enable it first in dynamic
debug).

While at it, correct it to say CPU "model" which is what that test does.

Fixes: 076b862c7e44 ("cpufreq: intel_pstate: Add reasons for failure and debug messages")
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Erwan Velu <e.velu@criteo.com>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/intel_pstate.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index ea62e3f02d56..19854f01e2fa 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2608,7 +2608,9 @@ static int __init intel_pstate_init(void)
 	} else {
 		id = x86_match_cpu(intel_pstate_cpu_ids);
 		if (!id) {
-			pr_info("CPU ID not supported\n");
+			if (boot_cpu_data.x86_vendor == X86_VENDOR_INTEL)
+				pr_info("CPU model not supported\n");
+
 			return -ENODEV;
 		}
 
-- 
2.21.0
