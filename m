From: Piotr Luc <piotr.luc@intel.com>
Subject: [RESEND PATCH 05/11] EDAC, sb_edac: Add Knights Mill CPUID
Date: Thu, 13 Oct 2016 17:30:59 +0200
Message-ID: <20161013153105.2517-6-piotr.luc@intel.com>
References: <20161013153105.2517-1-piotr.luc@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga06.intel.com ([134.134.136.31]:56703 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1756176AbcJMPei (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 13 Oct 2016 11:34:38 -0400
In-Reply-To: <20161013153105.2517-1-piotr.luc@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Doug Thompson <dougthompson@xmission.com>, Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, "Luck, Tony" <tony.luck@intel.com>, "Shevchenko, Andriy" <andriy.shevchenko@intel.com>

Add Knights Mill (KNM) to the list of CPUIDs supported by sb_edac.

Signed-off-by: Piotr Luc <piotr.luc@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>
Cc: Doug Thompson <dougthompson@xmission.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: linux-edac@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: "Luck, Tony" <tony.luck@intel.com>
Cc: "Shevchenko, Andriy" <andriy.shevchenko@intel.com>
---
This patch depends on [PATCH 03/11] x86/cpu/intel: Add Knights Mill 
to Intel family

 drivers/edac/sb_edac.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/edac/sb_edac.c b/drivers/edac/sb_edac.c
index 90564bc..3ffc737 100644
--- a/drivers/edac/sb_edac.c
+++ b/drivers/edac/sb_edac.c
@@ -3373,6 +3373,7 @@ static const struct x86_cpu_id sbridge_cpuids[] = {
 	ICPU(INTEL_FAM6_BROADWELL_X, pci_dev_descr_broadwell_table),
 	ICPU(INTEL_FAM6_BROADWELL_XEON_D, pci_dev_descr_broadwell_table),
 	ICPU(INTEL_FAM6_XEON_PHI_KNL, pci_dev_descr_knl_table),
+	ICPU(INTEL_FAM6_XEON_PHI_KNM, pci_dev_descr_knl_table),
 	{ }
 };
 MODULE_DEVICE_TABLE(x86cpu, sbridge_cpuids);
-- 
2.10.1

