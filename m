From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH v2 2/2] libata: PM code cleanup for ata port
Date: Fri, 25 Jan 2013 14:32:25 +0800
Message-ID: <510226F9.5000709@intel.com>
References: <1346143791-2995-1-git-send-email-aaron.lu@intel.com> <50FDA8B3.6090100@pobox.com> <20130125062935.GA9779@aaronlu.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga01.intel.com ([192.55.52.88]:17503 "EHLO mga01.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750961Ab3AYGbi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 25 Jan 2013 01:31:38 -0500
In-Reply-To: <20130125062935.GA9779@aaronlu.sh.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Jeff Wu <jeff.wu@amd.com>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

For system freeze, if the port is already runtime suspended, leave it
alone and just return. The port will be resumed on thaw before it will
be used.

And since we will call get_noresume for every device during prepare
phase, and the port is resumed during thaw phase, it can't be in runtime
suspended state during the poweroff phase. So remove the
runtime_suspended check in poweroff callback.

And for all suspend(freeze/suspend/poweroff/etc.), there is no need to
touch the device, so set no_autopsy and no_recovery for them all.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/ata/libata-core.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 6a5ef86..439c608 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5334,9 +5334,6 @@ static int ata_port_request_pm(struct ata_port *ap, pm_message_t mesg,
 
 static int __ata_port_suspend_common(struct ata_port *ap, pm_message_t mesg, int *async)
 {
-	unsigned int ehi_flags = ATA_EHI_QUIET;
-	int rc;
-
 	/*
 	 * On some hardware, device fails to respond after spun down
 	 * for suspend.  As the device won't be used before being
@@ -5345,11 +5342,9 @@ static int __ata_port_suspend_common(struct ata_port *ap, pm_message_t mesg, int
 	 *
 	 * http://thread.gmane.org/gmane.linux.ide/46764
 	 */
-	if (mesg.event & PM_EVENT_SUSPEND)
-		ehi_flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_NO_RECOVERY;
-
-	rc = ata_port_request_pm(ap, mesg, 0, ehi_flags, async);
-	return rc;
+	unsigned int ehi_flags = ATA_EHI_QUIET | ATA_EHI_NO_AUTOPSY |
+				 ATA_EHI_NO_RECOVERY;
+	return ata_port_request_pm(ap, mesg, 0, ehi_flags, async);
 }
 
 static int ata_port_suspend_common(struct device *dev, pm_message_t mesg)
@@ -5370,16 +5365,13 @@ static int ata_port_suspend(struct device *dev)
 static int ata_port_do_freeze(struct device *dev)
 {
 	if (pm_runtime_suspended(dev))
-		pm_runtime_resume(dev);
+		return 0;
 
 	return ata_port_suspend_common(dev, PMSG_FREEZE);
 }
 
 static int ata_port_poweroff(struct device *dev)
 {
-	if (pm_runtime_suspended(dev))
-		return 0;
-
 	return ata_port_suspend_common(dev, PMSG_HIBERNATE);
 }
 
-- 
1.8.1

