From: Patrick Mochel <mochel@digitalimplant.org>
Subject: [PATCH 4/4] [pci pm] Make pci_choose_state() use the
 real device state request
Date: Mon, 20 Feb 2006 16:55:55 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0602201654320.21145-100000@monsoon.he.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============43834547727524847=="
Return-path: <linux-pm-bounces@lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: greg@kroah.com, akpm@osdl.org, torvalds@osdl.org
Cc: linux-pm@osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============43834547727524847==
Content-Type: TEXT/PLAIN; charset=US-ASCII


Look at pm_message_t::state (along with the message event type) to
determine the PCI power state to return. This allows all of the PCI
power states to be used with this helper (and with the sysfs runtime
PM interface).

[ Previously, the returned value was limited to PCI_D0 or PCI_D3hot
depending on whether PM_EVENT_ON or PM_EVENT_{FREEZE,SUSPEND} were
specified. ]

Signed-off-by: Patrick Mochel <mochel@linux.intel.com>

---

 drivers/pci/pci.c |   29 +++++++++++++++++++----------
 1 files changed, 19 insertions(+), 10 deletions(-)

applies-to: 0a199426c04045ef33edd13b368e56841a62f30f
7847b165a322629e3d468f1308e58d8e5a905127
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d2d1879..2f160aa 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -404,30 +404,39 @@ int (*platform_pci_choose_state)(struct
  * message.
  */

-pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t state)
+pci_power_t pci_choose_state(struct pci_dev *dev, pm_message_t msg)
 {
+	pci_power_t state = PCI_D3hot;
 	int ret;

 	if (!pci_find_capability(dev, PCI_CAP_ID_PM))
 		return PCI_D0;

 	if (platform_pci_choose_state) {
-		ret = platform_pci_choose_state(dev, state);
+		ret = platform_pci_choose_state(dev, msg);
 		if (ret >= 0)
-			state.event = ret;
+			msg.state = ret;
 	}

-	switch (state.event) {
+	switch (msg.event) {
 	case PM_EVENT_ON:
-		return PCI_D0;
+		state = PCI_D0;
+		break;
 	case PM_EVENT_FREEZE:
 	case PM_EVENT_SUSPEND:
-		return PCI_D3hot;
+		if (msg.state && msg.state <= PCI_D3hot)
+			state = msg.state;
+		break;
 	default:
-		printk("They asked me for state %d\n", state.event);
-		BUG();
-	}
-	return PCI_D0;
+		dev_err(&dev->dev, "PCI: Invalid PM Event [Event %d] [State %u]\n",
+			msg.event, msg.state);
+		WARN_ON(1);
+		state = PCI_D0;
+		break;
+	}
+	dev_dbg(&dev->dev, "PCI: Translated Power Message %d/%u -> %u\n",
+		msg.event, msg.state, state);
+	return state;
 }

 EXPORT_SYMBOL(pci_choose_state);
---
0.99.9.GIT

--===============43834547727524847==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============43834547727524847==--
