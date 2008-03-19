From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 1/3] Fix misuse of wakeup flag accessors in
	serial core
Date: Wed, 19 Mar 2008 22:35:13 +0100
Message-ID: <200803192235.14645.rjw@sisk.pl>
References: <200803190315.m2J3FXnK029022@imap1.linux-foundation.org>
	<20080319185755.GA18464@kroah.com> <200803192233.55313.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803192233.55313.rjw@sisk.pl>
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
To: Greg KH <greg@kroah.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

This patch (as1059) fixes a mistake in the way the serial core
initializes a device's wakeup settings.  It should use the accessor
routine instead of relying on a macro producing an lvalue.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---

Index: usb-2.6/drivers/serial/serial_core.c
===================================================================
--- usb-2.6.orig/drivers/serial/serial_core.c
+++ usb-2.6/drivers/serial/serial_core.c
@@ -2356,7 +2356,7 @@ int uart_add_one_port(struct uart_driver
 	 */
 	tty_dev = tty_register_device(drv->tty_driver, port->line, port->dev);
 	if (likely(!IS_ERR(tty_dev))) {
-		device_can_wakeup(tty_dev) = 1;
+		device_init_wakeup(tty_dev, 1);
 		device_set_wakeup_enable(tty_dev, 0);
 	} else
 		printk(KERN_ERR "Cannot register tty device on line %d\n",
