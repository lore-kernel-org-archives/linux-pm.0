From: Len Brown <lenb@kernel.org>
Subject: [PATCH 3/4] x86 smpboot: remove SIPI delays from cpu_up()
Date: Sun, 16 Aug 2015 11:45:47 -0400
Message-ID: <a5dfdbc8fbfdd813784da204aad5677fe459ac37.1439739165.git.len.brown@intel.com>
References: <1439739948-21028-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:33527 "EHLO
	mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753135AbbHPPqf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 16 Aug 2015 11:46:35 -0400
In-Reply-To: <1439739948-21028-1-git-send-email-lenb@kernel.org>
In-Reply-To: <33ef746c67d2489cad0a9b1958cf71167232ff2b.1439739165.git.len.brown@intel.com>
References: <33ef746c67d2489cad0a9b1958cf71167232ff2b.1439739165.git.len.brown@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: x86@kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Len Brown <len.brown@intel.com>

From: Len Brown <len.brown@intel.com>

MPS 1.4 example code shows the following delays during processor
on-line:

INIT
 udelay(10,000)
SIPI
 udelay(200)
SIPI
 udelay(200) /* Linux actually implements this as udelay(300) */

Linux skips the udelay(10,000) on modern processors.
This patch removes the udelay(200) after each SIPI
on those same processors.

All three legacy delays can be restored by the cmdline
"cpu_init_udelay=10000".

As measured by analyze_suspend.py, this patch speeds
processor resume time on my desktop from 2.4ms to 1.8ms, per AP.

Signed-off-by: Len Brown <len.brown@intel.com>
---
 arch/x86/kernel/smpboot.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 310b6f0..3d992b6 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -665,7 +665,8 @@ wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
 		/*
 		 * Give the other CPU some time to accept the IPI.
 		 */
-		udelay(300);
+		if (init_udelay != 0)
+			udelay(300);
 
 		pr_debug("Startup point 1\n");
 
@@ -675,7 +676,8 @@ wakeup_secondary_cpu_via_init(int phys_apicid, unsigned long start_eip)
 		/*
 		 * Give the other CPU some time to accept the IPI.
 		 */
-		udelay(200);
+		if (init_udelay != 0)
+			udelay(200);
 
 		if (maxlvt > 3)		/* Due to the Pentium erratum 3AP.  */
 			apic_write(APIC_ESR, 0);
-- 
2.5.0.330.g130be8e

