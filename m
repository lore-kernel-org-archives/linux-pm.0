From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH 3/3] Sound (HDA Intel): Restore PCI configuration
	space with interrupts off
Date: Sat, 6 Dec 2008 15:09:08 +0100
Message-ID: <200812061509.08994.rjw__39690.9550684088$1228572825$gmane$org@sisk.pl>
References: <200812020320.31876.rjw@sisk.pl> <200812061505.33815.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812061505.33815.rjw@sisk.pl>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rjw@sisk.pl>
Subject: Sound (HDA Intel): Restore PCI configuration space with interrupts off

Move the restoration of the standard PCI configuration registers
in the snd_hda_intel driver to a ->resume_early() callback executed
with interrupts disabled, since doing that with interrupts enabled
may lead to problems in some cases.

This patch addresses the regression from 2.6.26 tracked as
http://bugzilla.kernel.org/show_bug.cgi?id=12121 .

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
---
 sound/pci/hda/hda_intel.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

Index: linux-2.6/sound/pci/hda/hda_intel.c
===================================================================
--- linux-2.6.orig/sound/pci/hda/hda_intel.c
+++ linux-2.6/sound/pci/hda/hda_intel.c
@@ -1951,13 +1951,16 @@ static int azx_suspend(struct pci_dev *p
 	return 0;
 }
 
+static int azx_resume_early(struct pci_dev *pci)
+{
+	return pci_restore_state(pci);
+}
+
 static int azx_resume(struct pci_dev *pci)
 {
 	struct snd_card *card = pci_get_drvdata(pci);
 	struct azx *chip = card->private_data;
 
-	pci_set_power_state(pci, PCI_D0);
-	pci_restore_state(pci);
 	if (pci_enable_device(pci) < 0) {
 		printk(KERN_ERR "hda-intel: pci_enable_device failed, "
 		       "disabling device\n");
@@ -2465,6 +2468,7 @@ static struct pci_driver driver = {
 	.remove = __devexit_p(azx_remove),
 #ifdef CONFIG_PM
 	.suspend = azx_suspend,
+	.resume_early = azx_resume_early,
 	.resume = azx_resume,
 #endif
 };
