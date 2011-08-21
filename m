From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/2 v2] sh-sci / PM: Use power.irq_safe
Date: Sun, 21 Aug 2011 21:11:44 +0200
Message-ID: <201108212111.45012.rjw__25475.1291512095$1313954011$gmane$org@sisk.pl>
References: <201108202131.19479.rjw@sisk.pl> <201108212109.30399.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108212109.30399.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-sh@vger.kernel.org
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Since sci_port_enable() and sci_port_disable() may be run with
interrupts off and they execute pm_runtime_get_sync() and
pm_runtime_put_sync(), respectively, the SCI device's
power.irq_safe flags has to be used to indicate that it is safe
to execute runtime PM callbacks for this device with interrupts off.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/tty/serial/sh-sci.c |    1 +
 1 file changed, 1 insertion(+)

Index: linux/drivers/tty/serial/sh-sci.c
===================================================================
--- linux.orig/drivers/tty/serial/sh-sci.c
+++ linux/drivers/tty/serial/sh-sci.c
@@ -1913,6 +1913,7 @@ static int __devinit sci_init_single(str
 
 		port->dev = &dev->dev;
 
+		pm_runtime_irq_safe(&dev->dev);
 		pm_runtime_enable(&dev->dev);
 	}
 
