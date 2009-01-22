From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/3] PCI PM: Do not wait for buses in B2 or B3
	during resume
Date: Thu, 22 Jan 2009 23:39:57 +0100
Message-ID: <200901222339.58432.rjw__26867.9209323183$1232664224$gmane$org@sisk.pl>
References: <200901222335.07341.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901222335.07341.rjw@sisk.pl>
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
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Alan Jenkins <alan-jenkins@tuffmail.co.uk>, Matthew Wilcox <matthew@wil.cx>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

pci_restore_standard_config() adds extra delay for PCI buses in
low power states (B2 or B3), but this is only correct for buses in
B2, because the buses in B3 are reset when they are put back into
B0.  Thus we should wait for such buses to settle after the reset,
but it's not a good idea to wait that long (1.1 s) with interrupts
off.

On the other hand, we have never waited for buses in B2 and B3
during resume and it seems reasonable to go back to this well
tested behaviour.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

Index: linux-2.6/drivers/pci/pci.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci.c
+++ linux-2.6/drivers/pci/pci.c
@@ -1403,19 +1403,19 @@ int pci_restore_standard_config(struct p
 	if (error)
 		return error;
 
-	if (pci_is_bridge(dev)) {
-		if (prev_state > PCI_D1)
-			mdelay(PCI_PM_BUS_WAIT);
-	} else {
-		switch(prev_state) {
-		case PCI_D3cold:
-		case PCI_D3hot:
-			mdelay(pci_pm_d3_delay);
-			break;
-		case PCI_D2:
-			udelay(PCI_PM_D2_DELAY);
-			break;
-		}
+	/*
+	 * This assumes that we won't get a bus in B2 or B3 from the BIOS, but
+	 * we've made this assumption forever and it appears to be universally
+	 * satisfied.
+	 */
+	switch(prev_state) {
+	case PCI_D3cold:
+	case PCI_D3hot:
+		mdelay(pci_pm_d3_delay);
+		break;
+	case PCI_D2:
+		udelay(PCI_PM_D2_DELAY);
+		break;
 	}
 
 	dev->current_state = PCI_D0;
