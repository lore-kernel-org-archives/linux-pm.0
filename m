From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] cpufreq/intel_pstate: Load only on Intel hardware
Date: Mon, 1 Apr 2019 17:03:45 +0200
Message-ID: <20190401150345.GJ28264@zn.tnic>
References: <20190330100225.14744-1-bp@alien8.de>
 <fa14666a-269c-249a-f603-b00f6301c1a6@criteo.com>
 <20190401083902.GC28264@zn.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190401083902.GC28264@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
To: Erwan Velu <e.velu@criteo.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Len Brown <lenb@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

This driver is Intel-only so loading on anything which is not Intel is
pointless. Prevent it from doing so.

While at it, correct the "not supported" print statement to say CPU
"model" which is what that test does.

Suggested-by: Erwan Velu <e.velu@criteo.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: Len Brown <lenb@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
CC: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/intel_pstate.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index b599c7318aab..2986119dd31f 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -2596,6 +2596,9 @@ static int __init intel_pstate_init(void)
 	const struct x86_cpu_id *id;
 	int rc;
 
+	if (boot_cpu_data.x86_vendor != X86_VENDOR_INTEL)
+		return -ENODEV;
+
 	if (no_load)
 		return -ENODEV;
 
@@ -2611,7 +2614,7 @@ static int __init intel_pstate_init(void)
 	} else {
 		id = x86_match_cpu(intel_pstate_cpu_ids);
 		if (!id) {
-			pr_info("CPU ID not supported\n");
+			pr_info("CPU model not supported\n");
 			return -ENODEV;
 		}
 
-- 
2.21.0


-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
