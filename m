From: David Brownell <david-b@pacbell.net>
Subject: [patch 2/2] clk_must_disable() implementation on AT91
Date: Thu, 22 Mar 2007 11:08:21 -0700
Message-ID: <200703221108.21861.david-b__22249.1750996143$1174587247$gmane$org@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: linux-pm@lists.linux-foundation.org, Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Andrew Victor <andrew@sanpeople.com>
List-Id: linux-pm@vger.kernel.org

This supports the new clk_must_disable() interface for AT91 systems:

 - Implement the call, replacing at91_suspend_entering_slow_clock()
   and eliminating various "that's not exported" build warnings;

 - Use it in three drivers: USB Host, USB Peripheral, and RS232 serial.

Briefly, those are three of the drivers that need to act differently when
going into deeper sleep states (suspend-to-RAM, vs standby), since among
other things they can't act as wakeup event sources without using the
clocks which are disabled in those deeper sleep states.

(The at91_ethernet driver would be another such driver, but it doesn't
currently implement wake-on-LAN even in the "standby" mode.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
 arch/arm/mach-at91/clock.c    |   18 ++++++++++++++++++
 arch/arm/mach-at91/generic.h  |    1 +
 arch/arm/mach-at91/pm.c       |    7 +------
 drivers/serial/atmel_serial.c |    3 ++-
 drivers/usb/gadget/at91_udc.c |    2 +-
 drivers/usb/host/ohci-at91.c  |    2 +-
 6 files changed, 24 insertions(+), 9 deletions(-)

Index: at91/arch/arm/mach-at91/clock.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- at91.orig/arch/arm/mach-at91/clock.c	2007-02-19 16:15:13.000000000 -0800
+++ at91/arch/arm/mach-at91/clock.c	2007-02-19 17:45:25.000000000 -0800
@@ -33,6 +33,7 @@
 #include <asm/arch/cpu.h>
 =

 #include "clock.h"
+#include "generic.h"
 =

 =

 /*
@@ -255,6 +256,23 @@ EXPORT_SYMBOL(clk_get_rate);
 =

 /*------------------------------------------------------------------------=
*/
 =

+#ifdef CONFIG_PM
+
+int clk_must_disable(struct clk *clk)
+{
+	if (!at91_suspend_entering_slow_clock())
+		return 0;
+
+	while (clk->parent)
+		clk =3D clk->parent;
+	return clk !=3D &clk32k;
+}
+EXPORT_SYMBOL(clk_must_disable);
+
+#endif
+
+/*------------------------------------------------------------------------=
*/
+
 #ifdef CONFIG_AT91_PROGRAMMABLE_CLOCKS
 =

 /*
Index: at91/arch/arm/mach-at91/generic.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- at91.orig/arch/arm/mach-at91/generic.h	2007-02-19 17:30:37.000000000 -0=
800
+++ at91/arch/arm/mach-at91/generic.h	2007-02-19 17:45:25.000000000 -0800
@@ -38,6 +38,7 @@ extern void __init at91_clock_associate(
  /* Power Management */
 extern void at91_irq_suspend(void);
 extern void at91_irq_resume(void);
+extern int at91_suspend_entering_slow_clock(void);
 =

  /* GPIO */
 #define AT91RM9200_PQFP		3	/* AT91RM9200 PQFP package has 3 banks */
Index: at91/arch/arm/mach-at91/pm.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- at91.orig/arch/arm/mach-at91/pm.c	2007-02-19 13:57:53.000000000 -0800
+++ at91/arch/arm/mach-at91/pm.c	2007-02-19 17:45:25.000000000 -0800
@@ -104,20 +104,15 @@ static int at91_pm_verify_clocks(void)
 }
 =

 /*
- * Call this from platform driver suspend() to see how deeply to suspend.
+ * This is called from clk_must_disable(), to see how deeply to suspend.
  * For example, some controllers (like OHCI) need one of the PLL clocks
  * in order to act as a wakeup source, and those are not available when
  * going into slow clock mode.
- *
- * REVISIT: generalize as clk_will_be_available(clk)?  Other platforms have
- * the very same problem (but not using at91 main_clk), and it'd be better
- * to add one generic API rather than lots of platform-specific ones.
  */
 int at91_suspend_entering_slow_clock(void)
 {
 	return (target_state =3D=3D PM_SUSPEND_MEM);
 }
-EXPORT_SYMBOL(at91_suspend_entering_slow_clock);
 =

 =

 static void (*slow_clock)(void);
Index: at91/drivers/serial/atmel_serial.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- at91.orig/drivers/serial/atmel_serial.c	2007-02-19 13:57:53.000000000 -=
0800
+++ at91/drivers/serial/atmel_serial.c	2007-02-19 17:45:25.000000000 -0800
@@ -888,7 +888,8 @@ static int atmel_serial_suspend(struct p
 	struct uart_port *port =3D platform_get_drvdata(pdev);
 	struct atmel_uart_port *atmel_port =3D (struct atmel_uart_port *) port;
 =

-	if (device_may_wakeup(&pdev->dev) && !at91_suspend_entering_slow_clock())
+	if (device_may_wakeup(&pdev->dev)
+			&& !clk_must_disable(atmel_port->clk))
 		enable_irq_wake(port->irq);
 	else {
 		uart_suspend_port(&atmel_uart, port);
Index: at91/drivers/usb/gadget/at91_udc.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- at91.orig/drivers/usb/gadget/at91_udc.c	2007-02-19 13:57:53.000000000 -=
0800
+++ at91/drivers/usb/gadget/at91_udc.c	2007-02-19 17:45:25.000000000 -0800
@@ -1804,7 +1804,7 @@ static int at91udc_suspend(struct platfo
 	 */
 	if ((!udc->suspended && udc->addr)
 			|| !wake
-			|| at91_suspend_entering_slow_clock()) {
+			|| clk_must_disable(udc->fclk)) {
 		pullup(udc, 0);
 		wake =3D 0;
 	} else
Index: at91/drivers/usb/host/ohci-at91.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- at91.orig/drivers/usb/host/ohci-at91.c	2007-02-19 13:57:53.000000000 -0=
800
+++ at91/drivers/usb/host/ohci-at91.c	2007-02-19 17:45:25.000000000 -0800
@@ -299,7 +299,7 @@ ohci_hcd_at91_drv_suspend(struct platfor
 	 *
 	 * REVISIT: some boards will be able to turn VBUS off...
 	 */
-	if (at91_suspend_entering_slow_clock()) {
+	if (clk_must_disable(fclk)) {
 		ohci_usb_reset (ohci);
 		at91_stop_clock();
 	}
