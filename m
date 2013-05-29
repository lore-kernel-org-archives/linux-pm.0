From: Eduardo Valentin <eduardo.valentin@ti.com>
Subject: [PATCH 6/7] thermal: ti-soc-thermal: add dra752 chip to device table
Date: Wed, 29 May 2013 11:07:45 -0400
Message-ID: <1369840066-20357-7-git-send-email-eduardo.valentin@ti.com>
References: <1369840066-20357-1-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1369840066-20357-1-git-send-email-eduardo.valentin@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Eduardo Valentin <eduardo.valentin@ti.com>
List-Id: linux-pm@vger.kernel.org

Add support to TI dra752 chips by adapting the driver
device table.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Eduardo Valentin <eduardo.valentin@ti.com>
---
 drivers/thermal/ti-soc-thermal/ti-bandgap.c | 6 ++++++
 drivers/thermal/ti-soc-thermal/ti-bandgap.h | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.c b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
index f72695f..dea097d 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.c
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.c
@@ -1532,6 +1532,12 @@ static const struct of_device_id of_ti_bandgap_match[] = {
 		.data = (void *)&omap5430_data,
 	},
 #endif
+#ifdef CONFIG_DRA752_THERMAL
+	{
+		.compatible = "ti,dra752-bandgap",
+		.data = (void *)&dra752_data,
+	},
+#endif
 	/* Sentinel */
 	{ },
 };
diff --git a/drivers/thermal/ti-soc-thermal/ti-bandgap.h b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
index 5f4794a..b3adf72 100644
--- a/drivers/thermal/ti-soc-thermal/ti-bandgap.h
+++ b/drivers/thermal/ti-soc-thermal/ti-bandgap.h
@@ -400,4 +400,9 @@ extern const struct ti_bandgap_data omap5430_data;
 #define omap5430_data					NULL
 #endif
 
+#ifdef CONFIG_DRA752_THERMAL
+extern const struct ti_bandgap_data dra752_data;
+#else
+#define dra752_data					NULL
+#endif
 #endif
-- 
1.8.2.1.342.gfa7285d
