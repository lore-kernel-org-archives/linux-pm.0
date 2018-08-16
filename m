From: Prarit Bhargava <prarit@redhat.com>
Subject: [PATCH v2] console: Add console=auto option
Date: Thu, 16 Aug 2018 13:39:01 -0400
Message-ID: <20180816173902.18971-1-prarit@redhat.com>
References: <728a8e68-ea4b-4040-a0fc-217df4f1928d@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <728a8e68-ea4b-4040-a0fc-217df4f1928d@redhat.com>
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

Add 'console=auto' that enables a firmware or hardware console, and on
x86 enable the SPCR console if 'console=auto' is specified.

Tested on systems with and without an ACPI SPCR.  The following kernel
parameters were also tested:

console=ttyS0,115200    		works
earlycon                		works (early console only)
console=auto            		works (full console as expected)
no console or earlycon arguments	works (no output as expected)

v2: Fix prototype.

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
 arch/x86/kernel/acpi/boot.c                     |  5 +++++
 include/linux/console.h                         |  1 +
 kernel/printk/printk.c                          | 10 ++++++++++
 4 files changed, 17 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index a32f2a126791..dd057224f33b 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -635,6 +635,7 @@
 
 		hvc<n>	Use the hypervisor console device <n>. This is for
 			both Xen and PowerPC hypervisors.
+		auto	[X86] Enable ACPI SPCR console
 
 		If the device connected to the port is not a TTY but a braille
 		device, prepend "brl," before the device type, for instance
diff --git a/arch/x86/kernel/acpi/boot.c b/arch/x86/kernel/acpi/boot.c
index 3b20607d581b..fb2616ba3b21 100644
--- a/arch/x86/kernel/acpi/boot.c
+++ b/arch/x86/kernel/acpi/boot.c
@@ -1771,3 +1771,8 @@ void __init arch_reserve_mem_area(acpi_physical_address addr, size_t size)
 	e820__range_add(addr, size, E820_TYPE_ACPI);
 	e820__update_table_print();
 }
+
+void __init arch_console_setup(void)
+{
+	acpi_parse_spcr(false, true);
+}
diff --git a/include/linux/console.h b/include/linux/console.h
index dfd6b0e97855..c2a6dde9a799 100644
--- a/include/linux/console.h
+++ b/include/linux/console.h
@@ -181,6 +181,7 @@ extern int is_console_locked(void);
 extern int braille_register_console(struct console *, int index,
 		char *console_options, char *braille_options);
 extern int braille_unregister_console(struct console *);
+void arch_console_setup(void);
 #ifdef CONFIG_TTY
 extern void console_sysfs_notify(void);
 #else
diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
index 247808333ba4..bdd53858664b 100644
--- a/kernel/printk/printk.c
+++ b/kernel/printk/printk.c
@@ -2078,6 +2078,11 @@ static int __init console_msg_format_setup(char *str)
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
@@ -2088,6 +2093,11 @@ static int __init console_setup(char *str)
 	char *s, *options, *brl_options = NULL;
 	int idx;
 
+	if (!strcmp(str, "auto")) {
+		arch_console_setup();
+		return 1;
+	}
+
 	if (_braille_console_setup(&str, &brl_options))
 		return 1;
 
-- 
2.14.4
