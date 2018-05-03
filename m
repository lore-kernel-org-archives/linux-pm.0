From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v3] soc: mediatek: add a fixed wait for SRAM stable
Date: Thu, 3 May 2018 09:12:31 +0200
Message-ID: <2377953d-f5a2-7b59-8d07-034b6827c45f@gmail.com>
References: <90f83c1bd359bb39cdae334e489037d6fb8ac69b.1525233544.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <90f83c1bd359bb39cdae334e489037d6fb8ac69b.1525233544.git.sean.wang@mediatek.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: sean.wang@mediatek.com, rjw@rjwysocki.net, khilman@baylibre.com
Cc: ulf.hansson@linaro.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Weiyi Lu <weiyi.lu@mediatek.com>
List-Id: linux-pm@vger.kernel.org



On 05/02/2018 06:03 AM, sean.wang@mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> MT7622_POWER_DOMAIN_WB doesn't send an ACK when its managed SRAM becomes
> stable, which is not like the behavior the other power domains should
> have. Therefore, it's necessary for such a power domain to have a fixed
> and well-predefined duration to wait until its managed SRAM can be allowed
> to access by all functions running on the top.
> 
> v1 -> v2:
>  - use MTK_SCPD_FWAIT_SRAM flag as an indication requiring force waiting.
> 
> v2 -> v3:
>  - change the order for condition judgment with we check an existence of
>    the MTK_SCPD_FWAIT_SRAM first to get rid of any oversight on negative
>    condition.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> Cc: Matthias Brugger <matthias.bgg@gmail.com>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Weiyi Lu <weiyi.lu@mediatek.com>
> ---

Now pused to v4.17-next/soc

Thanks a lot!
Matthias

>  drivers/soc/mediatek/mtk-scpsys.c | 23 +++++++++++++++++------
>  1 file changed, 17 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index b1b45e4..2080c8f 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -32,6 +32,7 @@
>  #define MTK_POLL_TIMEOUT    (jiffies_to_usecs(HZ))
>  
>  #define MTK_SCPD_ACTIVE_WAKEUP		BIT(0)
> +#define MTK_SCPD_FWAIT_SRAM		BIT(1)
>  #define MTK_SCPD_CAPS(_scpd, _x)	((_scpd)->data->caps & (_x))
>  
>  #define SPM_VDE_PWR_CON			0x0210
> @@ -237,11 +238,21 @@ static int scpsys_power_on(struct generic_pm_domain *genpd)
>  	val &= ~scpd->data->sram_pdn_bits;
>  	writel(val, ctl_addr);
>  
> -	/* wait until SRAM_PDN_ACK all 0 */
> -	ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
> -				 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> -	if (ret < 0)
> -		goto err_pwr_ack;
> +	/* Either wait until SRAM_PDN_ACK all 0 or have a force wait */
> +	if (MTK_SCPD_CAPS(scpd, MTK_SCPD_FWAIT_SRAM)) {
> +		/*
> +		 * Currently, MTK_SCPD_FWAIT_SRAM is necessary only for
> +		 * MT7622_POWER_DOMAIN_WB and thus just a trivial setup is
> +		 * applied here.
> +		 */
> +		usleep_range(12000, 12100);
> +
> +	} else {
> +		ret = readl_poll_timeout(ctl_addr, tmp, (tmp & pdn_ack) == 0,
> +					 MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
> +		if (ret < 0)
> +			goto err_pwr_ack;
> +	};
>  
>  	if (scpd->data->bus_prot_mask) {
>  		ret = mtk_infracfg_clear_bus_protection(scp->infracfg,
> @@ -785,7 +796,7 @@ static const struct scp_domain_data scp_domain_data_mt7622[] = {
>  		.sram_pdn_ack_bits = 0,
>  		.clk_id = {CLK_NONE},
>  		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_WB,
> -		.caps = MTK_SCPD_ACTIVE_WAKEUP,
> +		.caps = MTK_SCPD_ACTIVE_WAKEUP | MTK_SCPD_FWAIT_SRAM,
>  	},
>  };
>  
> 
