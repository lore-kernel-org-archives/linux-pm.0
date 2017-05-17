From: Yazen Ghannam <Yazen.Ghannam@amd.com>
Subject: [PATCH] x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on AMD systems
Date: Wed, 17 May 2017 09:20:19 -0500
Message-ID: <1495030819-4347-1-git-send-email-Yazen.Ghannam@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam01on0077.outbound.protection.outlook.com ([104.47.34.77]:36259
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751360AbdEQOVA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 17 May 2017 10:21:00 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, Yazen Ghannam <yazen.ghannam@amd.com>

From: Yazen Ghannam <yazen.ghannam@amd.com>

AMD systems support the Monitor/Mwait instructions and these can be used
for ACPI C1 in the same way as on Intel systems, with appropriate BIOS
support.

Allow ffh_cstate_init() to succeed on AMD systems and make the Cstate
description vendor-agnostic.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
 arch/x86/kernel/acpi/cstate.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 8a908ae..4c5dd5d 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -109,7 +109,7 @@ static long acpi_processor_ffh_cstate_probe_cpu(void *_cx)
 			cx->type);
 	}
 	snprintf(cx->desc,
-			ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
+			ACPI_CX_DESC_LEN, "ACPI FFH X86 MWAIT 0x%x",
 			cx->address);
 out:
 	return retval;
@@ -169,7 +169,8 @@ static int __init ffh_cstate_init(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
-	if (c->x86_vendor != X86_VENDOR_INTEL)
+	if (c->x86_vendor != X86_VENDOR_INTEL &&
+	    c->x86_vendor != X86_VENDOR_AMD)
 		return -1;
 
 	cpu_cstate_entry = alloc_percpu(struct cstate_entry);
-- 
2.7.4
