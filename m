From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v1 2/4] cpufreq: mediatek: Add mediatek related projects
 into blacklist
Date: Mon, 11 Dec 2017 13:25:32 +0530
Message-ID: <20171211075532.GB25177@vireshk-i7>
References: <1512713278-17807-1-git-send-email-andrew-sh.cheng@mediatek.com>
 <1512713278-17807-3-git-send-email-andrew-sh.cheng@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:41190 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751379AbdLKHzf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 11 Dec 2017 02:55:35 -0500
Received: by mail-pg0-f66.google.com with SMTP id o2so10374088pgc.8
        for <linux-pm@vger.kernel.org>; Sun, 10 Dec 2017 23:55:35 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1512713278-17807-3-git-send-email-andrew-sh.cheng@mediatek.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
Cc: rjw@rjwysocki.net, matthias.bgg@gmail.com, mark.rutland@arm.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, srv_heupstream@mediatek.com, robh+dt@kernel.org, devicetree@vger.kernel.org

On 08-12-17, 14:07, Andrew-sh Cheng wrote:
> mediatek projects will use mediate-cpufreq.c as cpufreq driver,
> instead of using cpufreq_dt.c
> Add mediatek related projects into cpufreq-dt blacklist
> 
> Signed-off-by: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
> ---
>  drivers/cpufreq/cpufreq-dt-platdev.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> index ecc56e2..3b585e4 100644
> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> @@ -108,6 +108,14 @@ static const struct of_device_id blacklist[] __initconst = {
>  
>  	{ .compatible = "marvell,armadaxp", },
>  
> +	{ .compatible = "mediatek,mt2701", },
> +	{ .compatible = "mediatek,mt2712", },
> +	{ .compatible = "mediatek,mt7622", },
> +	{ .compatible = "mediatek,mt7623", },
> +	{ .compatible = "mediatek,mt817x", },
> +	{ .compatible = "mediatek,mt8173", },
> +	{ .compatible = "mediatek,mt8176", },
> +
>  	{ .compatible = "nvidia,tegra124", },
>  
>  	{ .compatible = "st,stih407", },

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
