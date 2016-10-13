From: Piotr Luc <piotr.luc@intel.com>
Subject: [RESEND PATCH 07/11] perf/x86/intel: Add Knights Mill CPUID
Date: Thu, 13 Oct 2016 17:31:01 +0200
Message-ID: <20161013153105.2517-8-piotr.luc@intel.com>
References: <20161013153105.2517-1-piotr.luc@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161013153105.2517-1-piotr.luc@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Doug Thompson <dougthompson@xmission.com>, Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Add Knights Mill (KNM) to the list of CPUIDs supported by PMU.

Signed-off-by: Piotr Luc <piotr.luc@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-kernel@vger.kernel.org
---
This patch depends on [PATCH 03/11] x86/cpu/intel: Add Knights Mill 
to Intel family

 arch/x86/events/intel/core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 4c9a79b..327dc2d 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3893,6 +3893,7 @@ __init int intel_pmu_init(void)
 		break;
 
 	case INTEL_FAM6_XEON_PHI_KNL:
+	case INTEL_FAM6_XEON_PHI_KNM:
 		memcpy(hw_cache_event_ids,
 		       slm_hw_cache_event_ids, sizeof(hw_cache_event_ids));
 		memcpy(hw_cache_extra_regs,
@@ -3907,7 +3908,7 @@ __init int intel_pmu_init(void)
 		x86_pmu.flags |= PMU_FL_HAS_RSP_1;
 		x86_pmu.flags |= PMU_FL_NO_HT_SHARING;
 
-		pr_cont("Knights Landing events, ");
+		pr_cont("Knights Landing/Mill events, ");
 		break;
 
 	case INTEL_FAM6_SKYLAKE_MOBILE:
-- 
2.10.1
