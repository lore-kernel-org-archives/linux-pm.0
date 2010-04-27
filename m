From: Ondrej Zary <linux@rainbow-software.org>
Subject: [PATCH v2] [RFC] ehci: Disable wake on overcurrent
	(WKOC_E) and disconnect (WKDISC_E)
Date: Tue, 27 Apr 2010 18:25:20 +0200
Message-ID: <201004271825.21771.linux__2465.03241728551$1272385691$gmane$org@rainbow-software.org>
References: <201004271523.48647.linux@rainbow-software.org>
	<201004271622.55904.linux@rainbow-software.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201004271622.55904.linux@rainbow-software.org>
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

The previous patch was not enough as it worked only when there were no USB
devices connected. With a bus-powered device connected, power loss causes
disconnect which wakes up the machine immediately again.

Does anyone know why is this enabled by default? No other USB host driver
(except oxu210hp-hcd which is based on EHCI) does that. This also means that
suspended laptop wakes up when disconnecting a mouse? I don't have any to test
right now. Wakeup on USB connect makes a bit more sense but I'd say that it's
still not a good idea to enable it by default.

If we don't need that, perhaps the following patch should be applied.


Disable wake on overcurrent and disconnect in EHCI.
This fixes immediate resume from standby on boards where port power is lost
in standby which triggers overcurrent detection and disconnect if a
bus-powered device is connected. At least Asus P4P800 boards are affected when
any of the USBPWxx (e.g. USBPW12) jumpers is set to 5V.
Tested on Asus P4P800-VM.

Signed-off-by: Ondrej Zary <linux@rainbow-software.org>

--- linux-source-2.6.33-orig/drivers/usb/host/ehci-hub.c	2010-02-24 19:52:17.000000000 +0100
+++ linux-source-2.6.33/drivers/usb/host/ehci-hub.c	2010-04-27 18:17:36.000000000 +0200
@@ -173,21 +173,16 @@ static int ehci_bus_suspend (struct usb_
 		}
 
 		/* enable remote wakeup on all ports */
+		t2 &= ~PORT_WAKE_BITS;
 		if (hcd->self.root_hub->do_remote_wakeup) {
 			/* only enable appropriate wake bits, otherwise the
 			 * hardware can not go phy low power mode. If a race
 			 * condition happens here(connection change during bits
 			 * set), the port change detection will finally fix it.
 			 */
-			if (t1 & PORT_CONNECT) {
-				t2 |= PORT_WKOC_E | PORT_WKDISC_E;
-				t2 &= ~PORT_WKCONN_E;
-			} else {
-				t2 |= PORT_WKOC_E | PORT_WKCONN_E;
-				t2 &= ~PORT_WKDISC_E;
-			}
-		} else
-			t2 &= ~PORT_WAKE_BITS;
+			if (!(t1 & PORT_CONNECT))
+				t2 |= PORT_WKCONN_E;
+		}
 
 		if (t1 != t2) {
 			ehci_vdbg (ehci, "port %d, %08x -> %08x\n",


-- 
Ondrej Zary
