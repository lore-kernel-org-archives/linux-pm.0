From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 6/11] PCI PM: Consistently use variable name
	"error" for pm call return values
Date: Sat, 14 Mar 2009 12:30:35 +0100
Message-ID: <200903141230.36190.rjw__49133.8106025525$1237031219$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl> <200903141224.29591.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903141224.29591.rjw@sisk.pl>
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
To: pm list <linux-pm@lists.linux-foundation.org>
Cc: Arve@smtp1.linux-foundation.org, Jeremy Fitzhardinge <jeremy@goop.org>, Frans Pop <elendil@planet.nl>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux PCI <linux-pci@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

From: Frans Pop <elendil@planet.nl>

I noticed two functions use a variable "i" to store the return value of PM
function calls while the rest of the file uses "error". As "i" normally
indicates a counter of some sort it seems better to keep this consistent.

Signed-off-by: Frans Pop <elendil@planet.nl>
Signed-off-by: Jesse Barnes <jbarnes@virtuousgeek.org>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-driver.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -352,17 +352,17 @@ static int pci_legacy_suspend(struct dev
 {
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * drv = pci_dev->driver;
-	int i = 0;
+	int error = 0;
 
 	if (drv && drv->suspend) {
 		pci_power_t prev = pci_dev->current_state;
 
 		pci_dev->state_saved = false;
 
-		i = drv->suspend(pci_dev, state);
-		suspend_report_result(drv->suspend, i);
-		if (i)
-			return i;
+		error = drv->suspend(pci_dev, state);
+		suspend_report_result(drv->suspend, error);
+		if (error)
+			return error;
 
 		if (pci_dev->state_saved)
 			goto Fixup;
@@ -385,20 +385,20 @@ static int pci_legacy_suspend(struct dev
  Fixup:
 	pci_fixup_device(pci_fixup_suspend, pci_dev);
 
-	return i;
+	return error;
 }
 
 static int pci_legacy_suspend_late(struct device *dev, pm_message_t state)
 {
 	struct pci_dev * pci_dev = to_pci_dev(dev);
 	struct pci_driver * drv = pci_dev->driver;
-	int i = 0;
+	int error = 0;
 
 	if (drv && drv->suspend_late) {
-		i = drv->suspend_late(pci_dev, state);
-		suspend_report_result(drv->suspend_late, i);
+		error = drv->suspend_late(pci_dev, state);
+		suspend_report_result(drv->suspend_late, error);
 	}
-	return i;
+	return error;
 }
 
 static int pci_legacy_resume_early(struct device *dev)
