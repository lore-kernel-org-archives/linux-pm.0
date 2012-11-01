From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: [PATCH] PM / QoS: Document request manipulation requirement for flags
Date: Fri, 02 Nov 2012 00:21:17 +0100
Message-ID: <2507540.LQJMpVROmj@vostro.rjw.lan>
References: <1351766846-24654-1-git-send-email-tianyu.lan@intel.com> <1351766846-24654-2-git-send-email-tianyu.lan@intel.com> <3164424.M2MHcDsd3M@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ogre.sisk.pl ([193.178.161.156]:51462 "EHLO ogre.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552Ab2KAXRK (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 1 Nov 2012 19:17:10 -0400
In-Reply-To: <3164424.M2MHcDsd3M@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lan Tianyu <tianyu.lan@intel.com>, linux-pm@vger.kernel.org
Cc: stern@rowland.harvard.edu, linux-acpi@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

In fact, the callers of dev_pm_qos_add_request(),
dev_pm_qos_update_request() and dev_pm_qos_remove_request() for
requests of type DEV_PM_QOS_FLAGS need to ensure that the target
device is not RPM_SUSPENDED before using any of these functions (or
be prepared for the new PM QoS flags to take effect after the device
has been resumed).  Document this in their kerneldoc comments.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/qos.c |    9 +++++++++
 1 file changed, 9 insertions(+)

Index: linux/drivers/base/power/qos.c
===================================================================
--- linux.orig/drivers/base/power/qos.c
+++ linux/drivers/base/power/qos.c
@@ -277,6 +277,9 @@ void dev_pm_qos_constraints_destroy(stru
  * -EINVAL in case of wrong parameters, -ENOMEM if there's not enough memory
  * to allocate for data structures, -ENODEV if the device has just been removed
  * from the system.
+ *
+ * Callers should ensure that the target device is not RPM_SUSPENDED before
+ * using this function for requests of type DEV_PM_QOS_FLAGS.
  */
 int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_request *req,
 			   enum dev_pm_qos_req_type type, s32 value)
@@ -367,6 +370,9 @@ static int __dev_pm_qos_update_request(s
  * 0 if the aggregated constraint value has not changed,
  * -EINVAL in case of wrong parameters, -ENODEV if the device has been
  * removed from the system
+ *
+ * Callers should ensure that the target device is not RPM_SUSPENDED before
+ * using this function for requests of type DEV_PM_QOS_FLAGS.
  */
 int dev_pm_qos_update_request(struct dev_pm_qos_request *req, s32 new_value)
 {
@@ -398,6 +404,9 @@ EXPORT_SYMBOL_GPL(dev_pm_qos_update_requ
  * 0 if the aggregated constraint value has not changed,
  * -EINVAL in case of wrong parameters, -ENODEV if the device has been
  * removed from the system
+ *
+ * Callers should ensure that the target device is not RPM_SUSPENDED before
+ * using this function for requests of type DEV_PM_QOS_FLAGS.
  */
 int dev_pm_qos_remove_request(struct dev_pm_qos_request *req)
 {


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
