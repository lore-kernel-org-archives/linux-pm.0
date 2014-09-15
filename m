From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH v3 1/4] PM / Runtime: Add getter for quering the IRQ safe option
Date: Mon, 15 Sep 2014 12:13:50 +0200
Message-ID: <1410776033-22156-2-git-send-email-k.kozlowski@samsung.com>
References: <1410776033-22156-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:62688 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753737AbaIOKOi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Sep 2014 06:14:38 -0400
In-reply-to: <1410776033-22156-1-git-send-email-k.kozlowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King <linux@arm.linux.org.uk>, Dan Williams <dan.j.williams@intel.com>, Vinod Koul <vinod.koul@intel.com>, linux-kernel@vger.kernel.org, dmaengine@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>, Grant Likely <grant.likely@linaro.org>, Lars-Peter Clausen <lars@metafoo.de>, Michal Simek <michal.simek@xilinx.com>, linux-pm@vger.kernel.org
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Marek Szyprowski <m.szyprowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>

Add a simple getter pm_runtime_is_irq_safe() for quering whether runtime
PM IRQ safe was set or not.

Various bus drivers implementing runtime PM may use choose to suspend
differently based on IRQ safeness status of child driver (e.g. do not
unprepare the clock if IRQ safe is not set).

Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
---
 include/linux/pm_runtime.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
index 367f49b9a1c9..44d74f0f182e 100644
--- a/include/linux/pm_runtime.h
+++ b/include/linux/pm_runtime.h
@@ -128,6 +128,11 @@ static inline void pm_runtime_mark_last_busy(struct device *dev)
 	ACCESS_ONCE(dev->power.last_busy) = jiffies;
 }
 
+static inline bool pm_runtime_is_irq_safe(struct device *dev)
+{
+	return dev->power.irq_safe;
+}
+
 #else /* !CONFIG_PM_RUNTIME */
 
 static inline int __pm_runtime_idle(struct device *dev, int rpmflags)
@@ -167,6 +172,7 @@ static inline bool pm_runtime_enabled(struct device *dev) { return false; }
 
 static inline void pm_runtime_no_callbacks(struct device *dev) {}
 static inline void pm_runtime_irq_safe(struct device *dev) {}
+static inline bool pm_runtime_is_irq_safe(struct device *dev) { return false; }
 
 static inline bool pm_runtime_callbacks_present(struct device *dev) { return false; }
 static inline void pm_runtime_mark_last_busy(struct device *dev) {}
-- 
1.9.1

