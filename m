From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: sdhci: Loads of scary messages during suspend/resume
	with SD card inserted
Date: Mon, 29 Sep 2008 12:38:57 +0100
Message-ID: <20080929113857.GA17379__38708.0228924335$1222688544$gmane$org@srcf.ucam.org>
References: <200809282146.57960.elendil@planet.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200809282146.57960.elendil@planet.nl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Frans Pop <elendil@planet.nl>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, drzeus-mmc@drzeus.cx
List-Id: linux-pm@vger.kernel.org

On Sun, Sep 28, 2008 at 09:46:57PM +0200, Frans Pop wrote:
> Sep 28 23:12:39 aragorn kernel: ricoh-mmc: Suspending.
> Sep 28 23:12:39 aragorn kernel: ricoh-mmc: Controller is now re-enabled.
> Sep 28 23:12:39 aragorn kernel: mmc0: card 8879 removed

Eep! I'm sure that doesn't sound like a good idea. ricoh-mmc is 
suspending before sdhci is. In the process, it flips the hardware back 
into non-sdhci mode and the sdhci controller stops being able to talk to 
the card. I suspect that this upsets its own suspend routine rather a 
lot. Does this help at all? Not a complete fix, I suspect you'll still 
have issues on resume.

diff --git a/drivers/mmc/host/ricoh_mmc.c b/drivers/mmc/host/ricoh_mmc.c
index a16d760..015c248 100644
--- a/drivers/mmc/host/ricoh_mmc.c
+++ b/drivers/mmc/host/ricoh_mmc.c
@@ -191,20 +191,6 @@ static void __devexit ricoh_mmc_remove(struct pci_dev *pdev)
 	pci_set_drvdata(pdev, NULL);
 }
 
-static int ricoh_mmc_suspend(struct pci_dev *pdev, pm_message_t state)
-{
-	struct pci_dev *fw_dev = NULL;
-
-	fw_dev = pci_get_drvdata(pdev);
-	BUG_ON(fw_dev == NULL);
-
-	printk(KERN_INFO DRIVER_NAME ": Suspending.\n");
-
-	ricoh_mmc_enable(fw_dev);
-
-	return 0;
-}
-
 static int ricoh_mmc_resume(struct pci_dev *pdev)
 {
 	struct pci_dev *fw_dev = NULL;
@@ -224,7 +210,6 @@ static struct pci_driver ricoh_mmc_driver = {
 	.id_table =	pci_ids,
 	.probe = 	ricoh_mmc_probe,
 	.remove =	__devexit_p(ricoh_mmc_remove),
-	.suspend =	ricoh_mmc_suspend,
 	.resume =	ricoh_mmc_resume,
 };


-- 
Matthew Garrett | mjg59@srcf.ucam.org
