From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 2/2] sh-sci / PM: Use power.irq_safe
Date: Sat, 20 Aug 2011 21:33:09 +0200
Message-ID: <201108202133.09222.rjw__29212.2983177707$1313868962$gmane$org@sisk.pl>
References: <201108202131.19479.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108202131.19479.rjw@sisk.pl>
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
 drivers/tty/serial/sh-sci.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

Index: linux/drivers/tty/serial/sh-sci.c
===================================================================
--- linux.orig/drivers/tty/serial/sh-sci.c
+++ linux/drivers/tty/serial/sh-sci.c
@@ -1582,11 +1582,15 @@ static int sci_startup(struct uart_port
 
 	dev_dbg(port->dev, "%s(%d)\n", __func__, port->line);
 
+	pm_runtime_irq_safe(port->dev);
+
 	sci_port_enable(s);
 
 	ret = sci_request_irq(s);
-	if (unlikely(ret < 0))
+	if (unlikely(ret < 0)) {
+		pm_runtime_irq_unsafe(port->dev);
 		return ret;
+	}
 
 	sci_request_dma(port);
 
@@ -1609,6 +1613,8 @@ static void sci_shutdown(struct uart_por
 	sci_free_irq(s);
 
 	sci_port_disable(s);
+
+	pm_runtime_irq_unsafe(port->dev);
 }
 
 static unsigned int sci_scbrr_calc(unsigned int algo_id, unsigned int bps,
