From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH v2 06/13] pinctrl: samsung: Fix
 samsung_pinctrl_create_functions return value
Date: Tue, 17 Jan 2017 13:44:37 +0100
Message-ID: <1484657084-26227-7-git-send-email-m.szyprowski@samsung.com>
References: <1484657084-26227-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170117124459eucas1p1ead13705d84054c1d69b5d7a9795f0e9@eucas1p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.w1.samsung.com ([210.118.77.13]:63732 "EHLO
        mailout3.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751140AbdAQMqE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 Jan 2017 07:46:04 -0500
In-reply-to: <1484657084-26227-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Return proper error code in case of memory allocation failure.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
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

