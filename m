From: Adam Belay <abelay@novell.com>
Subject: [RFC][PATCH 5/6] PCI PM: kzalloc() cleanup
Date: Tue, 15 Nov 2005 22:31:31 -0500
Message-ID: <1132111891.9809.57.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965210AbVKPDWy@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux-pm mailing list <linux-pm@lists.osdl.org>, Greg KH <gregkh@suse.de>
Cc: linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Use kzalloc() instead of kmalloc() and memset().


--- a/drivers/pci/pm.c	2005-11-08 17:10:37.000000000 -0500
+++ b/drivers/pci/pm.c	2005-11-08 17:11:33.000000000 -0500
@@ -300,12 +300,10 @@
 		return -EIO;
 	}
 
-	dev->pm = pm_data = kmalloc(sizeof(struct pci_dev_pm), GFP_KERNEL);
+	dev->pm = pm_data = kzalloc(sizeof(struct pci_dev_pm), GFP_KERNEL);
 	if (!pm_data)
 		return -ENOMEM;
 
-	memset(pm_data, 0, sizeof(struct pci_dev_pm));
-
 	pm_data->pm_offset = pm;
 
 	/* determine supported device states */
