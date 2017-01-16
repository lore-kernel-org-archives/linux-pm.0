From: Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 04/12] pinctrl: samsung: Document Exynos3250 SoC support
Date: Mon, 16 Jan 2017 07:44:59 +0100
Message-ID: <1484549107-5957-5-git-send-email-m.szyprowski@samsung.com>
References: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170116064525eucas1p123df65dedceef6e3efe255e9a2ec6d07@eucas1p1.samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:59749 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750913AbdAPGp3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2017 01:45:29 -0500
In-reply-to: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

Add missing compatible id for Exynos3250 SoC to device tree docs.
Exynos pin control driver supports it since commit d97f5b9804bfcdc1
("pinctrl: exynos: Add driver data for Exynos3250").

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
---
 Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
index 1baf19eecabf..5e00a21de2bf 100644
--- a/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
+++ b/Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt
@@ -13,6 +13,7 @@ Required Properties:
   - "samsung,s3c2450-pinctrl": for S3C2450-compatible pin-controller,
   - "samsung,s3c64xx-pinctrl": for S3C64xx-compatible pin-controller,
   - "samsung,s5pv210-pinctrl": for S5PV210-compatible pin-controller,
+  - "samsung,exynos3250-pinctrl": for Exynos3250 compatible pin-controller.
   - "samsung,exynos4210-pinctrl": for Exynos4210 compatible pin-controller.
   - "samsung,exynos4x12-pinctrl": for Exynos4x12 compatible pin-controller.
   - "samsung,exynos5250-pinctrl": for Exynos5250 compatible pin-controller.
-- 
1.9.1

