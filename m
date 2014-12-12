From: Eduardo Valentin <edubezval@gmail.com>
Subject: [PATCH 1/2] thermal: db8500: Do not print error message in the EPROBE_DEFER case
Date: Fri, 12 Dec 2014 10:14:24 -0400
Message-ID: <1418393665-16850-2-git-send-email-edubezval@gmail.com>
References: <1418393665-16850-1-git-send-email-edubezval@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1418393665-16850-1-git-send-email-edubezval@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Avoid printing the error message in the EPROBE_DEFER case
where registering cpu cooling at db8500 thermal driver.

Cc: Zhang Rui <rui.zhang@intel.com>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
---
 drivers/thermal/db8500_cpufreq_cooling.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/db8500_cpufreq_cooling.c b/drivers/thermal/db8500_cpufreq_cooling.c
index 3cc3dd9..28bbff9 100644
--- a/drivers/thermal/db8500_cpufreq_cooling.c
+++ b/drivers/thermal/db8500_cpufreq_cooling.c
@@ -30,8 +30,14 @@ static int db8500_cpufreq_cooling_probe(struct platform_device *pdev)
 
 	cdev = cpufreq_cooling_register(cpu_present_mask);
 	if (IS_ERR(cdev)) {
-		dev_err(&pdev->dev, "Failed to register cooling device\n");
-		return PTR_ERR(cdev);
+		int ret = PTR_ERR(cdev);
+
+		if (ret != -EPROBE_DEFER)
+			dev_err(&pdev->dev,
+				"Failed to register cooling device %d\n",
+				ret);
+				
+		return ret;
 	}
 
 	platform_set_drvdata(pdev, cdev);
-- 
2.1.3
