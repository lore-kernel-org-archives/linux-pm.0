From: Piotr Luc <piotr.luc@intel.com>
Subject: [PATCH] x86/intel_idle: Add Knights Mill CPUID
Date: Wed, 12 Oct 2016 20:25:06 +0200
Message-ID: <20161012182506.1679-1-piotr.luc@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:21516 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933923AbcJLSh1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 12 Oct 2016 14:37:27 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <lenb@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

Add Knights Mill (KNM) to the list of CPUIDs supported by intel_idle.

Signed-off-by: Piotr Luc <piotr.luc@intel.com>
Reviewed-by: Dave Hansen <dave.hansen@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org
---
Depends-on: x86/cpu/intel: Add Knights Mill to Intel family
https://lkml.kernel.org/r/20161012180520.30976-1-piotr.luc () intel ! com

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

