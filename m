From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] PM / devfreq: exynos: fix error path in exynos_bus_probe()
Date: Tue, 28 Jun 2016 13:21:09 +0200
Message-ID: <1467112869-30488-2-git-send-email-b.zolnierkie@samsung.com>
References: <1467112869-30488-1-git-send-email-b.zolnierkie@samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1467112869-30488-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, b.zolnierkie@samsung.com
List-Id: linux-pm@vger.kernel.org

In case of exynos_bus_parse_of() failure the code shouldn't
try to remove the OPP table and disable+unprepare bus->clk
as it has been already handled in exynos_bus_parse_of().

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/devfreq/exynos-bus.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/exynos-bus.c b/drivers/devfreq/exynos-bus.c
index 2363d0a..e946f8f 100644
--- a/drivers/devfreq/exynos-bus.c
+++ b/drivers/devfreq/exynos-bus.c
@@ -407,7 +407,7 @@ static int exynos_bus_probe(struct platform_device *pdev)
 	/* Parse the device-tree to get the resource information */
 	ret = exynos_bus_parse_of(np, bus);
 	if (ret < 0)
-		goto err;
+		return ret;
 
 	profile = devm_kzalloc(dev, sizeof(*profile), GFP_KERNEL);
 	if (!profile) {
-- 
1.9.1
