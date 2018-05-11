From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH] soc: mediatek: remove unneeded semicolon
Date: Fri, 11 May 2018 13:27:21 +0200
Message-ID: <6f0c2ce4-d478-d9d1-300f-ccb2f6cd8c4f@gmail.com>
References: <a4b9c30335194d90072baf9373e41a21b349bc54.1525920846.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a4b9c30335194d90072baf9373e41a21b349bc54.1525920846.git.sean.wang@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: sean.wang@mediatek.com, rjw@rjwysocki.net, khilman@baylibre.com
Cc: ulf.hansson@linaro.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org



On 05/10/2018 04:57 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Fix up drivers/soc/mediatek/mtk-scpsys.c:255:2-3: Unneeded semicolon
> accidently being added in commit f9e2f65dd561 ("soc: mediatek: add a
> fixed wait for SRAM stable").
> 
> Fixes: f9e2f65dd561 ("soc: mediatek: add a fixed wait for SRAM stable")
> Reported-by: kbuild test robot <lkp@intel.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---

pushed to v4.17-next/soc
Thanks


>  drivers/soc/mediatek/mtk-scpsys.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index 2080c8f..128e3dd 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -252,7 +252,7 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>  					 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
>  		if (ret < 0)
>  			goto err_pwr_ack;
> -	};
> +	}
>  
>  	if (scpd->data->bus_prot_mask) {
>  		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> 
