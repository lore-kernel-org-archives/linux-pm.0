From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH] x86/ACPI/cstate: Output AMD on APCI C1 FFH MWAIT AMD systems
Date: Wed,  8 Aug 2018 13:47:35 -0400
Message-ID: <20180808174735.3114-1-prarit@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

commit 5209654a46ee ("x86/ACPI/cstate: Allow ACPI C1 FFH MWAIT use on AMD
systems") allows use of FFH for ACPI C1 but tools like cpupower and turbostat
display INTEL for the cstate description.

Output "AMD" for AMD systems with FFH for ACPI C1.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: x86@kernel.org
Cc: linux-pm@vger.kernel.org
---
 arch/x86/kernel/acpi/cstate.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/acpi/cstate.c b/arch/x86/kernel/acpi/cstate.c
index dde437f5d14f..f10d3c673519 100644
--- a/arch/x86/kernel/acpi/cstate.c
+++ b/arch/x86/kernel/acpi/cstate.c
@@ -76,6 +76,7 @@ static long acpi_processor_ffh_cstate_probe_cpu(void *_cx)
 	unsigned int edx_part;
 	unsigned int cstate_type; /* C-state type and not ACPI C-state type */
 	unsigned int num_cstate_subtype;
+	struct cpuinfo_x86 *c = &boot_cpu_data;
 
 	cpuid(CPUID_MWAIT_LEAF, &eax, &ebx, &ecx, &edx);
 
@@ -107,9 +108,14 @@ static long acpi_processor_ffh_cstate_probe_cpu(void *_cx)
 			"Monitor-Mwait will be used to enter C-%d state\n",
 			cx->type);
 	}
-	snprintf(cx->desc,
-			ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
-			cx->address);
+	if (c->x86_vendor == X86_VENDOR_INTEL)
+		snprintf(cx->desc,
+			 ACPI_CX_DESC_LEN, "ACPI FFH INTEL MWAIT 0x%x",
+			 cx->address);
+	else
+		snprintf(cx->desc,
+			 ACPI_CX_DESC_LEN, "ACPI FFH AMD MWAIT 0x%x",
+			 cx->address);
 out:
 	return retval;
 }
-- 
2.14.4
