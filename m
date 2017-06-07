From: Yazen Ghannam <Yazen.Ghannam@amd.com>
Subject: [PATCH v2] x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on AMD systems
Date: Wed,  7 Jun 2017 10:19:46 -0500
Message-ID: <1496848786-105710-1-git-send-email-Yazen.Ghannam@amd.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam01on0053.outbound.protection.outlook.com ([104.47.34.53]:29049
        "EHLO NAM01-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750940AbdFGPUA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 7 Jun 2017 11:20:00 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, bp@suse.de, Yazen Ghannam <yazen.ghannam@amd.com>

From: Yazen Ghannam <yazen.ghannam@amd.com>

AMD systems support the Monitor/Mwait instructions and these can be used
for ACPI C1 in the same way as on Intel systems.

Three things are needed:
1) This patch.
2) BIOS that declares a C1 state in _CST to use FFH, with correct values.
3) CPUID_Fn00000005_EDX is non-zero on the system.

The BIOS on AMD systems have historically not defined a C1 state in _CST,
so the acpi_idle driver uses HALT for ACPI C1.

Currently released systems have CPUID_Fn00000005_EDX as reserved/RAZ. If a
BIOS is released for these systems that requests a C1 state with FFH, the
FFH implementation in Linux will fail since CPUID_Fn00000005_EDX is 0. The
acpi_idle driver will then fallback to using HALT for ACPI C1.

Future systems are expected to have non-zero CPUID_Fn00000005_EDX and BIOS
support for using FFH for ACPI C1.

Allow ffh_cstate_init() to succeed on AMD systems.

Tested on Fam15h and Fam17h systems.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
---
Link:
https://lkml.kernel.org/r/1495030819-4347-1-git-send-email-Yazen.Ghannam@amd.com

v1->v2:
* Expand commit message.
* Drop change to description string.

 arch/x86/kernel/acpi/cstate.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index 8233a63..dde437f 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -167,7 +167,8 @@ static int __init ffh_cstate_init(void)
 {
 	struct cpuinfo_x86 *c = &boot_cpu_data;
 
-	if (c->x86_vendor != X86_VENDOR_INTEL)
+	if (c->x86_vendor != X86_VENDOR_INTEL &&
+	    c->x86_vendor != X86_VENDOR_AMD)
 		return -1;
 
 	cpu_cstate_entry = alloc_percpu(struct cstate_entry);
-- 
2.7.4
