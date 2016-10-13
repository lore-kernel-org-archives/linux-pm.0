From: Piotr Luc <piotr.luc@intel.com>
Subject: [RESEND PATCH 08/11] perf/x86/intel/rapl: Add Knights Mill CPUID
Date: Thu, 13 Oct 2016 17:31:02 +0200
Message-ID: <20161013153105.2517-9-piotr.luc@intel.com>
References: <20161013153105.2517-1-piotr.luc@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161013153105.2517-1-piotr.luc@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Doug Thompson <dougthompson@xmission.com>, Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Add Knights Mill (KNM) to the list of CPUIDs supported by rapl.

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

 arch/x86/events/intel/rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/rapl.c b/arch/x86/events/intel/rapl.c
index 2886593..779e7c8 100644
--- a/arch/x86/events/intel/rapl.c
+++ b/arch/x86/events/intel/rapl.c
@@ -761,6 +761,7 @@ static const struct x86_cpu_id rapl_cpu_match[] __initconst = {
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_BROADWELL_XEON_D, hsw_rapl_init),
 
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL, knl_rapl_init),
+	X86_RAPL_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNM, knl_rapl_init),
 
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_MOBILE,  skl_rapl_init),
 	X86_RAPL_MODEL_MATCH(INTEL_FAM6_SKYLAKE_DESKTOP, skl_rapl_init),
-- 
2.10.1
