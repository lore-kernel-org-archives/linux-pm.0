From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] USB: hcd: Mark secondary HCD as dead if the primary one died
Date: Tue, 25 Jul 2017 23:58:50 +0200
Message-ID: <2812577.lIftRZubdO@aspire.rjw.lan>
References: <5273465.xcnvLcBNTW@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5273465.xcnvLcBNTW@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux USB <linux-usb@vger.kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mathias Nyman <mathias.nyman@linux.intel.com>, Felipe Balbi <balbi@kernel.org>
List-Id: linux-pm@vger.kernel.org

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Make usb_hc_died() clear the HCD_FLAG_RH_RUNNING flag for the shared
HCD and set HCD_FLAG_DEAD for it, in analogy with what is done for
the primary one.

Among other thigs, this prevents check_root_hub_suspended() from
returning -EBUSY for dead HCDs which helps to work around system
suspend issues in some situations.

This actually fixes occasional suspend failures on one of my test
machines.

Suggested-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/usb/core/hcd.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-pm/drivers/usb/core/hcd.c
===================================================================
--- linux-pm.orig/drivers/usb/core/hcd.c
+++ linux-pm/drivers/usb/core/hcd.c
@@ -2485,6 +2485,8 @@ void usb_hc_died (struct usb_hcd *hcd)
 	}
 	if (usb_hcd_is_primary_hcd(hcd) && hcd->shared_hcd) {
 		hcd = hcd->shared_hcd;
+		clear_bit(HCD_FLAG_RH_RUNNING, &hcd->flags);
+		set_bit(HCD_FLAG_DEAD, &hcd->flags);
 		if (hcd->rh_registered) {
 			clear_bit(HCD_FLAG_POLL_RH, &hcd->flags);
 
