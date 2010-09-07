From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH #upstream-fixes] libata: skip EH autopsy and recovery during
 suspend
Date: Tue, 07 Sep 2010 14:05:31 +0200
Message-ID: <4C862A8B.3000506@gmail.com>
References: <201007091750.05020.stephan.diestelhorst@amd.com> <4C7376BE.5040006@gmail.com> <201008242239.43249.rjw@sisk.pl> <201008270109.36687.rjw@sisk.pl> <4C7F6931.4050707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <4C7F6931.4050707@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Stephan Diestelhorst <stephan.diestelhorst@amd.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>, "linux-pm@lists.osdl.org" <linux-pm@lists.osdl.org>, Stephan Diestelhorst <stephan.diestelhorst@gmail.com>, stable@kernel.org
List-Id: linux-pm@vger.kernel.org

For some mysterious reason, certain hardware reacts badly to usual EH
actions while the system is going for suspend.  As the devices won't
be needed until the system is resumed, ask EH to skip usual autopsy
and recovery and proceed directly to suspend.

Signed-off-by: Tejun Heo <tj@kernel.org>
Tested-by: Stephan Diestelhorst <stephan.diestelhorst@amd.com>
Cc: stable@kernel.org
---
 drivers/ata/libata-core.c |   14 +++++++++++++-
 drivers/ata/libata-eh.c   |    4 ++++
 include/linux/libata.h    |    1 +
 3 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 9ceb493..92cd5f3 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5427,6 +5427,7 @@ static int ata_host_request_pm(struct ata_host *host, pm_message_t mesg,
  */
 int ata_host_suspend(struct ata_host *host, pm_message_t mesg)
 {
+	unsigned int ehi_flags = ATA_EHI_QUIET;
 	int rc;

 	/*
@@ -5435,7 +5436,18 @@ int ata_host_suspend(struct ata_host *host, pm_message_t mesg)
 	 */
 	ata_lpm_enable(host);

-	rc = ata_host_request_pm(host, mesg, 0, ATA_EHI_QUIET, 1);
+	/*
+	 * On some hardware, device fails to respond after spun down
+	 * for suspend.  As the device won't be used before being
+	 * resumed, we don't need to touch the device.  Ask EH to skip
+	 * the usual stuff and proceed directly to suspend.
+	 *
+	 * http://thread.gmane.org/gmane.linux.ide/46764
+	 */
+	if (mesg.event == PM_EVENT_SUSPEND)
+		ehi_flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_NO_RECOVERY;
+
+	rc = ata_host_request_pm(host, mesg, 0, ehi_flags, 1);
 	if (rc == 0)
 		host->dev->power.power_state = mesg;
 	return rc;
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 0108731..95838b3 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3242,6 +3242,10 @@ static int ata_eh_skip_recovery(struct ata_link *link)
 	if (link->flags & ATA_LFLAG_DISABLED)
 		return 1;

+	/* skip if explicitly requested */
+	if (ehc->i.flags & ATA_EHI_NO_RECOVERY)
+		return 1;
+
 	/* thaw frozen port and recover failed devices */
 	if ((ap->pflags & ATA_PFLAG_FROZEN) || ata_link_nr_enabled(link))
 		return 0;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 89115f8..d1ef41b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -335,6 +335,7 @@ enum {
 	ATA_EHI_HOTPLUGGED	= (1 << 0),  /* could have been hotplugged */
 	ATA_EHI_NO_AUTOPSY	= (1 << 2),  /* no autopsy */
 	ATA_EHI_QUIET		= (1 << 3),  /* be quiet */
+	ATA_EHI_NO_RECOVERY	= (1 << 4),  /* no recovery */

 	ATA_EHI_DID_SOFTRESET	= (1 << 16), /* already soft-reset this port */
 	ATA_EHI_DID_HARDRESET	= (1 << 17), /* already soft-reset this port */
