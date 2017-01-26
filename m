From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 REBASED 06/13] pinctrl: samsung: Fix
 samsung_pinctrl_create_functions return value
Date: Thu, 26 Jan 2017 10:29:20 +0100
Message-ID: <1485422967-30643-3-git-send-email-m.szyprowski@samsung.com>
References: <CACRpkdY_SpqfyTTqSP5+a1k1LDf_5w77UXo=EognmOzWBz2c-Q@mail.gmail.com>
 <1485422967-30643-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170126092959eucas1p28ac04e5c3b9c4ae882047c93a57d3a4e@eucas1p2.samsung.com>
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-reply-to: <1485422967-30643-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
List-Id: linux-pm@vger.kernel.org

Return proper error code in case of memory allocation failure.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>
Acked-by: Tomasz Figa <tomasz.figa@gmail.com>
---
 drivers/pinctrl/samsung/pinctrl-samsung.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
index b11e67e85460..10b3fd826231 100644
--- a/drivers/pinctrl/samsung/pinctrl-samsung.c
+++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
@@ -751,7 +751,7 @@ static struct samsung_pmx_func *samsung_pinctrl_create_functions(
 	functions = devm_kzalloc(dev, func_cnt * sizeof(*functions),
 					GFP_KERNEL);
 	if (!functions)
-		return ERR_PTR(-EINVAL);
+		return ERR_PTR(-ENOMEM);
 	func = functions;
 
 	/*
-- 
1.9.1
