From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Subject: [PATCH v2] devfreq: rk3399_dmc: fix error return code in
 rk3399_dmcfreq_probe()
Date: Mon, 3 Jul 2017 07:59:26 -0500
Message-ID: <20170703125926.GA4170@embeddedgus>
References: <CAJ0PZbQfwf6VrHLMWc_VL=7FgzFo7DpCugDfiZtawY1FDLcy7g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJ0PZbQfwf6VrHLMWc_VL=7FgzFo7DpCugDfiZtawY1FDLcy7g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <garsilva@embeddedor.com>
List-Id: linux-pm@vger.kernel.org

platform_get_irq() returns an error code, but the rk3399_dmc
driver ignores it and always returns -EINVAL. This is not correct,
and prevents -EPROBE_DEFER from being propagated properly.

Notice that platform_get_irq() no longer returns 0 on error:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=e330b9a6bb35dc7097a4f02cb1ae7b6f96df92af

Print and propagate the return value of platform_get_irq on failure.

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>
Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>
Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>
---
Changes in v2:
 Rewrite commit message.
 
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
