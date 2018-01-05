From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH] PM / wakeup: Do not fail dev_pm_attach_wake_irq() unnecessarily
Date: Fri, 05 Jan 2018 01:14:04 +0100
Message-ID: <1542734.kK7NjWylRh@aspire.rjw.lan>
References: <20171225114742.18920-1-jeffy.chen@rock-chips.com> <20171228165134.GH3875@atomide.com> <6120485.xubBpvge6h@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.pl ([79.96.170.134]:54999 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751108AbeAEAPM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Jan 2018 19:15:12 -0500
In-Reply-To: <6120485.xubBpvge6h@aspire.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>
Cc: Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael@kernel.org>, JeffyChen <jeffy.chen@rock-chips.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, Shawn Lin <shawn.lin@rock-chips.com>, Brian Norris <briannorris@chromium.org>, Doug Anderson <dianders@chromium.org>, Rob Herring <robh+dt@kernel.org>, Frank Rowand <frowand.list@gmail.com>

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Returning an error code from dev_pm_attach_wake_irq() if
device_wakeup_attach_irq() called by it returns an error is
pointless, because the wakeup source used by it may be deleted
by user space via sysfs at any time and in particular right after
dev_pm_attach_wake_irq() has returned.  Moreover, it requires
the callers of dev_pm_attach_wake_irq() to create that wakeup
source via device_wakeup_enable() upfront, but that obviously is
racy with respect to the sysfs-based manipulations of it.

To avoid the race, modify dev_pm_attach_wake_irq() to simply call
device_wakeup_attach_irq() after checking that the wakeup source it
is going to use is there (in which case it cannot fail) and set the
power.wakeirq field for the device unconditionally.

Tested-by: Tony Lindgren <tony@atomide.com>
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/base/power/wakeirq.c |    9 ++++-----
 drivers/base/power/wakeup.c  |    2 +-
 2 files changed, 5 insertions(+), 6 deletions(-)

Index: linux-pm/drivers/base/power/wakeirq.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeirq.c
+++ linux-pm/drivers/base/power/wakeirq.c
@@ -33,7 +33,6 @@ static int dev_pm_attach_wake_irq(struct
 				  struct wake_irq *wirq)
 {
 	unsigned long flags;
-	int err;
 
 	if (!dev || !wirq)
 		return -EINVAL;
@@ -45,12 +44,12 @@ static int dev_pm_attach_wake_irq(struct
 		return -EEXIST;
 	}
 
-	err = device_wakeup_attach_irq(dev, wirq);
-	if (!err)
-		dev->power.wakeirq = wirq;
+	dev->power.wakeirq = wirq;
+	if (dev->power.wakeup)
+		device_wakeup_attach_irq(dev, wirq);
 
 	spin_unlock_irqrestore(&dev->power.lock, flags);
-	return err;
+	return 0;
 }
 
 /**
Index: linux-pm/drivers/base/power/wakeup.c
===================================================================
--- linux-pm.orig/drivers/base/power/wakeup.c
+++ linux-pm/drivers/base/power/wakeup.c
@@ -303,7 +303,7 @@ int device_wakeup_attach_irq(struct devi
 	}
 
 	if (ws->wakeirq)
-		return -EEXIST;
+		dev_err(dev, "Leftover wakeup IRQ found, overriding\n");
 
 	ws->wakeirq = wakeirq;
 	return 0;
