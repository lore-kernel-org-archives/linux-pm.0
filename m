From: Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH v2 0/2] pinctrl: Allow indicating loss of state across
 suspend/resume
Date: Tue, 7 Nov 2017 08:00:06 -0800
Message-ID: <20171107160006.GQ28152@atomide.com>
References: <20171102231551.16220-1-f.fainelli@gmail.com>
 <da808465-dc64-6c33-0be6-e038e0f84bce@gmail.com>
 <20171103173353.GJ28152@atomide.com>
 <2452741.VnAOAIxsj2@aspire.rjw.lan>
 <7091cb38-e55b-fa20-114e-bd77950ea912@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from muru.com ([72.249.23.125]:47070 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751031AbdKGQAM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 7 Nov 2017 11:00:12 -0500
Content-Disposition: inline
In-Reply-To: <7091cb38-e55b-fa20-114e-bd77950ea912@gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Charles Keepax <ckeepax@opensource.cirrus.com>, linux-gpio@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, ckeepax@opensource.wolfsonmicro.com, swarren@nvidia.com, andy.shevchenko@gmail.com, alcooperx@gmail.com, bcm-kernel-feedback-list@broadcom.com, linux-pm@vger.kernel.org

* Florian Fainelli <f.fainelli@gmail.com> [171104 17:21]:
> 
> 
> On 11/04/2017 05:25 AM, Rafael J. Wysocki wrote:
> > On Friday, November 3, 2017 6:33:53 PM CET Tony Lindgren wrote:
> >> * Florian Fainelli <f.fainelli@gmail.com> [171103 17:04]:
> >>> On 11/03/2017 09:11 AM, Tony Lindgren wrote:
> >>> The pinctrl provider is losing its state, hence these two patches.
> >>
> >> OK
> >>
> >>>> Anyways, the context lost flag should be managed in the PM core for
> >>>> the device, so adding linux-pm and Rafael to Cc.
> >>>
> >>> I don't think it's that simple but sure, why not.
> >>
> >> Just having bool context_lost in struct dev_pm_info would probably
> >> be enough to allow drivers to deal with it. This flag could then
> >> be set for a device by power domain related code that knows if
> >> context got lost.
> > 
> > Something like: if the driver sees "context_lost" set, it should restore
> > the context to the device from memory?
> 
> That is what is being proposed here, except that the actual mechanism
> where this matters needs to be in the core pinctrl code, otherwise the
> state (context) is not restored due to a check that attempts not to
> (re)apply a previous state.
> 
> > 
> > But the it would also need to save the context beforehand, so why not to
> > restore it unconditionally on resume?
> 
> That's what my original attempts did here:
> 
> https://patchwork.kernel.org/patch/9598969/
> 
> but Linus rightfully requested this to be done differently, hence this
> attempt now to solve it in a slightly more flexible way based on DT
> properties.

For runtime PM, restoring the state constantly is unnecessary and not
good for battery life. The logic can be just:

1. Device driver runtime PM suspend saves the state when needed

2. Device driver runtime PM resume checks if context_lost was set by
   the bus or power domain code

3. If context was lost, device driver restores the state, or in some
   cases may need re-run the driver register init related parts
   to bring the driver back up, then clears the context_lost flag

How about something like the following patch? So far only compile
tested with CONFIG_PM enabled. If that looks like the way to go,
I'll test it properly and add some comments for the functions and
post a proper patch :)

Regards,

Tony

8< ----------------------
>From tony Mon Sep 17 00:00:00 2001
From: Tony Lindgren <tony@atomide.com>
Date: Mon, 6 Nov 2017 07:02:54 -0800
Subject: [PATCH] RFC: PM / context: Add support for context lost handling

On some hardware device drivers can lose their context in deeper
idle states when the power is cut off for some power domain.

As the drivers themselves may not be aware if the context was lost
without reinitializing the device, we want to provide few helpers
for tracking if device context was lost in a generic way.

Typically the interconnect or power domain hardware knows when
context was lost and we can set up a function for the consumer
drivers to query the context lost state.

The helpers for context lost that can be used in the following way:

1. Power domain or interconnect code registers a callback function
   with for a device

   error = dev_pm_register_context_lost_handler(dev, cb, data);
   if (error)
   	...

2. A consumer device driver saves it's state as needed in suspend
   or runtime PM suspend

3. A power domain is powered off during idle, and context is lost
   for all the devices in that power domain

4. On resume or runtime PM resume, a device driver queries the
   context lost state and restores the context if needed

   error = dev_pm_update_context_lost(dev);
   if (error)
   	...

   if (dev_pm_was_context_lost(dev))
	restore_context(ddata);

REVISIT: Compile tested only, needs testing and comments

Not-Yet-Signed-off-by: Tony Lindgren <tony@atomide.com>
---
 drivers/base/power/Makefile  |  1 +
 drivers/base/power/context.c | 84 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/base/power/power.h   |  6 ++++
 include/linux/pm.h           |  1 +
 include/linux/pm_context.h   | 51 +++++++++++++++++++++++++++
 5 files changed, 143 insertions(+)
 create mode 100644 drivers/base/power/context.c
 create mode 100644 include/linux/pm_context.h

diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -1,5 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o qos.o runtime.o wakeirq.o
+obj-$(CONFIG_PM)	+= context.o
 obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
 obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
diff --git a/drivers/base/power/context.c b/drivers/base/power/context.c
new file mode 100644
--- /dev/null
+++ b/drivers/base/power/context.c
@@ -0,0 +1,84 @@
+/*
+ * context.c - Device context lost helper functions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#include <linux/device.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/slab.h>
+#include <linux/pm_runtime.h>
+#include <linux/pm_context.h>
+
+#include "power.h"
+
+bool dev_pm_was_context_lost(struct device *dev)
+{
+	struct context_lost *ctx = dev->power.context_lost;
+	unsigned long flags;
+
+	if (!dev || !ctx)
+		return false;
+
+	spin_lock_irqsave(&dev->power.lock, flags);
+	if (ctx->cb)
+		ctx->lost = ctx->cb(dev, ctx->data);
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+
+	return ctx->lost;
+}
+EXPORT_SYMBOL_GPL(dev_pm_was_context_lost);
+
+int dev_pm_register_context_lost_handler(struct device *dev,
+					 bool (*cb)(struct device *dev,
+						    void *data),
+					 void *data)
+{
+	struct context_lost *ctx = dev->power.context_lost;
+	unsigned long flags;
+
+	if (!dev || !cb)
+		return -EINVAL;
+
+	if (ctx)
+		return -EEXIST;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+
+	ctx->data = data;
+	ctx->cb = cb;
+
+	spin_lock_irqsave(&dev->power.lock, flags);
+	dev->power.context_lost = ctx;
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pm_register_context_lost_handler);
+
+int dev_pm_unregister_context_lost_handler(struct device *dev)
+{
+	struct context_lost *ctx = dev->power.context_lost;
+	unsigned long flags;
+
+	if (!ctx)
+		return -ENODEV;
+
+	spin_lock_irqsave(&dev->power.lock, flags);
+	dev->power.context_lost = NULL;
+	spin_unlock_irqrestore(&dev->power.lock, flags);
+	kfree(ctx);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(dev_pm_unregister_context_lost_handler);
diff --git a/drivers/base/power/power.h b/drivers/base/power/power.h
--- a/drivers/base/power/power.h
+++ b/drivers/base/power/power.h
@@ -39,6 +39,12 @@ extern void dev_pm_enable_wake_irq_check(struct device *dev,
 					 bool can_change_status);
 extern void dev_pm_disable_wake_irq_check(struct device *dev);
 
+struct context_lost {
+	bool lost;
+	bool (*cb)(struct device *dev, void *data);
+	void *data;
+};
+
 #ifdef CONFIG_PM_SLEEP
 
 extern int device_wakeup_attach_irq(struct device *dev,
diff --git a/include/linux/pm.h b/include/linux/pm.h
--- a/include/linux/pm.h
+++ b/include/linux/pm.h
@@ -606,6 +606,7 @@ struct dev_pm_info {
 	struct work_struct	work;
 	wait_queue_head_t	wait_queue;
 	struct wake_irq		*wakeirq;
+	struct context_lost	*context_lost;
 	atomic_t		usage_count;
 	atomic_t		child_count;
 	unsigned int		disable_depth:3;
diff --git a/include/linux/pm_context.h b/include/linux/pm_context.h
new file mode 100644
--- /dev/null
+++ b/include/linux/pm_context.h
@@ -0,0 +1,51 @@
+/*
+ * pm_context.h - Device context lost helper functions
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed "as is" WITHOUT ANY WARRANTY of any
+ * kind, whether express or implied; without even the implied warranty
+ * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ */
+
+#ifndef _LINUX_PM_CONTEXT_H
+#define _LINUX_PM_CONTEXT_H
+
+#ifdef CONFIG_PM
+
+extern bool dev_pm_was_context_lost(struct device *dev);
+
+extern int
+dev_pm_register_context_lost_handler(struct device *dev,
+				     bool (*cb)(struct device *dev,
+						void *data),
+				     void *data);
+
+extern int dev_pm_unregister_context_lost_handler(struct device *dev);
+
+#else	/* !CONFIG_PM */
+
+static inline bool dev_pm_was_context_lost(struct device *dev)
+{
+	return false;
+}
+
+static inline int
+dev_pm_register_context_lost_handler(struct device *dev,
+				     bool (*cb)(struct device *dev,
+						void *data),
+				     void *data);
+{
+	return -ENODEV;
+}
+
+static inline int dev_pm_unregister_context_lost_handler(struct device *dev)
+{
+	return -ENODEV;
+}
+
+#endif	/* CONFIG_PM */
+#endif	/* _LINUX_PM_CONTEXT_H */
-- 
2.15.0
