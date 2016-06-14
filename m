From: tip-bot for Kees Cook <tipbot@zytor.com>
Subject: [tip:x86/boot] x86/KASLR, x86/power: Remove x86 hibernation
 restrictions
Date: Tue, 14 Jun 2016 04:32:20 -0700
Message-ID: <tip-36f79151e74bbca512cac092c2c56c5cbc5f2f03@git.kernel.org>
References: <20160613221002.GA29719@www.outflux.net>
Reply-To: linux-kernel@vger.kernel.org, luto@kernel.org,
	  len.brown@intel.com, yinghai@kernel.org,
	  linux-pm@vger.kernel.org, tglx@linutronix.de,
	  dvlasenk@redhat.com, logang@deltatee.com, keescook@chromium.org,
	  pavel@ucw.cz, bp@alien8.de, bhe@redhat.com, corbet@lwn.net,
	  hpa@zytor.com, sds@tycho.nsa.gov, mingo@kernel.org,
	  torvalds@linux-foundation.org, brgerst@gmail.com,
	  peterz@infradead.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160613221002.GA29719@www.outflux.net>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Cc: pavel@ucw.cz, peterz@infradead.org, brgerst@gmail.com, torvalds@linux-foundation.org, mingo@kernel.org, sds@tycho.nsa.gov, hpa@zytor.com, corbet@lwn.net, bhe@redhat.com, bp@alien8.de, luto@kernel.org, len.brown@intel.com, linux-kernel@vger.kernel.org, keescook@chromium.org, logang@deltatee.com, dvlasenk@redhat.com, tglx@linutronix.de, linux-pm@vger.kernel.org, yinghai@kernel.org
List-Id: linux-pm@vger.kernel.org

Commit-ID:  36f79151e74bbca512cac092c2c56c5cbc5f2f03
Gitweb:     http://git.kernel.org/tip/36f79151e74bbca512cac092c2c56c5cbc5f2f03
Author:     Kees Cook <keescook@chromium.org>
AuthorDate: Mon, 13 Jun 2016 15:10:02 -0700
Committer:  Ingo Molnar <mingo@kernel.org>
CommitDate: Tue, 14 Jun 2016 12:14:13 +0200

x86/KASLR, x86/power: Remove x86 hibernation restrictions

With the following fix:

  70595b479ce1 ("x86/power/64: Fix crash whan the hibernation code passes control to the image kernel")

... there is no longer a problem with hibernation resuming a
KASLR-booted kernel image, so remove the restriction.

Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Denys Vlasenko <dvlasenk@redhat.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Len Brown <len.brown@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>
Cc: Logan Gunthorpe <logang@deltatee.com>
Cc: Pavel Machek <pavel@ucw.cz>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephen Smalley <sds@tycho.nsa.gov>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Yinghai Lu <yinghai@kernel.org>
Cc: linux-doc@vger.kernel.org
Link: http://lkml.kernel.org/r/20160613221002.GA29719@www.outflux.net
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 Documentation/kernel-parameters.txt | 10 ++++------
 arch/x86/boot/compressed/kaslr.c    |  7 -------
 kernel/power/hibernate.c            |  6 ------
 3 files changed, 4 insertions(+), 19 deletions(-)

diff --git a/Documentation/kernel-parameters.txt b/Documentation/kernel-parameters.txt
index 82b42c9..fa8c6d4 100644
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
index cfeb025..dff4217 100644
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
index fca9254..9021387 100644
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
