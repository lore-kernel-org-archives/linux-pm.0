From: Aaron Lu <aaron.lu@intel.com>
Subject: [PATCH v2 1/2] libata: pm: differentiate system and runtime pm for
 ata port
Date: Fri, 25 Jan 2013 14:29:35 +0800
Message-ID: <20130125062935.GA9779@aaronlu.sh.intel.com>
References: <1346143791-2995-1-git-send-email-aaron.lu@intel.com>
 <50FDA8B3.6090100@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:4597 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751063Ab3AYG2t (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 25 Jan 2013 01:28:49 -0500
Content-Disposition: inline
In-Reply-To: <50FDA8B3.6090100@pobox.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, Aaron Lu <aaron.lwe@gmail.com>, Jeff Wu <jeff.wu@amd.com>, Tejun Heo <tj@kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>

We need to do different things for system PM and runtime PM, e.g. we do
not need to enable runtime wake for ZPODD when we are doing system
suspend, etc.

Currently, we use PMSG_SUSPEND for both system suspend and runtime
suspend and PMSG_ON for both system resume and runtime resume. Change
this by using PMSG_AUTO_SUSPEND for runtime suspend and PMSG_AUTO_RESUME
for runtime resume. And since PMSG_ON means no transition, it is changed
to PMSG_RESUME for ata port's system resume.

The ata_acpi_set_state is modified accordingly, and the sata case and
pata case is seperated for easy reading.

Signed-off-by: Aaron Lu <aaron.lu@intel.com>
---
 drivers/ata/libata-acpi.c | 76 +++++++++++++++++++++++++++++++++--------------
 drivers/ata/libata-core.c | 29 ++++++++++++------
 drivers/ata/libata-eh.c   | 17 ++++++-----
 3 files changed, 83 insertions(+), 39 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 9709449..dfd529a 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -836,9 +836,11 @@ void ata_acpi_on_resume(struct ata_port *ap)
 	}
 }
 
