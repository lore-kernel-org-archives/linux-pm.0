From: Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: [PATCH 02/12] thermal: qoriq: Remove unnecessary DT node is NULL check
Date: Mon, 18 Feb 2019 11:11:31 -0800
Message-ID: <20190218191141.3729-3-andrew.smirnov@gmail.com>
References: <20190218191141.3729-1-andrew.smirnov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190218191141.3729-1-andrew.smirnov@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, Chris Healy <cphealy@gmail.com>, Lucas Stach <l.stach@pengutronix.de>, Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-imx@nxp.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

This driver is meant to be used with Device Tree and there's no
use-case where device's DT node is going to be NULL. Remove code
protecting against that.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: Chris Healy <cphealy@gmail.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Eduardo Valentin <edubezval@gmail.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-imx@nxp.com
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/thermal/qoriq_thermal.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/thermal/qoriq_thermal.c b/drivers/thermal/qoriq_thermal.c
index 18c711b19514..3e147f856bf5 100644
--- a/drivers/thermal/qoriq_thermal.c
+++ b/drivers/thermal/qoriq_thermal.c
@@ -189,11 +189,6 @@ static int qoriq_tmu_probe(struct platform_device *pdev)
 	struct device_node *np = pdev->dev.of_node;
 	u32 site;
 
-	if (!np) {
-		dev_err(&pdev->dev, "Device OF-Node is NULL");
-		return -ENODEV;
-	}
-
 	data = devm_kzalloc(&pdev->dev, sizeof(struct qoriq_tmu_data),
 			    GFP_KERNEL);
 	if (!data)
-- 
2.20.1
