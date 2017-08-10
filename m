From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v8 4/5] clk: samsung: exynos-audss: Use local variable
 for controller's device
Date: Thu, 10 Aug 2017 07:53:00 +0200
Message-ID: <20170810055300.GB3268@kozik-book>
References: <1502274907-11931-1-git-send-email-m.szyprowski@samsung.com>
 <CGME20170809103514eucas1p11fb5d1af243e882a5d51a25956d24a19@eucas1p1.samsung.com>
 <1502274907-11931-5-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-it0-f68.google.com ([209.85.214.68]:36878 "EHLO
        mail-it0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbdHJFxP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 10 Aug 2017 01:53:15 -0400
Content-Disposition: inline
In-Reply-To: <1502274907-11931-5-git-send-email-m.szyprowski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-clk@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Stephen Boyd <sboyd@codeaurora.org>, Michael Turquette <mturquette@baylibre.com>, Ulf Hansson <ulf.hansson@linaro.org>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Inki Dae <inki.dae@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>

On Wed, Aug 09, 2017 at 12:35:06PM +0200, Marek Szyprowski wrote:
> Store pointer to the controller's device in local variable to avoid
> extracting it from platform device in each call. This will also simplify
> code in the future, when runtime PM support is added.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/clk/samsung/clk-exynos-audss.c | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
