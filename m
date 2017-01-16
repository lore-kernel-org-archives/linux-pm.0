From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH 04/12] pinctrl: samsung: Document Exynos3250 SoC support
Date: Mon, 16 Jan 2017 21:01:28 +0200
Message-ID: <20170116190128.nylf37ra6iio7ly4@kozik-lap>
References: <1484549107-5957-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170116064525eucas1p123df65dedceef6e3efe255e9a2ec6d07@eucas1p1.samsung.com>
 <1484549107-5957-5-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f67.google.com ([209.85.215.67]:33365 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750777AbdAPTBh (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 16 Jan 2017 14:01:37 -0500
Content-Disposition: inline
In-Reply-To: <1484549107-5957-5-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, Sylwester Nawrocki <s.nawrocki@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>, Linus Walleij <linus.walleij@linaro.org>, Tomasz Figa <tomasz.figa@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Mon, Jan 16, 2017 at 07:44:59AM +0100, Marek Szyprowski wrote:
> Add missing compatible id for Exynos3250 SoC to device tree docs.
> Exynos pin control driver supports it since commit d97f5b9804bfcdc1
> ("pinctrl: exynos: Add driver data for Exynos3250").
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/samsung-pinctrl.txt | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof

