From: Piotr Luc <piotr.luc@intel.com>
Subject: [RESEND PATCH 04/11] x86/intel_idle: Add Knights Mill CPUID
Date: Thu, 13 Oct 2016 17:30:58 +0200
Message-ID: <20161013153105.2517-5-piotr.luc@intel.com>
References: <20161013153105.2517-1-piotr.luc@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:56703 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753714AbcJMPef (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Oct 2016 11:34:35 -0400
In-Reply-To: <20161013153105.2517-1-piotr.luc@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Doug Thompson <dougthompson@xmission.com>, Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

Add Knights Mill (KNM) to the list of CPUIDs supported by intel_idle.

Signed-off-by: Piotr Luc <piotr.luc@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
This patch depends on [PATCH 03/11] x86/cpu/intel: Add Knights Mill 
to Intel family

 drivers/idle/intel_idle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 67ec58f..69047a0 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1084,6 +1084,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	ICPU(INTEL_FAM6_KABYLAKE_DESKTOP,	idle_cpu_skl),
 	ICPU(INTEL_FAM6_SKYLAKE_X,		idle_cpu_skx),
 	ICPU(INTEL_FAM6_XEON_PHI_KNL,		idle_cpu_knl),
+	ICPU(INTEL_FAM6_XEON_PHI_KNM,		idle_cpu_knl),
 	ICPU(INTEL_FAM6_ATOM_GOLDMONT,		idle_cpu_bxt),
 	ICPU(INTEL_FAM6_ATOM_DENVERTON,		idle_cpu_dnv),
 	{}
-- 
2.10.1

