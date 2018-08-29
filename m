From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH v3] console: Add console=spcr option
Date: Wed, 29 Aug 2018 11:56:18 -0400
Message-ID: <20180829155618.32359-1-prarit@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Prarit Bhargava <prarit@redhat.com>, Mark Salter <msalter@redhat.com>, Al Stone <ahs3@redhat.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, x86@kernel.org, Petr Mladek <pmladek@suse.com>, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Kees Cook <keescook@chromium.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

ACPI may contain an SPCR table that defines a default system console.
On ARM if the table is present then the SPCR console is enabled by default.
On x86 the SPCR console is used if 'earlycon' (no parameters) is
specified as a kernel parameter and is used only as the early console.
To use the SPCR data as a console a user must boot with 'earlycon',
grep logs & specify a console= kernel parameter, and then reboot again.

Add 'console=spcr' that enables a firmware or hardware console, and on
x86 enable the SPCR console if 'console=spcr' is specified.

Tested on systems with and without an ACPI SPCR.  The following kernel
parameters were also tested:

console=ttyS0,115200    		works
earlycon                		works (early console only)
console=spcr            		works (full console as expected)
no console or earlycon arguments	works (no output as expected)

v2: Fix prototype.
v3: Change parameter to "spcr" and add error message to spcr init call.

Signed-off-by: Prarit Bhargava <prarit@redhat.com>
Cc: Mark Salter <msalter@redhat.com>
Cc: Al Stone <ahs3@redhat.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: x86@kernel.org
Cc: Petr Mladek <pmladek@suse.com>
Cc: Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-pm@vger.kernel.org
---
 Documentation/admin-guide/kernel-parameters.txt |  1 +
 arch/x86/kernel/acpi/boot.c                     |  9 +++++++++
 include/linux/console.h                         |  1 +
 kernel/printk/printk.c                          | 10 ++++++++++
 4 files changed, 21 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 9871e649ffef..f51a32cda90c 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -635,6 +635,7 @@
 
 		hvc<n>	Use the hypervisor console device <n>. This is for
 			both Xen and PowerPC hypervisors.
+		spcr	[X86] Enable ACPI SPCR console
 
 		If the device connected to the port is not a TTY but a braille
 		device, prepend "brl," before the device type, for instance
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 3b20607d581b..3fed5e9a6b82 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1771,3 +1771,12 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 	e820__range_add(addr, size, E820_TYPE_ACPI);
 	e820__update_table_print();
 }
+
+void __init arch_console_setup(void)
+{
+	int ret;
+
+	ret = acpi_parse_spcr(false, true);
+	if (ret)
+		pr_err(PREFIX "ERROR: SPCR console is not enabled (%d)\n", ret);
+}
diff --git a/include/linux/console.h b/include/linux/console.h
index ec9bdb3d7bab..562b825d911c 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -183,6 +183,7 @@ extern int is_console_locked(void);
 extern int braille_register_console(struct console *, int index,
 		char *console_options, char *braille_options);
 extern int braille_unregister_console(struct console *);
+void arch_console_setup(void);
 #ifdef CONFIG_TTY
 extern void console_sysfs_notify(void);
 #else
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 924e37fb1620..35859606e714 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2097,6 +2097,11 @@ static int __init console_msg_format_setup(char *str)
 }
 __setup("console_msg_format=", console_msg_format_setup);
 
+void __init __weak arch_console_setup(void)
+{
+	return;
+}
+
 /*
  * Set up a console.  Called via do_early_param() in init/main.c
  * for each "console=" parameter in the boot command line.
@@ -2107,6 +2112,11 @@ static int __init console_setup(char *str)
 	char *s, *options, *brl_options = NULL;
 	int idx;
 
+	if (!strcmp(str, "spcr")) {
+		arch_console_setup();
+		return 1;
+	}
+
 	if (_braille_console_setup(&str, &brl_options))
 		return 1;
 
-- 
2.14.4
