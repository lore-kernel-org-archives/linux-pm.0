From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH] devfreq: rk3399_dmc: fix error code in rk3399_dmcfreq_probe()
Date: Fri, 30 Jun 2017 02:15:22 -0500
Message-ID: <20170630071522.GA20486@embeddedgus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-pm@vger.kernel.org

Print and propagate the return value of platform_get_irq on failure.

Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
 drivers/devfreq/rk3399_dmc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/devfreq/rk3399_dmc.c b/drivers/devfreq/rk3399_dmc.c
index 40a2499..1b89ebb 100644
--- a/drivers/devfreq/rk3399_dmc.c
+++ b/drivers/devfreq/rk3399_dmc.c
@@ -336,8 +336,9 @@ static int rk3399_dmcfreq_probe(struct platform_device *pdev)
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0) {
-		dev_err(&pdev->dev, "Cannot get the dmc interrupt resource\n");
-		return -EINVAL;
+		dev_err(&pdev->dev,
+			"Cannot get the dmc interrupt resource: %d\n", irq);
+		return irq;
 	}
 	data = devm_kzalloc(dev, sizeof(struct rk3399_dmcfreq), GFP_KERNEL);
 	if (!data)
-- 
2.5.0
