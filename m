From: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
Subject: [PATCH] drivers: cpufreq: kirkwood: fix coccicheck warnings
Date: Fri, 22 Mar 2013 02:10:22 +0200
Message-ID: <1363911022-7786-1-git-send-email-silviupopescu1990@gmail.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: cpufreq@vger.kernel.org
Cc: rjw@sisk.pl, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
List-Id: linux-pm@vger.kernel.org

Convert all uses of devm_request_and_ioremap() to the newly introduced
devm_ioremap_resource() which provides more consistent error handling.

devm_ioremap_resource() provides its own error messages so all explicit
error messages can be removed from the failure code paths.

Signed-off-by: Silviu-Mihai Popescu <silviupopescu1990@gmail.com>
---
 drivers/cpufreq/kirkwood-cpufreq.c |    8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/kirkwood-cpufreq.c b/drivers/cpufreq/kirkwood-cpufreq.c
index 0e83e3c..6052476 100644
--- a/drivers/cpufreq/kirkwood-cpufreq.c
+++ b/drivers/cpufreq/kirkwood-cpufreq.c
@@ -175,11 +175,9 @@ static int kirkwood_cpufreq_probe(struct platform_device *pdev)
 		dev_err(&pdev->dev, "Cannot get memory resource\n");
 		return -ENODEV;
 	}
-	priv.base = devm_request_and_ioremap(&pdev->dev, res);
-	if (!priv.base) {
-		dev_err(&pdev->dev, "Cannot ioremap\n");
-		return -EADDRNOTAVAIL;
-	}
+	priv.base = devm_ioremap_resource(&pdev->dev, res);
+	if (IS_ERR(priv.base))
+		return PTR_ERR(priv.base);
 
 	np = of_find_node_by_path("/cpus/cpu@0");
 	if (!np)
-- 
1.7.9.5

