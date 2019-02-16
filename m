From: Yangtao Li <tiny.windzz@gmail.com>
Subject: [PATCH 2/3] PM / devfreq: rockchip-dfi: remove unneeded semicolon
Date: Sat, 16 Feb 2019 10:18:25 -0500
Message-ID: <20190216151826.11584-3-tiny.windzz@gmail.com>
References: <20190216151826.11584-1-tiny.windzz@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190216151826.11584-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: cw00.choi@samsung.com, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, heiko@sntech.de, thierry.reding@gmail.com, jonathanh@nvidia.com
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
List-Id: linux-pm@vger.kernel.org

The semicolon is unneeded, so remove it.

Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
---
 drivers/devfreq/event/rockchip-dfi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
index 22b113363ffc..fcbf76ebf55d 100644
--- a/drivers/devfreq/event/rockchip-dfi.c
+++ b/drivers/devfreq/event/rockchip-dfi.c
@@ -211,7 +211,7 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
 	if (IS_ERR(data->clk)) {
 		dev_err(dev, "Cannot get the clk dmc_clk\n");
 		return PTR_ERR(data->clk);
-	};
+	}
 
 	/* try to find the optional reference to the pmu syscon */
 	node = of_parse_phandle(np, "rockchip,pmu", 0);
-- 
2.17.0
