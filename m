From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v1 1/4] cpufreq: mediatek: add mt2712 into compatible list
Date: Mon, 11 Dec 2017 13:24:46 +0530
Message-ID: <20171211075446.GA25177@vireshk-i7>
References: <1512713278-17807-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1512713278-17807-2-git-send-email-andrew-sh.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f68.google.com ([74.125.83.68]:41134 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751584AbdLKHyu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Dec 2017 02:54:50 -0500
Received: by mail-pg0-f68.google.com with SMTP id o2so10373024pgc.8
        for <linux-pm@vger.kernel.org>; Sun, 10 Dec 2017 23:54:49 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1512713278-17807-2-git-send-email-andrew-sh.cheng@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
Cc: rjw@rjwysocki.net, matthias.bgg@gmail.com, mark.rutland@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, robh+dt@kernel.org, devicetree@vger.kernel.org

On 08-12-17, 14:07, Andrew-sh Cheng wrote:
> Support mt2712 in mediatek-cpufreq.c
> 
> Signed-off-by: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/cpufreq/mediatek-cpufreq.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
> index 18c4bd9..62aec5c 100644
> --- a/drivers/cpufreq/mediatek-cpufreq.c
> +++ b/drivers/cpufreq/mediatek-cpufreq.c
> @@ -574,6 +574,7 @@ static struct platform_driver mtk_cpufreq_platdrv = {
>  /* List of machines supported by this driver */
>  static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
>  	{ .compatible = "mediatek,mt2701", },
> +	{ .compatible = "mediatek,mt2712", },
>  	{ .compatible = "mediatek,mt7622", },
>  	{ .compatible = "mediatek,mt7623", },
>  	{ .compatible = "mediatek,mt817x", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
