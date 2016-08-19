From: Al Stone <ahs3@redhat.com>
Subject: [PATCH 2/2] x86: ACPI: make variable names clearer in acpi_parse_madt_lapic_entries()
Date: Fri, 19 Aug 2016 17:24:02 -0600
Message-ID: <1471649042-19418-3-git-send-email-ahs3@redhat.com>
References: <1471649042-19418-1-git-send-email-ahs3@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1471649042-19418-1-git-send-email-ahs3@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: x86@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: ahs3@redhat.com, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Pavel Machek <pavel@ucw.cz>, trivial@kernel.org
List-Id: linux-pm@vger.kernel.org

This patch has no functional change; it is purely cosmetic, though
it does make it a wee bit easier to understand the code.  Before, the
count of LAPICs was being stored in the variable 'x2count' and the
count of X2APICs was being stored in the variable 'count'.  This
patch swaps that so that the routine acpi_parse_madt_lapic_entries()
will now consistently use x2count to refer to X2APIC info, and count
to refer to LAPIC info.

Signed-off-by: Al Stone <ahs3@redhat.com>
---
 arch/x86/kernel/acpi/boot.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 5fb8f05..ccd27fe 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1031,8 +1031,8 @@ static int __init acpi_parse_madt_lapic_entries(void)
 			return ret;
 		}
 
-		x2count = madt_proc[0].count;
-		count = madt_proc[1].count;
+		count = madt_proc[0].count;
+		x2count = madt_proc[1].count;
 	}
 	if (!count && !x2count) {
 		printk(KERN_ERR PREFIX "No LAPIC entries present\n");
-- 
2.7.4
