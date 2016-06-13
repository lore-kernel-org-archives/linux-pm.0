From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v2 1/1] x86/intel_idle: Add CPU model 0x4a (Atom Z34xx series)
Date: Mon, 13 Jun 2016 14:34:30 +0300
Message-ID: <1465817670-55290-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:47139 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422763AbcFMLef (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 13 Jun 2016 07:34:35 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Add CPU ID for Atom Z34xx processors. Datasheets indicate support for this,
detailed information about potential quirks or limitations are missing, though.
So we just reuse the definition for the previous ATOM series. The quite similar
values (C1 is slightly deviated) are used in the official Intel Edison BSP.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
Since v1:
- rebase on top of changes regarding to intel-family.h introduction
 drivers/idle/intel_idle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index b5dd41d..7d3a1b1 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1034,6 +1034,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	ICPU(INTEL_FAM6_SANDYBRIDGE_X,		idle_cpu_snb),
 	ICPU(INTEL_FAM6_ATOM_CEDARVIEW,		idle_cpu_atom),
 	ICPU(INTEL_FAM6_ATOM_SILVERMONT1,	idle_cpu_byt),
+	ICPU(INTEL_FAM6_ATOM_MERRIFIELD1,	idle_cpu_atom),
 	ICPU(INTEL_FAM6_ATOM_AIRMONT,		idle_cpu_cht),
 	ICPU(INTEL_FAM6_IVYBRIDGE,		idle_cpu_ivb),
 	ICPU(INTEL_FAM6_IVYBRIDGE_X,		idle_cpu_ivt),
-- 
2.8.1

