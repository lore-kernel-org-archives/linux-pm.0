From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] hibernation: on 32-bit x86, disabled in favor of KASLR
Date: Wed, 22 Mar 2017 17:27:01 -0700
Message-ID: <20170323002701.GA90470@beast>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-doc-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Pavel Machek <pavel@ucw.cz>, Evgenii Shatokhin <eugene.shatokhin@yandex.ru>, linux-doc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

This is a modified revert of commit 65fe935dd238 ("x86/KASLR, x86/power:
Remove x86 hibernation restrictions"), since it appears that 32-bit
hibernation still can't support KASLR. 64-bit is fine. Since people have
been running with KASLR by default on 32-bit since v4.8, this disables
hibernation (with a warning). Booting with "nokaslr" will disable KASLR
and enable hibernation.

Reported-by: Evgenii Shatokhin <eugene.shatokhin@yandex.ru>
Signed-off-by: Kees Cook <keescook@chromium.org>
Cc: stable@vger.kernel.org # v4.8+
---
 Documentation/admin-guide/kernel-parameters.txt |  5 +++++
 arch/x86/boot/compressed/kaslr.c                |  3 +++
 kernel/power/hibernate.c                        | 18 +++++++++++++++++-
 3 files changed, 25 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 2ba45caabada..6f899c7f587d 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1725,6 +1725,11 @@
 			kernel and module base offset ASLR (Address Space
 			Layout Randomization).
 
+			On 32-bit x86 with CONFIG_HIBERNATION, hibernation
+			is disabled if KASLR is enabled. If "nokaslr" is
+			specified, KASLR will be diabled and hibernation
+			will be enabled.
+
 	keepinitrd	[HW,ARM]
 
 	kernelcore=	[KNL,X86,IA-64,PPC]
diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
index 8b7c9e75edcb..b694af45f1e0 100644
--- a/arch/x86/boot/compressed/kaslr.c
+++ b/arch/x86/boot/compressed/kaslr.c
@@ -572,6 +572,9 @@ void choose_random_location(unsigned long input,
 		return;
 	}
 
+	if (IS_ENABLED(CONFIG_X86_32) && IS_ENABLED(CONFIG_HIBERNATION))
+		warn("KASLR active: hibernation disabled on 32-bit x86.");
+
 	boot_params->hdr.loadflags |= KASLR_FLAG;
 
 	/* Prepare to add new identity pagetables on demand. */
diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index a8b978c35a6a..1d8f1fe1b7f4 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -37,9 +37,14 @@
 #include "power.h"
 
 
-static int nocompress;
+#if defined(CONFIG_X86_32) && defined(CONFIG_RANDOMIZE_BASE)
+static int noresume = 1;
+static int nohibernate = 1;
+#else
 static int noresume;
 static int nohibernate;
+#endif
+static int nocompress;
 static int resume_wait;
 static unsigned int resume_delay;
 static char resume_file[256] = CONFIG_PM_STD_PARTITION;
@@ -1194,3 +1199,14 @@ __setup("hibernate=", hibernate_setup);
 __setup("resumewait", resumewait_setup);
 __setup("resumedelay=", resumedelay_setup);
 __setup("nohibernate", nohibernate_setup);
+
+/* Allow hibernation to be disabled in favor of KASLR on 32-bit x86. */
+#if defined(CONFIG_X86_32) && defined(CONFIG_RANDOMIZE_BASE)
+static int __init nokaslr_hibernate_setup(char *str)
+{
+	noresume = 0;
+	nohibernate = 0;
+	return 1;
+}
+__setup("nokaslr", nokaslr_hibernate_setup);
+#endif
-- 
2.7.4


-- 
Kees Cook
Pixel Security
