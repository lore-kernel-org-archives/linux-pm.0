From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/4] x86: Remove obsolete PM definitions from NMI
	header
Date: Thu, 12 Jun 2008 10:27:08 +0200
Message-ID: <200806121027.09085.rjw__17886.6086797372$1213259958$gmane$org@sisk.pl>
References: <200806121025.24668.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200806121025.24668.rjw@sisk.pl>
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
To: LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@elte.hu>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Remove obsolete and no longer used PM-related definitions from
include/asm-x86/nmi.h .

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 include/asm-x86/nmi.h |   21 ---------------------
 1 file changed, 21 deletions(-)

Index: linux-2.6/include/asm-x86/nmi.h
===================================================================
--- linux-2.6.orig/include/asm-x86/nmi.h
+++ linux-2.6/include/asm-x86/nmi.h
@@ -15,27 +15,6 @@
  */
 int do_nmi_callback(struct pt_regs *regs, int cpu);
 
-#ifdef CONFIG_PM
-
-/** Replace the PM callback routine for NMI. */
-struct pm_dev *set_nmi_pm_callback(pm_callback callback);
-
-/** Unset the PM callback routine back to the default. */
-void unset_nmi_pm_callback(struct pm_dev *dev);
-
-#else
-
-static inline struct pm_dev *set_nmi_pm_callback(pm_callback callback)
-{
-	return 0;
-}
-
-static inline void unset_nmi_pm_callback(struct pm_dev *dev)
-{
-}
-
-#endif /* CONFIG_PM */
-
 #ifdef CONFIG_X86_64
 extern void default_do_nmi(struct pt_regs *);
 extern void die_nmi(char *str, struct pt_regs *regs, int do_panic);
