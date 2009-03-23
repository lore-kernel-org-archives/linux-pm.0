From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [RFC][PATCH 2/2] radeonfb: Use
	platform_pci_set_power_state()
Date: Mon, 23 Mar 2009 22:32:55 +0100
Message-ID: <200903232232.56772.rjw__27753.8735339933$1237844750$gmane$org@sisk.pl>
References: <200903210003.55161.rjw@sisk.pl> <200903222208.22434.rjw@sisk.pl>
	<200903232230.10831.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903232230.10831.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

Use platform_pci_set_power_state() to finalize the transition into D2
after programming the PMCSR of the device directly.

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
+		platform_pci_set_power_state(rinfo->pdev, PCI_D2);
 	} else {
 		printk(KERN_DEBUG "radeonfb (%s): switching to D0 state...\n",
 		       pci_name(rinfo->pdev));
