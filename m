From: Anson Huang <Anson.Huang@nxp.com>
Subject: [PATCH 1/2] thermal: imx: improve error message
Date: Thu, 13 Sep 2018 17:13:05 +0800
Message-ID: <1536829986-23702-1-git-send-email-Anson.Huang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: rui.zhang@intel.com, edubezval@gmail.com, daniel.lezcano@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Remove the duplicated "from" to improve the error message.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
 drivers/thermal/imx_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index aa452ac..6cfa2a8 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -725,7 +725,7 @@ static int imx_thermal_probe(struct platform_device *pdev)
 	} else {
 		ret = imx_init_from_tempmon_data(pdev);
 		if (ret) {
-			dev_err(&pdev->dev, "failed to init from from fsl,tempmon-data\n");
+			dev_err(&pdev->dev, "failed to init from fsl,tempmon-data\n");
 			return ret;
 		}
 	}
-- 
2.7.4
