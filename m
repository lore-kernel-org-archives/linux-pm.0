From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/2] Suspend: Clean up suspend_64.c
Date: Mon, 17 Dec 2007 00:30:22 +0100
Message-ID: <200712170030.23670.rjw@sisk.pl>
References: <200712162346.10241.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <200712162346.10241.rjw@sisk.pl>
Content-Disposition: inline
Sender: linux-acpi-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: Pavel Machek <pavel@ucw.cz>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.osdl.org>, Borislav Petkov <bbpetkov@yahoo.de>
List-Id: linux-pm@vger.kernel.org

From: Borislav Petkov <bbpetkov@yahoo.de>

There's a freakishly long comment in suspend_64.c, shorten it.

Signed-off-by: Borislav Petkov <bbpetkov@yahoo.de>
Cc: Pavel Machek <pavel@ucw.cz>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/kernel/suspend_64.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: linux-2.6/arch/x86/kernel/suspend_64.c
===================================================================
--- linux-2.6.orig/arch/x86/kernel/suspend_64.c
+++ linux-2.6/arch/x86/kernel/suspend_64.c
@@ -118,7 +118,12 @@ void fix_processor_context(void)
 	int cpu = smp_processor_id();
 	struct tss_struct *t = &per_cpu(init_tss, cpu);
 
-	set_tss_desc(cpu,t);	/* This just modifies memory; should not be necessary. But... This is necessary, because 386 hardware has concept of busy TSS or some similar stupidity. */
+	/*
+	 * This just modifies memory; should not be necessary. But... This
+	 * is necessary, because 386 hardware has concept of busy TSS or some
+	 * similar stupidity.
+	 */
+	set_tss_desc(cpu, t);
 
 	cpu_gdt(cpu)[GDT_ENTRY_TSS].type = 9;
 
@@ -138,7 +143,6 @@ void fix_processor_context(void)
                 loaddebug(&current->thread, 6);
                 loaddebug(&current->thread, 7);
 	}
-
 }
 
 #ifdef CONFIG_HIBERNATION

