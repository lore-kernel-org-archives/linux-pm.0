From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] MIPS: Convert i8259.c to using syscore_ops (was:
	Re: Status of MIPS on 3.0.0-rc6 kernel)
Date: Fri, 15 Jul 2011 23:53:37 +0200
Message-ID: <201107152353.38004.rjw__22745.0271755972$1310767527$gmane$org@sisk.pl>
References: <4E1ECE3B.10308@broadcom.com> <201107142151.24763.rjw@sisk.pl>
	<4E2032D7.9000704@broadcom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4E2032D7.9000704@broadcom.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ralf Baechle <ralf@linux-mips.org>
Cc: "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>, Roland Vossen <rvossen@broadcom.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Jonas Gorski <jonas.gorski@gmail.com>, "devel@linuxdriverproject.org" <devel@linuxdriverproject.org>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, July 15, 2011, Roland Vossen wrote:
> > Please check if the appended patch helps.
> 
> It does, I am able to build a big endian MIPS kernel now. Can you notify 
> me if you submit this patch ?

Well, it's been submitted already. :-)

Ralf, the appended patch is necessary to fix build on MIPS due to a
missing conversion to syscore_ops.  Please take it to your tree or
let me know if you want me to push it myself.

Thanks,
Rafael

---
From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: MIPS: Convert i8259.c to using syscore_ops

The code in arch/mips/kernel/i8259.c still hasn't been converted to
using struct syscore_ops instead of a sysdev for resume and shutdown.
As a result, this code doesn't build any more after suspend, resume
and shutdown callbacks have been removed from struct sysdev_class.
Fix this problem by converting i8259.c to using syscore_ops.

Reported-and-tested-by: Roland Vossen <rvossen@broadcom.com>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 arch/mips/kernel/i8259.c |   22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

Index: linux-2.6/arch/mips/kernel/i8259.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/i8259.c
+++ linux-2.6/arch/mips/kernel/i8259.c
@@ -14,7 +14,7 @@
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/spinlock.h>
-#include <linux/sysdev.h>
+#include <linux/syscore_ops.h>
 #include <linux/irq.h>
 
 #include <asm/i8259.h>
@@ -215,14 +215,13 @@ spurious_8259A_irq:
 	}
 }
 
-static int i8259A_resume(struct sys_device *dev)
+static void i8259A_resume(void)
 {
 	if (i8259A_auto_eoi >= 0)
 		init_8259A(i8259A_auto_eoi);
-	return 0;
 }
 
-static int i8259A_shutdown(struct sys_device *dev)
+static void i8259A_shutdown(void)
 {
 	/* Put the i8259A into a quiescent state that
 	 * the kernel initialization code can get it
@@ -232,26 +231,17 @@ static int i8259A_shutdown(struct sys_de
 		outb(0xff, PIC_MASTER_IMR);	/* mask all of 8259A-1 */
 		outb(0xff, PIC_SLAVE_IMR);	/* mask all of 8259A-1 */
 	}
-	return 0;
 }
 
-static struct sysdev_class i8259_sysdev_class = {
-	.name = "i8259",
+static struct syscore_ops i8259_syscore_ops = {
 	.resume = i8259A_resume,
 	.shutdown = i8259A_shutdown,
 };
 
-static struct sys_device device_i8259A = {
-	.id	= 0,
-	.cls	= &i8259_sysdev_class,
-};
-
 static int __init i8259A_init_sysfs(void)
 {
-	int error = sysdev_class_register(&i8259_sysdev_class);
-	if (!error)
-		error = sysdev_register(&device_i8259A);
-	return error;
+	register_syscore_ops(&i8259_syscore_ops);
+	return 0;
 }
 
 device_initcall(i8259A_init_sysfs);
 
