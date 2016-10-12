From: Piotr Luc <piotr.luc@intel.com>
Subject: [PATCH] powercap / RAPL: Add Knights Mill CPUID
Date: Wed, 12 Oct 2016 20:28:34 +0200
Message-ID: <20161012182834.3701-1-piotr.luc@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:16360 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933921AbcJLSaq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Oct 2016 14:30:46 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Add Knights Mill (KNM) to the list of CPUIDs supported by intel_rapl

Signed-off-by: Piotr Luc <piotr.luc@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
Depends-on: x86/cpu/intel: Add Knights Mill to Intel family
https://lkml.kernel.org/r/20161012180520.30976-1-piotr.luc () intel ! com

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

