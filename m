From: Karol Wrona <k.wrona@samsung.com>
Subject: [RFC PATCH 1/1] PM / domains: Add support for virtual power domains
Date: Thu, 29 Jan 2015 19:12:56 +0100
Message-ID: <1422555176-13054-2-git-send-email-k.wrona@samsung.com>
References: <1422555176-13054-1-git-send-email-k.wrona@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1422555176-13054-1-git-send-email-k.wrona@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Karol Wrona <wrona.vy@gmail.com>, Karol Wrona <k.wrona@samsung.com>
List-Id: linux-pm@vger.kernel.org

There are the power domains which are turned off or put to retention only during
suspend or special processor states.  In such case there is a need to register
some devices which belong to such domain that PM core could know the state of
such devices and decide which power mode should be chosen i.e. the domain can
not be put to retention if some devices are active.  Virtual power domain has
empty power_on/off callbacks as there is no need to gate anything.

Signed-off-by: Karol Wrona <k.wrona@samsung.com>
---
 drivers/base/power/Makefile          |    3 +-
 drivers/base/power/pm_domains_virt.c |   54 ++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 drivers/base/power/pm_domains_virt.c

diff --git a/drivers/base/power/Makefile b/drivers/base/power/Makefile
index 1cb8544..360a0e2 100644
--- a/drivers/base/power/Makefile
+++ b/drivers/base/power/Makefile
@@ -2,7 +2,8 @@ obj-$(CONFIG_PM)	+= sysfs.o generic_ops.o common.o qos.o runtime.o
 obj-$(CONFIG_PM_SLEEP)	+= main.o wakeup.o
 obj-$(CONFIG_PM_TRACE_RTC)	+= trace.o
 obj-$(CONFIG_PM_OPP)	+= opp.o
-obj-$(CONFIG_PM_GENERIC_DOMAINS)	+=  domain.o domain_governor.o
+obj-$(CONFIG_PM_GENERIC_DOMAINS)	+= domain.o domain_governor.o \
+					   pm_domains_virt.o
 obj-$(CONFIG_HAVE_CLK)	+= clock_ops.o
 
 ccflags-$(CONFIG_DEBUG_DRIVER) := -DDEBUG
diff --git a/drivers/base/power/pm_domains_virt.c b/drivers/base/power/pm_domains_virt.c
new file mode 100644
index 0000000..bd4d6b6
--- /dev/null
+++ b/drivers/base/power/pm_domains_virt.c
@@ -0,0 +1,54 @@
+/*
+ *  Copyright (C) 2015, Samsung Electronics Co. Ltd. All Rights Reserved.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ */
+
+#include <linux/err.h>
+#include <linux/of.h>
+#include <linux/pm_domain.h>
+#include <linux/slab.h>
+
+static int pd_power_off(struct generic_pm_domain *domain)
+{
+	return 0;
+}
+
+static int pd_power_on(struct generic_pm_domain *domain)
+{
+	return 0;
+}
+
+int __init virt_pm_domains_init(void)
+{
+	struct device_node *np;
+
+	for_each_compatible_node(np, NULL, "linux,virtual-pm-domains") {
+		struct generic_pm_domain *pd;
+
+		pd = kzalloc(sizeof(*pd), GFP_KERNEL);
+		if (!pd)
+			return -ENOMEM;
+
+		pd->power_off = pd_power_off;
+		pd->power_on = pd_power_on;
+		pd->name = kstrdup(np->name, GFP_KERNEL);
+		if (!pd->name)
+			return -ENOMEM;
+
+		pm_genpd_init(pd, NULL, false);
+		of_genpd_add_provider_simple(np, pd);
+	}
+
+	return 0;
+}
+arch_initcall(virt_pm_domains_init);
-- 
1.7.9.5
