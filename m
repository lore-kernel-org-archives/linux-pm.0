From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 2/2] radeonfb: Use
	__pci_complete_power_transition()
Date: Wed, 25 Mar 2009 01:42:08 +0100
Message-ID: <200903250142.09545.rjw@sisk.pl>
References: <200903250138.53234.linux-pci-owner@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903250138.53234.linux-pci-owner@vger.kernel.org>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linux PCI <linux-pci@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Use __pci_complete_power_transition() to finalize the transition into
D2 after programming the PMCSR of the device directly.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/video/aty/radeon_pm.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6/drivers/video/aty/radeon_pm.c
===================================================================
--- linux-2.6.orig/drivers/video/aty/radeon_pm.c
+++ linux-2.6/drivers/video/aty/radeon_pm.c
@@ -2582,7 +2582,7 @@ static void radeon_set_suspend(struct ra
 		 * calling pci_set_power_state()
 		 */
 		radeonfb_whack_power_state(rinfo, PCI_D2);
-		pci_set_power_state(rinfo->pdev, PCI_D2);
+		__pci_complete_power_transition(rinfo->pdev, PCI_D2);
 	} else {
 		printk(KERN_DEBUG "radeonfb (%s): switching to D0 state...\n",
 		       pci_name(rinfo->pdev));
