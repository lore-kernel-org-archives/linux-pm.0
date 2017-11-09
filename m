From: Juergen Gross <jgross@suse.com>
Subject: [PATCH v2 3/5] x86/acpi: add test for ACPI_FADT_NO_VGA
Date: Thu,  9 Nov 2017 14:27:37 +0100
Message-ID: <20171109132739.23465-4-jgross@suse.com>
References: <20171109132739.23465-1-jgross@suse.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:60430 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754463AbdKIN14 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 9 Nov 2017 08:27:56 -0500
In-Reply-To: <20171109132739.23465-1-jgross@suse.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, mingo@redhat.com, hpa@zytor.com, x86@kernel.org, Juergen Gross <jgross@suse.com>, rjw@rjwysocki.net, len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org

Add a test for ACPI_FADT_NO_VGA when scanning the FADT and set the new
flag x86_platform.legacy.no_vga accordingly.

Cc: rjw@rjwysocki.net
Cc: len.brown@intel.com
Cc: pavel@ucw.cz
Cc: linux-pm@vger.kernel.org

Signed-off-by: Juergen Gross <jgross@suse.com>
---
 arch/x86/include/asm/x86_init.h | 1 +
 arch/x86/kernel/acpi/boot.c     | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/arch/x86/include/asm/x86_init.h b/arch/x86/include/asm/x86_init.h
index ad15a0fda917..260e9a85fecb 100644
--- a/arch/x86/include/asm/x86_init.h
+++ b/arch/x86/include/asm/x86_init.h
@@ -208,6 +208,7 @@ enum x86_legacy_i8042_state {
 struct x86_legacy_features {
 	enum x86_legacy_i8042_state i8042;
 	int rtc;
+	int no_vga;
 	int reserve_bios_regions;
 	struct x86_legacy_devices devices;
 };
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 079535e53e2a..ef9e02e614d0 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -961,6 +961,11 @@ static int __init acpi_parse_fadt(struct acpi_table_header *table)
 		x86_platform.legacy.rtc = 0;
 	}
 
+	if (acpi_gbl_FADT.boot_flags & ACPI_FADT_NO_VGA) {
+		pr_debug("ACPI: probing for VGA not safe\n");
+		x86_platform.legacy.no_vga = 1;
+	}
+
 #ifdef CONFIG_X86_PM_TIMER
 	/* detect the location of the ACPI PM Timer */
 	if (acpi_gbl_FADT.header.revision >= FADT2_REVISION_ID) {
-- 
2.12.3
