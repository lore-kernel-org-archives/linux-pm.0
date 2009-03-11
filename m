From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 10/10] PCI PM: Restore config spaces of all
	devices during early resume
Date: Wed, 11 Mar 2009 10:56:51 +0100
Message-ID: <200903111056.52716.rjw__26394.5742896341$1236766744$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl> <200903111030.39371.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903111030.39371.rjw@sisk.pl>
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
Cc: Arve@smtp1.linux-foundation.org, Jeremy Fitzhardinge <jeremy@goop.org>, Frans Pop <elendil@planet.nl>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>

At present the configuration spaces of PCI devices that have no drivers
or no PM support in the drivers (either legacy or through a pm object) are not
saved during suspend and, consequently, they are not restored during resume.
This generally may lead to the state of the system being slightly inconsistent
after the resume, so it's better to save and restore the configuration spaces
of these devices as well.

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 drivers/pci/pci-driver.c |   16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/pci/pci-driver.c
===================================================================
--- linux-2.6.orig/drivers/pci/pci-driver.c
+++ linux-2.6/drivers/pci/pci-driver.c
@@ -516,13 +516,13 @@ static int pci_pm_suspend(struct device 
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_SUSPEND);
 
+	pci_dev->state_saved = false;
+
 	if (!pm) {
 		pci_pm_default_suspend(pci_dev);
 		goto Fixup;
 	}
 
-	pci_dev->state_saved = false;
-
 	if (pm->suspend) {
 		pci_power_t prev = pci_dev->current_state;
 		int error;
@@ -554,8 +554,10 @@ static int pci_pm_suspend_noirq(struct d
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend_late(dev, PMSG_SUSPEND);
 
-	if (!pm)
+	if (!pm) {
+		pci_save_state(pci_dev);
 		return 0;
+	}
 
 	if (pm->suspend_noirq) {
 		pci_power_t prev = pci_dev->current_state;
@@ -650,13 +652,13 @@ static int pci_pm_freeze(struct device *
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_FREEZE);
 
+	pci_dev->state_saved = false;
+
 	if (!pm) {
 		pci_pm_default_suspend(pci_dev);
 		return 0;
 	}
 
-	pci_dev->state_saved = false;
-
 	if (pm->freeze) {
 		int error;
 
@@ -738,13 +740,13 @@ static int pci_pm_poweroff(struct device
 	if (pci_has_legacy_pm_support(pci_dev))
 		return pci_legacy_suspend(dev, PMSG_HIBERNATE);
 
+	pci_dev->state_saved = false;
+
 	if (!pm) {
 		pci_pm_default_suspend(pci_dev);
 		goto Fixup;
 	}
 
-	pci_dev->state_saved = false;
-
 	if (pm->poweroff) {
 		int error;
 
