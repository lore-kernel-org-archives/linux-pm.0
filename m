From: Tomasz Figa <t.figa@samsung.com>
Subject: Re: [PATCH] thermal: exynos: handle gate clock for misplaced TRIMINFO
 register
Date: Thu, 07 Nov 2013 15:18:57 +0100
Message-ID: <1695605.pk9l7dqkqm@amdc1227>
References: <1383828154-428-1-git-send-email-ch.naveen@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout4.w1.samsung.com ([210.118.77.14]:25791 "EHLO
	mailout4.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab3KGOTF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Nov 2013 09:19:05 -0500
In-reply-to: <1383828154-428-1-git-send-email-ch.naveen@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
Cc: linux-pm@vger.kernel.org, naveenkrishna.ch@gmail.com, rui.zhang@intel.com, eduardo.valentin@ti.com, linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, amit.daniel@samsung.com, kgene.kim@samsung.com, devicetree@vger.kernel.org, b.zolnierkie@samsung.com, cpgs@samsung.com

Hi Naveen,

On Thursday 07 of November 2013 18:12:34 Naveen Krishna Chatradhi wrote:
> On Exynos5420 the TMU(4) for GPU has a seperate clock enable bit from
> the other TMU channels(0 ~ 3). Hence, accessing TRIMINFO for base_second
> should be acompanied by enabling the respective clock.
> 
> This patch which allow for a "clk_sec" clock to be specified in the
> device-tree which will be ungated when accessing the TRIMINFO register.
> 
> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Naveen Krishna Chatradhi <ch.naveen@samsung.com>
> ---
>  drivers/thermal/samsung/exynos_tmu.c |   24 +++++++++++++++++++++++-
>  1 file changed, 23 insertions(+), 1 deletion(-)

This patch modifies the device binding, but fails to mention anything
about the modification in respective documentation. Please do not do that.

In addition, since the series adding support for Exynos 5420 has not been
merged yet, I would rather make this patch a part of that series.

Also please see my comment below.

> diff --git a/drivers/thermal/samsung/exynos_tmu.c b/drivers/thermal/samsung/exynos_tmu.c
> index b54825a..33edd1a 100644
> --- a/drivers/thermal/samsung/exynos_tmu.c
> +++ b/drivers/thermal/samsung/exynos_tmu.c
[snip]
> @@ -641,6 +650,15 @@ static int exynos_tmu_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> +	data->clk_sec = devm_clk_get(&pdev->dev, "tmu_apbif_sec");
> +	if (!IS_ERR(data->clk_sec)) {

This code does not check if the clock was specified for TMU channels that
require it, i.e. the driver will not fail if you don't specify this clock.

Instead, it would be better create a separate compatible value for such
channels, like "samsung,exynos5420-tmu-broken-triminfo", for which this
clock would be mandatory and for which, if this clock is not specified,
the driver would fail.

Best regards,
Tomasz

