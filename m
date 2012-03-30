From: Len Brown <lenb@kernel.org>
Subject: [PATCH 19/76] thermal/spear_thermal: replace readl/writel with lighter
 _relaxed variants
Date: Fri, 30 Mar 2012 06:13:22 -0400
Message-ID: <de716e32e61fae5d1f0d000008d3f641cec5c9dd.1333101989.git.len.brown@intel.com>
References: <1333102459-23750-1-git-send-email-lenb@kernel.org>
Reply-To: Len Brown <lenb@kernel.org>
Return-path: <linux-acpi-owner@vger.kernel.org>
In-reply-to: <1333102459-23750-1-git-send-email-lenb@kernel.org>
In-reply-to: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
References: <09f98a825a821f7a3f1b162f9ed023f37213a63b.1333101989.git.len.brown@intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@st.com>, Andrew Morton <akpm@linux-foundation.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Viresh Kumar <viresh.kumar@st.com>

readl/writel versions for ARM contain memory barrier instruction for
synchronizing DMA buffers.  These are not required at least on this
module.  So use lighter _relaxed variants.

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Len Brown <len.brown@intel.com>
---
 drivers/thermal/spear_thermal.c |   16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/thermal/spear_thermal.c b/drivers/thermal/spear_thermal.c
index 880bf28..be94413 100644
--- a/drivers/thermal/spear_thermal.c
+++ b/drivers/thermal/spear_thermal.c
@@ -46,7 +46,7 @@ static inline int thermal_get_temp(struct thermal_zone_device *thermal,
 	 * Data are ready to be read after 628 usec from POWERDOWN signal
 	 * (PDN) = 1
 	 */
-	*temp = (readl(stdev->thermal_base) & 0x7F) * MD_FACTOR;
+	*temp = (readl_relaxed(stdev->thermal_base) & 0x7F) * MD_FACTOR;
 	return 0;
 }
 
@@ -63,8 +63,8 @@ static int spear_thermal_suspend(struct device *dev)
 	unsigned int actual_mask = 0;
 
 	/* Disable SPEAr Thermal Sensor */
-	actual_mask = readl(stdev->thermal_base);
-	writel(actual_mask & ~stdev->flags, stdev->thermal_base);
+	actual_mask = readl_relaxed(stdev->thermal_base);
+	writel_relaxed(actual_mask & ~stdev->flags, stdev->thermal_base);
 
 	clk_disable(stdev->clk);
 	dev_info(dev, "Suspended.\n");
@@ -87,8 +87,8 @@ static int spear_thermal_resume(struct device *dev)
 	}
 
 	/* Enable SPEAr Thermal Sensor */
-	actual_mask = readl(stdev->thermal_base);
-	writel(actual_mask | stdev->flags, stdev->thermal_base);
+	actual_mask = readl_relaxed(stdev->thermal_base);
+	writel_relaxed(actual_mask | stdev->flags, stdev->thermal_base);
 
 	dev_info(dev, "Resumed.\n");
 
@@ -145,7 +145,7 @@ static int spear_thermal_probe(struct platform_device *pdev)
 	}
 
 	stdev->flags = pdata->thermal_flags;
-	writel(stdev->flags, stdev->thermal_base);
+	writel_relaxed(stdev->flags, stdev->thermal_base);
 
 	spear_thermal = thermal_zone_device_register("spear_thermal", 0,
 				stdev, &ops, 0, 0, 0, 0);
@@ -180,8 +180,8 @@ static int spear_thermal_exit(struct platform_device *pdev)
 	platform_set_drvdata(pdev, NULL);
 
 	/* Disable SPEAr Thermal Sensor */
-	actual_mask = readl(stdev->thermal_base);
-	writel(actual_mask & ~stdev->flags, stdev->thermal_base);
+	actual_mask = readl_relaxed(stdev->thermal_base);
+	writel_relaxed(actual_mask & ~stdev->flags, stdev->thermal_base);
 
 	clk_disable(stdev->clk);
 	clk_put(stdev->clk);
-- 
1.7.10.rc2.19.gfae9d

