From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 4/4] x86 PM: Update stale comments
Date: Sun, 3 Feb 2008 22:00:11 +0100
Message-ID: <200802032200.11885.rjw__7726.61064188487$1202072716$gmane$org@sisk.pl>
References: <200802032141.56887.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802032141.56887.rjw@sisk.pl>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, Sam Ravnborg <sam@ravnborg.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

In some suspend and hibernation files in arch/x86/power there are
comments referring to arch/x86-64 and arch/i386 .  Update them to
reflect the current code layout.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/x86/power/hibernate_32.c |    4 ++--
 arch/x86/power/hibernate_64.c |    2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/arch/x86/power/hibernate_32.c
===================================================================
--- linux-2.6.orig/arch/x86/power/hibernate_32.c
+++ linux-2.6/arch/x86/power/hibernate_32.c
@@ -13,7 +13,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 
-/* Defined in arch/i386/power/swsusp.S */
+/* Defined in hibernate_asm_32.S */
 extern int restore_image(void);
 
 /* References to section boundaries */
@@ -23,7 +23,7 @@ extern const void __nosave_begin, __nosa
 pgd_t *resume_pg_dir;
 
 /* The following three functions are based on the analogous code in
- * arch/i386/mm/init.c
+ * arch/x86/mm/init_32.c
  */
 
 /*
Index: linux-2.6/arch/x86/power/hibernate_64.c
===================================================================
--- linux-2.6.orig/arch/x86/power/hibernate_64.c
+++ linux-2.6/arch/x86/power/hibernate_64.c
@@ -18,7 +18,7 @@
 /* References to section boundaries */
 extern const void __nosave_begin, __nosave_end;
 
-/* Defined in arch/x86_64/kernel/suspend_asm.S */
+/* Defined in hibernate_asm_64.S */
 extern int restore_image(void);
 
 /*
