From: Sean Wang <sean.wang@mediatek.com>
Subject: Re: [PATCH] soc: mediatek: fix the mistaken pointer accessed when
 subdomains are added
Date: Wed, 7 Mar 2018 17:21:39 +0800
Message-ID: <1520414499.677.5.camel@mtkswgap22>
References: <9d9d75250bf62b491294a0c550c35ab7aba05eef.1518113047.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <9d9d75250bf62b491294a0c550c35ab7aba05eef.1518113047.git.sean.wang@mediatek.com>
Sender: stable-owner@vger.kernel.org
To: matthias.bgg@gmail.com
Cc: rjw@rjwysocki.net, khilman@baylibre.com, ulf.hansson@linaro.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi, Matthis
	
also a gentle ping for the patch
	
	Sean

On Fri, 2018-02-09 at 02:07 +0800, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Fix the pointer to struct scp_subdomian not being moved forward
> when each sub-domain is expected to be iteratively added through
> pm_genpd_add_subdomain call.
> 
> Cc: stable@vger.kernel.org
> Fixes: 53fddb1a66dd ("soc: mediatek: reduce code duplication of scpsys_probe across all SoCs")
> Reported-by: Weiyi Lu <weiyi.lu@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index fc55faa..9de801e 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -1048,7 +1048,7 @@ static int scpsys_probe(struct platform_device *pdev)
>  
>  	pd_data = &scp->pd_data;
>  
> -	for (i = 0, sd = soc->subdomains ; i < soc->num_subdomains ; i++) {
> +	for (i = 0, sd = soc->subdomains; i < soc->num_subdomains; i++, sd++) {
>  		ret = pm_genpd_add_subdomain(pd_data->domains[sd->origin],
>  					     pd_data->domains[sd->subdomain]);
>  		if (ret && IS_ENABLED(CONFIG_PM))