-static int ata_acpi_choose_suspend_state(struct ata_device *dev)
+static int ata_acpi_choose_suspend_state(struct ata_device *dev, bool runtime)
 {
 	int d_max_in = ACPI_STATE_D3_COLD;
+	if (!runtime)
+		goto out;
 
 	/*
 	 * For ATAPI, runtime D3 cold is only allowed
@@ -848,53 +850,81 @@ static int ata_acpi_choose_suspend_state(struct ata_device *dev)
 	    !(zpodd_dev_enabled(dev) && zpodd_zpready(dev)))
 		d_max_in = ACPI_STATE_D3_HOT;
 
+out:
 	return acpi_pm_device_sleep_state(&dev->sdev->sdev_gendev,
 					  NULL, d_max_in);
 }
 
-/**
- * ata_acpi_set_state - set the port power state
- * @ap: target ATA port
- * @state: state, on/off
- *
- * This function executes the _PS0/_PS3 ACPI method to set the power state.
- * ACPI spec requires _PS0 when IDE power on and _PS3 when power off
- */
-void ata_acpi_set_state(struct ata_port *ap, pm_message_t state)
+static void sata_acpi_set_state(struct ata_port *ap, pm_message_t state)
 {
+	bool runtime = PMSG_IS_AUTO(state);
 	struct ata_device *dev;
 	acpi_handle handle;
 	int acpi_state;
 
-	/* channel first and then drives for power on and vica versa
-	   for power off */
-	handle = ata_ap_acpi_handle(ap);
-	if (handle && state.event == PM_EVENT_ON)
-		acpi_bus_set_power(handle, ACPI_STATE_D0);
-
 	ata_for_each_dev(dev, &ap->link, ENABLED) {
 		handle = ata_dev_acpi_handle(dev);
 		if (!handle)
 			continue;
 
-		if (state.event != PM_EVENT_ON) {
-			acpi_state = ata_acpi_choose_suspend_state(dev);
+		if (!(state.event & PM_EVENT_RESUME)) {
+			acpi_state = ata_acpi_choose_suspend_state(dev, runtime);
 			if (acpi_state == ACPI_STATE_D0)
 				continue;
-			if (zpodd_dev_enabled(dev) &&
+			if (runtime && zpodd_dev_enabled(dev) &&
 			    acpi_state == ACPI_STATE_D3_COLD)
 				zpodd_enable_run_wake(dev);
 			acpi_bus_set_power(handle, acpi_state);
 		} else {
-			if (zpodd_dev_enabled(dev))
+			if (runtime && zpodd_dev_enabled(dev))
 				zpodd_disable_run_wake(dev);
 			acpi_bus_set_power(handle, ACPI_STATE_D0);
 		}
 	}
+}
+
+/* ACPI spec requires _PS0 when IDE power on and _PS3 when power off */
+static void pata_acpi_set_state(struct ata_port *ap, pm_message_t state)
+{
+	struct ata_device *dev;
+	acpi_handle port_handle;
+
+	port_handle = ata_ap_acpi_handle(ap);
+	if (!port_handle)
+		return;
+
+	/* channel first and then drives for power on and vica versa
+	   for power off */
+	if (state.event & PM_EVENT_RESUME)
+		acpi_bus_set_power(port_handle, ACPI_STATE_D0);
+
+	ata_for_each_dev(dev, &ap->link, ENABLED) {
+		acpi_handle dev_handle = ata_dev_acpi_handle(dev);
+		if (!dev_handle)
+			continue;
+
+		acpi_bus_set_power(dev_handle, state.event & PM_EVENT_RESUME ?
+						ACPI_STATE_D0 : ACPI_STATE_D3);
+	}
+
+	if (!(state.event & PM_EVENT_RESUME))
+		acpi_bus_set_power(port_handle, ACPI_STATE_D3);
+}
 
-	handle = ata_ap_acpi_handle(ap);
-	if (handle && state.event != PM_EVENT_ON)
-		acpi_bus_set_power(handle, ACPI_STATE_D3);
+/**
+ * ata_acpi_set_state - set the port power state
+ * @ap: target ATA port
+ * @state: state, on/off
+ *
+ * This function sets a proper ACPI D state for the device on
+ * system and runtime PM operations.
+ */
+void ata_acpi_set_state(struct ata_port *ap, pm_message_t state)
+{
+	if (ap->flags & ATA_FLAG_ACPI_SATA)
+		sata_acpi_set_state(ap, state);
+	else
+		pata_acpi_set_state(ap, state);
 }
 
 /**
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index b7eed82..6a5ef86 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -5345,7 +5345,7 @@ static int __ata_port_suspend_common(struct ata_port *ap, pm_message_t mesg, int
 	 *
 	 * http://thread.gmane.org/gmane.linux.ide/46764
 	 */
-	if (mesg.event == PM_EVENT_SUSPEND)
+	if (mesg.event & PM_EVENT_SUSPEND)
 		ehi_flags |= ATA_EHI_NO_AUTOPSY | ATA_EHI_NO_RECOVERY;
 
 	rc = ata_port_request_pm(ap, mesg, 0, ehi_flags, async);
@@ -5383,27 +5383,28 @@ static int ata_port_poweroff(struct device *dev)
 	return ata_port_suspend_common(dev, PMSG_HIBERNATE);
 }
 
-static int __ata_port_resume_common(struct ata_port *ap, int *async)
+static int __ata_port_resume_common(struct ata_port *ap, pm_message_t mesg,
+				    int *async)
 {
 	int rc;
 
-	rc = ata_port_request_pm(ap, PMSG_ON, ATA_EH_RESET,
+	rc = ata_port_request_pm(ap, mesg, ATA_EH_RESET,
 		ATA_EHI_NO_AUTOPSY | ATA_EHI_QUIET, async);
 	return rc;
 }
 
-static int ata_port_resume_common(struct device *dev)
+static int ata_port_resume_common(struct device *dev, pm_message_t mesg)
 {
 	struct ata_port *ap = to_ata_port(dev);
 
-	return __ata_port_resume_common(ap, NULL);
+	return __ata_port_resume_common(ap, mesg, NULL);
 }
 
 static int ata_port_resume(struct device *dev)
 {
 	int rc;
 
-	rc = ata_port_resume_common(dev);
+	rc = ata_port_resume_common(dev, PMSG_RESUME);
 	if (!rc) {
 		pm_runtime_disable(dev);
 		pm_runtime_set_active(dev);
@@ -5437,6 +5438,16 @@ static int ata_port_runtime_idle(struct device *dev)
 	return pm_runtime_suspend(dev);
 }
 
+static int ata_port_runtime_suspend(struct device *dev)
+{
+	return ata_port_suspend_common(dev, PMSG_AUTO_SUSPEND);
+}
+
+static int ata_port_runtime_resume(struct device *dev)
+{
+	return ata_port_resume_common(dev, PMSG_AUTO_RESUME);
+}
+
 static const struct dev_pm_ops ata_port_pm_ops = {
 	.suspend = ata_port_suspend,
 	.resume = ata_port_resume,
@@ -5445,8 +5456,8 @@ static const struct dev_pm_ops ata_port_pm_ops = {
 	.poweroff = ata_port_poweroff,
 	.restore = ata_port_resume,
 
-	.runtime_suspend = ata_port_suspend,
-	.runtime_resume = ata_port_resume_common,
+	.runtime_suspend = ata_port_runtime_suspend,
+	.runtime_resume = ata_port_runtime_resume,
 	.runtime_idle = ata_port_runtime_idle,
 };
 
@@ -5463,7 +5474,7 @@ EXPORT_SYMBOL_GPL(ata_sas_port_async_suspend);
 
 int ata_sas_port_async_resume(struct ata_port *ap, int *async)
 {
-	return __ata_port_resume_common(ap, async);
+	return __ata_port_resume_common(ap, PMSG_RESUME, async);
 }
 EXPORT_SYMBOL_GPL(ata_sas_port_async_resume);
 
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 50f3ef0..f9476fb 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -4029,7 +4029,7 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
 	/* are we suspending? */
 	spin_lock_irqsave(ap->lock, flags);
 	if (!(ap->pflags & ATA_PFLAG_PM_PENDING) ||
-	    ap->pm_mesg.event == PM_EVENT_ON) {
+	    ap->pm_mesg.event & PM_EVENT_RESUME) {
 		spin_unlock_irqrestore(ap->lock, flags);
 		return;
 	}
@@ -4040,10 +4040,13 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
 	/*
 	 * If we have a ZPODD attached, check its zero
 	 * power ready status before the port is frozen.
+	 * Only needed for runtime suspend.
 	 */
-	ata_for_each_dev(dev, &ap->link, ENABLED) {
-		if (zpodd_dev_enabled(dev))
-			zpodd_on_suspend(dev);
+	if (PMSG_IS_AUTO(ap->pm_mesg)) {
+		ata_for_each_dev(dev, &ap->link, ENABLED) {
+			if (zpodd_dev_enabled(dev))
+				zpodd_on_suspend(dev);
+		}
 	}
 
 	/* tell ACPI we're suspending */
@@ -4057,7 +4060,7 @@ static void ata_eh_handle_port_suspend(struct ata_port *ap)
 	if (ap->ops->port_suspend)
 		rc = ap->ops->port_suspend(ap, ap->pm_mesg);
 
-	ata_acpi_set_state(ap, PMSG_SUSPEND);
+	ata_acpi_set_state(ap, ap->pm_mesg);
  out:
 	/* report result */
 	spin_lock_irqsave(ap->lock, flags);
@@ -4097,7 +4100,7 @@ static void ata_eh_handle_port_resume(struct ata_port *ap)
 	/* are we resuming? */
 	spin_lock_irqsave(ap->lock, flags);
 	if (!(ap->pflags & ATA_PFLAG_PM_PENDING) ||
-	    ap->pm_mesg.event != PM_EVENT_ON) {
+	    !(ap->pm_mesg.event & PM_EVENT_RESUME)) {
 		spin_unlock_irqrestore(ap->lock, flags);
 		return;
 	}
@@ -4116,7 +4119,7 @@ static void ata_eh_handle_port_resume(struct ata_port *ap)
 		ata_for_each_dev(dev, link, ALL)
 			ata_ering_clear(&dev->ering);
 
-	ata_acpi_set_state(ap, PMSG_ON);
+	ata_acpi_set_state(ap, ap->pm_mesg);
 
 	if (ap->ops->port_resume)
 		rc = ap->ops->port_resume(ap);
-- 
1.8.1

