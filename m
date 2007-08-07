From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2.6.23-rc2 1/2] define clk_must_disable()
Date: Mon, 6 Aug 2007 22:23:51 -0700
Message-ID: <20070806222351.090dc035.akpm@linux-foundation.org>
References: <200708061111.03407.david-b@pacbell.net>
	<200708061338.08561.david-b@pacbell.net>
	<20070806214805.GE3360@flint.arm.linux.org.uk>
	<200708061646.41835.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200708061646.41835.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Victor <andrew@sanpeople.com>, linux-pm@lists.linux-foundation.org, Russell King <rmk@arm.linux.org.uk>
List-Id: linux-pm@vger.kernel.org


ookkkay.  I'm going to pretend that I had an email malfunction which
deleted all rmk and david-b email for the past 24 hours.  I'd suggest that
others adopt the same pretence.



Russell, I have received the below from David.  Could you please review it
for inclusion?

Thanks.


From: David Brownell <david-b@pacbell.net>

This supports the clk_must_disable() interface for AT91 systems:

 - Implement the call, replacing at91_suspend_entering_slow_clock();

 - Use it in three drivers: USB Host, USB Peripheral, and RS232 serial.

Briefly, those are three of the drivers that need to act differently
when going into deeper sleep states (suspend-to-RAM), where among other
things they can't act as wakeup event sources.

(The at91_ethernet driver would be another such driver, but it doesn't
currently implement wake-on-LAN even in the "standby" mode.)

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/arm/mach-at91/clock.c    |   18 ++++++++++++++++++
 arch/arm/mach-at91/generic.h  |    1 +
 arch/arm/mach-at91/pm.c       |    7 +------
 drivers/serial/atmel_serial.c |    3 ++-
 drivers/usb/gadget/at91_udc.c |    2 +-
 drivers/usb/host/ohci-at91.c  |    2 +-
 6 files changed, 24 insertions(+), 9 deletions(-)

diff -puN arch/arm/mach-at91/clock.c~at91-implements-clk_must_disable arch/arm/mach-at91/clock.c
--- a/arch/arm/mach-at91/clock.c~at91-implements-clk_must_disable
+++ a/arch/arm/mach-at91/clock.c
@@ -32,6 +32,7 @@
 #include <asm/arch/cpu.h>
 
 #include "clock.h"
+#include "generic.h"
 
 
 /*
@@ -254,6 +255,23 @@ EXPORT_SYMBOL(clk_get_rate);
 
 /*------------------------------------------------------------------------*/
 
+#ifdef CONFIG_PM
+
+int clk_must_disable(struct clk *clk)
+{
+	if (!at91_suspend_entering_slow_clock())
+		return 0;
+
+	while (clk->parent)
+		clk = clk->parent;
+	return clk != &clk32k;
+}
+EXPORT_SYMBOL(clk_must_disable);
+
+#endif
+
+/*------------------------------------------------------------------------*/
+
 #ifdef CONFIG_AT91_PROGRAMMABLE_CLOCKS
 
 /*
diff -puN arch/arm/mach-at91/generic.h~at91-implements-clk_must_disable arch/arm/mach-at91/generic.h
--- a/arch/arm/mach-at91/generic.h~at91-implements-clk_must_disable
+++ a/arch/arm/mach-at91/generic.h
@@ -36,6 +36,7 @@ extern void __init at91_clock_associate(
  /* Power Management */
 extern void at91_irq_suspend(void);
 extern void at91_irq_resume(void);
+extern int at91_suspend_entering_slow_clock(void);
 
  /* GPIO */
 #define AT91RM9200_PQFP		3	/* AT91RM9200 PQFP package has 3 banks */
diff -puN arch/arm/mach-at91/pm.c~at91-implements-clk_must_disable arch/arm/mach-at91/pm.c
--- a/arch/arm/mach-at91/pm.c~at91-implements-clk_must_disable
+++ a/arch/arm/mach-at91/pm.c
@@ -103,20 +103,15 @@ static int at91_pm_verify_clocks(void)
 }
 
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
 	return (target_state == PM_SUSPEND_MEM);
 }
-EXPORT_SYMBOL(at91_suspend_entering_slow_clock);
 
 
 static void (*slow_clock)(void);
diff -puN drivers/serial/atmel_serial.c~at91-implements-clk_must_disable drivers/serial/atmel_serial.c
--- a/drivers/serial/atmel_serial.c~at91-implements-clk_must_disable
+++ a/drivers/serial/atmel_serial.c
@@ -921,7 +921,8 @@ static int atmel_serial_suspend(struct p
 	struct uart_port *port = platform_get_drvdata(pdev);
 	struct atmel_uart_port *atmel_port = (struct atmel_uart_port *) port;
 
-	if (device_may_wakeup(&pdev->dev) && !at91_suspend_entering_slow_clock())
+	if (device_may_wakeup(&pdev->dev)
+			&& !clk_must_disable(atmel_port->clk))
 		enable_irq_wake(port->irq);
 	else {
 		uart_suspend_port(&atmel_uart, port);
diff -puN drivers/usb/gadget/at91_udc.c~at91-implements-clk_must_disable drivers/usb/gadget/at91_udc.c
--- a/drivers/usb/gadget/at91_udc.c~at91-implements-clk_must_disable
+++ a/drivers/usb/gadget/at91_udc.c
@@ -1782,7 +1782,7 @@ static int at91udc_suspend(struct platfo
 	 */
 	if ((!udc->suspended && udc->addr)
 			|| !wake
-			|| at91_suspend_entering_slow_clock()) {
+			|| clk_must_disable(udc->fclk)) {
 		pullup(udc, 0);
 		wake = 0;
 	} else
diff -puN drivers/usb/host/ohci-at91.c~at91-implements-clk_must_disable drivers/usb/host/ohci-at91.c
--- a/drivers/usb/host/ohci-at91.c~at91-implements-clk_must_disable
+++ a/drivers/usb/host/ohci-at91.c
@@ -299,7 +299,7 @@ ohci_hcd_at91_drv_suspend(struct platfor
 	 *
 	 * REVISIT: some boards will be able to turn VBUS off...
 	 */
-	if (at91_suspend_entering_slow_clock()) {
+	if (clk_must_disable(fclk)) {
 		ohci_usb_reset (ohci);
 		at91_stop_clock();
 	}
_
