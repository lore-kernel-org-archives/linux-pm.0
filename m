From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v1 2/2] ACPI / boot: Don't define unused variables
Date: Sat,  8 Jul 2017 18:50:30 +0300
Message-ID: <20170708155030.12587-2-andriy.shevchenko@linux.intel.com>
References: <20170708155030.12587-1-andriy.shevchenko@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:2118 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752870AbdGHPvG (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 8 Jul 2017 11:51:06 -0400
In-Reply-To: <20170708155030.12587-1-andriy.shevchenko@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Some code in acpi_parse_x2apic() conditionally compiled, though parts of
it are being used in any case. This annoys gcc.

arch/x86/kernel/acpi/boot.c: In function ‘acpi_parse_x2apic’:
arch/x86/kernel/acpi/boot.c:203:5: warning: variable ‘enabled’ set but not used [-Wunused-but-set-variable]
  u8 enabled;
     ^~~~~~~
arch/x86/kernel/acpi/boot.c:202:6: warning: variable ‘apic_id’ set but not used [-Wunused-but-set-variable]
  int apic_id;
      ^~~~~~~

Re-arrange the code to avoid compiling unused variables.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 arch/x86/kernel/acpi/boot.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index ac9bb564f004..f33eddf4eaa9 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -199,8 +199,10 @@ static int __init
 acpi_parse_x2apic(struct acpi_subtable_header *header, const unsigned long end)
 {
 	struct acpi_madt_local_x2apic *processor = NULL;
+#ifdef CONFIG_X86_X2APIC
 	int apic_id;
 	u8 enabled;
+#endif
 
 	processor = (struct acpi_madt_local_x2apic *)header;
 
@@ -209,9 +211,10 @@ acpi_parse_x2apic(struct acpi_subtable_header *header, const unsigned long end)
 
 	acpi_table_print_madt_entry(header);
 
+#ifdef CONFIG_X86_X2APIC
 	apic_id = processor->local_apic_id;
 	enabled = processor->lapic_flags & ACPI_MADT_ENABLED;
-#ifdef CONFIG_X86_X2APIC
+
 	/*
 	 * We need to register disabled CPU as well to permit
 	 * counting disabled CPUs. This allows us to size
-- 
2.11.0
