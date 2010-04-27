From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH] ehci: Disable wake on overcurrent (WKOC_E)
Date: Tue, 27 Apr 2010 16:22:53 +0200
Message-ID: <201004271622.55904.linux__10440.0057964542$1272378241$gmane$org@rainbow-software.org>
References: <201004271523.48647.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201004271523.48647.linux@rainbow-software.org>
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Disable wake on overcurrent in EHCI.
This fixes immediate resume from standby on boards where port power is lost
in standby which triggers overcurrent detection. At least Asus P4P800 boards
are affected when any of the USBPWxx (e.g. USBPW12) jumpers is set to 5V.
Tested on Asus P4P800-VM.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-source-2.6.33-orig/drivers/usb/host/ehci-hub.c	2010-02-24 19:52:17.000000000 +0100
+++ linux-source-2.6.33/drivers/usb/host/ehci-hub.c	2010-04-27 16:04:37.000000000 +0200
@@ -180,10 +180,10 @@ static int ehci_bus_suspend (struct usb_
 			 * set), the port change detection will finally fix it.
 			 */
 			if (t1 & PORT_CONNECT) {
-				t2 |= PORT_WKOC_E | PORT_WKDISC_E;
+				t2 |= PORT_WKDISC_E;
 				t2 &= ~PORT_WKCONN_E;
 			} else {
-				t2 |= PORT_WKOC_E | PORT_WKCONN_E;
+				t2 |= PORT_WKCONN_E;
 				t2 &= ~PORT_WKDISC_E;
 			}
 		} else
@@ -912,7 +912,7 @@ static int ehci_hub_control (
 			 * mode if we have hostpc feature
 			 */
 			temp &= ~PORT_WKCONN_E;
-			temp |= PORT_WKDISC_E | PORT_WKOC_E;
+			temp |= PORT_WKDISC_E;
 			ehci_writel(ehci, temp | PORT_SUSPEND, status_reg);
 			if (hostpc_reg) {
 				spin_unlock_irqrestore(&ehci->lock, flags);


-- 
Ondrej Zary
