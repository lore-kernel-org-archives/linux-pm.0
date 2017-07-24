From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / USB: hcd_pci: Skip secondary root hub check for HCD_DEAD()
Date: Tue, 25 Jul 2017 01:04:01 +0200
Message-ID: <5273465.xcnvLcBNTW@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:41850 "EHLO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753676AbdGXXL6 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 24 Jul 2017 19:11:58 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux USB <linux-usb@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mathias Nyman <mathias.nyman@linux.intel.com>, Felipe Balbi <balbi@kernel.org>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

If HCD_DEAD(hcd) is "true" in check_root_hub_suspended(), it is
rather pointless to check the secondary root hub, so return early
then.

This actually fixes occasional suspend failures on one of my test
machines.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/usb/core/hcd-pci.c |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-pm/drivers/usb/core/hcd-pci.c
===================================================================
--- linux-pm.orig/drivers/usb/core/hcd-pci.c
+++ linux-pm/drivers/usb/core/hcd-pci.c
@@ -427,6 +427,9 @@ static int check_root_hub_suspended(stru
 		dev_warn(dev, "Root hub is not suspended\n");
 		return -EBUSY;
 	}
+	if (HCD_DEAD(hcd))
+		return 0;
+
 	if (hcd->shared_hcd) {
 		hcd = hcd->shared_hcd;
 		if (HCD_RH_RUNNING(hcd)) {
