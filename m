From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] PCI: fix incorrect error return in
	pci_enable_wake
Date: Tue, 16 Dec 2008 14:06:58 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0812161404580.6238-100000__30671.873156871$1229454602$gmane$org@iolanthe.rowland.org>
References: <200812161043.53756.jbarnes@virtuousgeek.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812161043.53756.jbarnes@virtuousgeek.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jesse Barnes <jbarnes@virtuousgeek.org>
Cc: Greg KH <greg@kroah.com>, pm list <linux-pm@lists.linux-foundation.org>, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

This patch (as1186) fixes a minor mistake in pci_enable_wake().  When
the routine is asked to disable remote wakeup, it should not return an
error merely because the device is not allowed to do wakeups!

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Acked-by: Rafael J. Wysocki <rjw@sisk.pl>

---
On Tue, 16 Dec 2008, Jesse Barnes wrote:

> I lost the original of this one.  Alan can you resend to me with Rafael's ack?

Here you go.

Alan Stern



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
