From: Piotr Luc <piotr.luc@intel.com>
Subject: [RESEND PATCH 09/11] perf/x86/intel/uncore: Add Knights Mill CPUID
Date: Thu, 13 Oct 2016 17:31:03 +0200
Message-ID: <20161013153105.2517-10-piotr.luc@intel.com>
References: <20161013153105.2517-1-piotr.luc@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:49198 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754019AbcJMPh0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Oct 2016 11:37:26 -0400
In-Reply-To: <20161013153105.2517-1-piotr.luc@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Doug Thompson <dougthompson@xmission.com>, Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

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

 arch/x86/events/intel/uncore.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index 463dc7a..25acb30 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -1341,6 +1341,7 @@ static const struct x86_cpu_id intel_uncore_match[] __initconst = {
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_X,	  bdx_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_BROADWELL_XEON_D, bdx_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNL,	  knl_uncore_init),
+	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_XEON_PHI_KNM,	  knl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_DESKTOP,skl_uncore_init),
 	X86_UNCORE_MODEL_MATCH(INTEL_FAM6_SKYLAKE_MOBILE, skl_uncore_init),
 	{},
-- 
2.10.1

