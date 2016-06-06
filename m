From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 1/1] intel_idle: Add CPU model 74 (Atom Z34xx series)
Date: Mon,  6 Jun 2016 20:06:46 +0300
Message-ID: <1465232806-138619-1-git-send-email-andriy.shevchenko@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:60505 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751699AbcFFRHg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 6 Jun 2016 13:07:36 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Len Brown <lenb@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Add CPU ID for Atom Z34xx processors. Datasheets indicate support for this,
detailed information about potential quirks or limitations are missing, though.
So we just reuse the definition for the previous ATOM series. The quite similar
values (C1 is slightly deviated) are used in the official Intel Edison BSP.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/idle/intel_idle.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index c966492..bb52275 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -1033,6 +1033,7 @@ static const struct x86_cpu_id intel_idle_ids[] __initconst = {
 	ICPU(0x2d, idle_cpu_snb),
 	ICPU(0x36, idle_cpu_atom),
 	ICPU(0x37, idle_cpu_byt),
+	ICPU(0x4a, idle_cpu_atom),
 	ICPU(0x4c, idle_cpu_cht),
 	ICPU(0x3a, idle_cpu_ivb),
 	ICPU(0x3e, idle_cpu_ivt),
-- 
2.8.1

