From: Piotr Luc <piotr.luc@intel.com>
Subject: [RESEND PATCH 10/11] powercap / RAPL: Add Knights Mill CPUID
Date: Thu, 13 Oct 2016 17:31:04 +0200
Message-ID: <20161013153105.2517-11-piotr.luc@intel.com>
References: <20161013153105.2517-1-piotr.luc@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161013153105.2517-1-piotr.luc@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mauro Carvalho Chehab <mchehab@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Doug Thompson <dougthompson@xmission.com>, Borislav Petkov <bp@alien8.de>, linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org, Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
List-Id: linux-pm@vger.kernel.org

Add Knights Mill (KNM) to the list of CPUIDs supported by intel_rapl

Signed-off-by: Piotr Luc <piotr.luc@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
This patch depends on [PATCH 03/11] x86/cpu/intel: Add Knights Mill 
to Intel family

 drivers/powercap/intel_rapl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/powercap/intel_rapl.c b/drivers/powercap/intel_rapl.c
index fbab29d..6a58ff7 100644
--- a/drivers/powercap/intel_rapl.c
+++ b/drivers/powercap/intel_rapl.c
@@ -1160,6 +1160,7 @@ static const struct x86_cpu_id rapl_ids[] __initconst = {
 	RAPL_CPU(INTEL_FAM6_ATOM_DENVERTON,	rapl_defaults_core),
 
 	RAPL_CPU(INTEL_FAM6_XEON_PHI_KNL,	rapl_defaults_hsw_server),
+	RAPL_CPU(INTEL_FAM6_XEON_PHI_KNM,	rapl_defaults_hsw_server),
 	{}
 };
 MODULE_DEVICE_TABLE(x86cpu, rapl_ids);
-- 
2.10.1
