From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] x86/KASLR: remove x86 hibernation restrictions
Date: Mon, 13 Jun 2016 15:10:02 -0700
Message-ID: <20160613221002.GA29719@www.outflux.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, Stephen Smalley <sds@tycho.nsa.gov>, Ingo Molnar <mingo@kernel.org>, Logan Gunthorpe <logang@deltatee.com>, the arch/x86 maintainers <x86@kernel.org>, Borislav Petkov <bp@alien8.de>, Jonathan Corbet <corbet@lwn.net>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Baoquan He <bhe@redhat.com>, Yinghai Lu <yinghai@kernel.org>, Andy Lutomirski <luto@kernel.org>, linux-doc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

With the commit "Fix 64-bit code passing control to image kernel", there
is no longer a problem with hibernation resuming a KASLR-booted kernel
image.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Depends on: https://lkml.org/lkml/2016/6/13/442
---
 Documentation/kernel-parameters.txt | 10 ++++------
 arch/x86/boot/compressed/kaslr.c    |  7 -------
 kernel/power/hibernate.c            |  6 ------
 3 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 82b42c958d1c..fa8c6d470ad2 100644
--- a/Documentation/kernel-parameters.txt
+++ b/Documentation/kernel-parameters.txt
@@ -1803,12 +1803,10 @@ bytes respectively. Such letter suffixes can also be entirely omitted.
 	js=		[HW,JOY] Analog joystick
 			See Documentation/input/joystick.txt.
 
-	kaslr/nokaslr	[X86]
-			Enable/disable kernel and module base offset ASLR
-			(Address Space Layout Randomization) if built into
-			the kernel. When CONFIG_HIBERNATION is selected,
-			kASLR is disabled by default. When kASLR is enabled,
-			hibernation will be disabled.
+	nokaslr		[KNL]
+			When CONFIG_RANDOMIZE_BASE is set, this disables
+			kernel and module base offset ASLR (Address Space
+			Layout Randomization).
 
 	keepinitrd	[HW,ARM]
 
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index cfeb0259ed81..dff42177cb0c 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -471,17 +471,10 @@ unsigned char *choose_random_location(unsigned long input,
 	unsigned long choice = output;
 	unsigned long random_addr;
 
-#ifdef CONFIG_HIBERNATION
-	if (!cmdline_find_option_bool("kaslr")) {
-		warn("KASLR disabled: 'kaslr' not on cmdline (hibernation selected).");
-		goto out;
-	}
-#else
 	if (cmdline_find_option_bool("nokaslr")) {
 		warn("KASLR disabled: 'nokaslr' on cmdline.");
 		goto out;
 	}
-#endif
 
 	boot_params->hdr.loadflags |= KASLR_FLAG;
 
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index fca9254280ee..9021387c6ff4 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -1154,11 +1154,6 @@ static int __init nohibernate_setup(char *str)
 	return 1;
 }
 
-static int __init kaslr_nohibernate_setup(char *str)
-{
-	return nohibernate_setup(str);
-}
-
 static int __init page_poison_nohibernate_setup(char *str)
 {
 #ifdef CONFIG_PAGE_POISONING_ZERO
@@ -1182,5 +1177,4 @@ __setup("hibernate=", hibernate_setup);
 __setup("resumewait", resumewait_setup);
 __setup("resumedelay=", resumedelay_setup);
 __setup("nohibernate", nohibernate_setup);
-__setup("kaslr", kaslr_nohibernate_setup);
 __setup("page_poison=", page_poison_nohibernate_setup);
-- 
2.7.4


-- 
Kees Cook
Chrome OS & Brillo Security
