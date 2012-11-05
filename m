From: Huang Ying <ying.huang@intel.com>
Subject: [BUGFIX] PM: Fix active child counting when disabled and forbidden
Date: Mon,  5 Nov 2012 09:17:17 +0800
Message-ID: <1352078237-20622-1-git-send-email-ying.huang@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:3440 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751147Ab2KEBRZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 4 Nov 2012 20:17:25 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Huang Ying <ying.huang@intel.com>

In current runtime PM implementation, the active child count of the
parent device may be decreased if the runtime PM of the child device
is disabled and forbidden.  For example, to unbind a PCI driver with a
PCI device, the following code path is possible:

  pci_device_remove
    pm_runtime_set_suspended
      __pm_runtime_set_status
        atomic_add_unless(&parent->power.child_count, -1, 0)

That is, the parent device may be suspended, even if the runtime PM of
child device is forbidden to be suspended.  This violate the rule that
parent is allowed to be suspended only after all its children are
suspended, and may cause issue.

This issue is fixed via checking the usage count of the child device
because if the runtime PM of the child device is forbidden, the
usage_count of the child device will be non-zero.

Signed-off-by: Huang Ying <ying.huang@intel.com>
---
 drivers/base/power/runtime.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -916,7 +916,7 @@ int __pm_runtime_set_status(struct devic
 
 	if (status == RPM_SUSPENDED) {
 		/* It always is possible to set the status to 'suspended'. */
-		if (parent) {
+		if (parent && atomic_read(&dev->power.usage_count) == 0) {
 			atomic_add_unless(&parent->power.child_count, -1, 0);
 			notify_parent = !parent->power.ignore_children;
 		}
