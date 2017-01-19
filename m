From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v3 06/13] pinctrl: samsung: Fix
 samsung_pinctrl_create_functions return value
Date: Thu, 19 Jan 2017 14:48:46 +0100
Message-ID: <1484833733-16082-7-git-send-email-m.szyprowski@samsung.com>
References: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170119134907eucas1p126b668fe7e8054da6c4233d3ab345ba5@eucas1p1.samsung.com>
Return-path: <linux-gpio-owner@vger.kernel.org>
In-reply-to: <1484833733-16082-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-gpio-owner@vger.kernel.org
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

