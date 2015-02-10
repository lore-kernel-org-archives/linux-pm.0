From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] PM / devfreq: event: testing the wrong variable
Date: Tue, 10 Feb 2015 13:35:47 +0300
Message-ID: <20150210103547.GA18481@mwanda>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-samsung-soc-owner@vger.kernel.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>
Cc: Kyungmin Park <kyungmin.park@samsung.com>, Kukjin Kim <kgene@kernel.org>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

There is a typo here so we test "edev" but we intended to test
"edev[i]".

Fixes: f262f28c1470 ('PM / devfreq: event: Add devfreq_event class')
Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event/exynos-ppmu.c
index 135be0a..ad83473 100644
--- a/drivers/devfreq/event/exynos-ppmu.c
+++ b/drivers/devfreq/event/exynos-ppmu.c
@@ -327,8 +327,8 @@ static int exynos_ppmu_probe(struct platform_device *pdev)
 
 	for (i = 0; i < info->num_events; i++) {
 		edev[i] = devm_devfreq_event_add_edev(&pdev->dev, &desc[i]);
-		if (IS_ERR(edev)) {
-			ret = PTR_ERR(edev);
+		if (IS_ERR(edev[i])) {
+			ret = PTR_ERR(edev[i]);
 			dev_err(&pdev->dev,
 				"failed to add devfreq-event device\n");
 			goto err;
