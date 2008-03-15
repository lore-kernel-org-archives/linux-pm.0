From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 1/3] Fix misuse of wakeup flag accessors in
	serial core
Date: Sat, 15 Mar 2008 17:53:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0803151713480.28007-100000__26158.1259001561$1205618281$gmane$org@netrider.rowland.org>
References: <200803142337.12605.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200803142337.12605.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Greg KH <greg@kroah.com>, Andrew Morton <akpm@linux-foundation.org>, "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: sfr@canb.auug.org.au, Kernel development list <linux-kernel@vger.kernel.org>, Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>, linux-next@vger.kernel.org, apw@shadowen.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

This patch (as1059) fixes a mistake in the way the serial core
initializes a device's wakeup settings.  It should use the accessor
routine instead of relying on a macro producing an lvalue.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

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
