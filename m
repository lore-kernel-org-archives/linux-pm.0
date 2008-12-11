From: Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH] PCI: fix incorrect error return in
	pci_enable_wake
Date: Thu, 11 Dec 2008 15:11:39 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0812111510160.15474-100000__37000.8415928625$1229026453$gmane$org@iolanthe.rowland.org>
References: <200812112058.08927.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812112058.08927.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>, Greg KH <greg@kroah.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

This patch (as1186) fixes a minor mistake in pci_enable_wake().  When
the routine is asked to disable remote wakeup, it should not return an
error merely because the device is not allowed to do wakeups!

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>

---

Index: usb-2.6/drivers/pci/pci.c
===================================================================
--- usb-2.6.orig/drivers/pci/pci.c
+++ usb-2.6/drivers/pci/pci.c
@@ -1107,7 +1107,7 @@ int pci_enable_wake(struct pci_dev *dev,
 	int error = 0;
 	bool pme_done = false;
 
-	if (!device_may_wakeup(&dev->dev))
+	if (enable && !device_may_wakeup(&dev->dev))
 		return -EINVAL;
 
 	/*
