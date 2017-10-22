From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] devfreq/exynos-bus: Use common error handling code in
 exynos_bus_target()
Date: Sun, 22 Oct 2017 15:40:48 +0200
Message-ID: <4a407cd6-020c-1750-019a-6c0ceb40e245@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.web.de ([217.72.192.78]:53555 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751292AbdJVNld (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sun, 22 Oct 2017 09:41:33 -0400
Content-Language: en-GB
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Sun, 22 Oct 2017 15:33:06 +0200

Adjust jump targets so that a bit of exception handling can be better
reused at the end of this function.

This issue was detected by using the Coccinelle software.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/devfreq/exynos-bus.c | 21 ++++++++++-----------
 1 file changed, 10 insertions(+), 11 deletions(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 49f68929e024..e38d456b2d7d 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -124,34 +124,33 @@ static int exynos_bus_target(struct device *dev, unsigned long *freq, u32 flags)
 
 	if (old_freq < new_freq) {
 		ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
-		if (ret < 0) {
-			dev_err(bus->dev, "failed to set voltage\n");
-			goto out;
-		}
+		if (ret < 0)
+			goto report_failure;
 	}
 
 	ret = clk_set_rate(bus->clk, new_freq);
 	if (ret < 0) {
 		dev_err(dev, "failed to change clock of bus\n");
 		clk_set_rate(bus->clk, old_freq);
-		goto out;
+		goto unlock;
 	}
 
 	if (old_freq > new_freq) {
 		ret = regulator_set_voltage_tol(bus->regulator, new_volt, tol);
-		if (ret < 0) {
-			dev_err(bus->dev, "failed to set voltage\n");
-			goto out;
-		}
+		if (ret < 0)
+			goto report_failure;
 	}
 	bus->curr_freq = new_freq;
 
 	dev_dbg(dev, "Set the frequency of bus (%luHz -> %luHz, %luHz)\n",
 			old_freq, new_freq, clk_get_rate(bus->clk));
-out:
+unlock:
 	mutex_unlock(&bus->lock);
-
 	return ret;
+
+report_failure:
+	dev_err(bus->dev, "failed to set voltage\n");
+	goto unlock;
 }
 
 static int exynos_bus_get_dev_status(struct device *dev,
-- 
2.14.2
