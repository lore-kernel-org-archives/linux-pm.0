From: Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: [PATCH v2 3/3] soc: mediatek: add SCPSYS power domain driver for
 MediaTek MT7622 SoC
Date: Tue, 1 Aug 2017 16:58:42 +0200
Message-ID: <79cdec68-19ce-d647-5f35-ff29808aac18@gmail.com>
References: <cover.1501581552.git.sean.wang@mediatek.com>
 <892e8fb55428c0761620c4472852f86cd56f0f0d.1501581552.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:38496 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbdHAO6r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 1 Aug 2017 10:58:47 -0400
In-Reply-To: <892e8fb55428c0761620c4472852f86cd56f0f0d.1501581552.git.sean.wang@mediatek.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sean.wang@mediatek.com, robh+dt@kernel.org, rjw@rjwysocki.net, khilman@baylibre.com
Cc: ulf.hansson@linaro.org, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Chen Zhong <chen.zhong@mediatek.com>



On 08/01/2017 12:06 PM, sean.wang@mediatek.com wrote:
> From: Chen Zhong <chen.zhong@mediatek.com>
> 
> Add SCPSYS power domain driver for MT7622 SoC having four power domains
> which are respectively ETHSYS for Ethernet including embedded switch,
> WBSYS for WIFI and Bluetooth, HIF0SYS for PCI-E and SATA, and HIF1SYS for
> USB. Those functions could be selectively powered gated when the
> corresponding function is no longer to use in order to reach more minimal
> power dissipation.
> 
> Signed-off-by: Chen Zhong <chen.zhong@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>   drivers/soc/mediatek/mtk-scpsys.c     | 81 +++++++++++++++++++++++++++++++++++
>   include/linux/soc/mediatek/infracfg.h |  8 +++-
>   2 files changed, 88 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> index ceb2cc4..513aa73 100644
> --- a/drivers/soc/mediatek/mtk-scpsys.c
> +++ b/drivers/soc/mediatek/mtk-scpsys.c
> @@ -22,6 +22,7 @@
>   
>   #include <dt-bindings/power/mt2701-power.h>
>   #include <dt-bindings/power/mt6797-power.h>
> +#include <dt-bindings/power/mt7622-power.h>
>   #include <dt-bindings/power/mt8173-power.h>
>   
>   #define SPM_VDE_PWR_CON			0x0210
> @@ -39,6 +40,11 @@
>   #define SPM_MFG_2D_PWR_CON		0x02c0
>   #define SPM_MFG_ASYNC_PWR_CON		0x02c4
>   #define SPM_USB_PWR_CON			0x02cc
> +#define SPM_ETHSYS_PWR_CON		0x02e0	/* MT7622 */
> +#define SPM_HIF0_PWR_CON		0x02e4	/* MT7622 */
> +#define SPM_HIF1_PWR_CON		0x02e8	/* MT7622 */
> +#define SPM_WB_PWR_CON			0x02ec	/* MT7622 */
> +
>   
>   #define SPM_PWR_STATUS			0x060c
>   #define SPM_PWR_STATUS_2ND		0x0610
> @@ -64,6 +70,10 @@
>   #define PWR_STATUS_MFG_ASYNC		BIT(23)
>   #define PWR_STATUS_AUDIO		BIT(24)
>   #define PWR_STATUS_USB			BIT(25)
> +#define PWR_STATUS_ETHSYS		BIT(24)	/* MT7622 */
> +#define PWR_STATUS_HIF0			BIT(25)	/* MT7622 */
> +#define PWR_STATUS_HIF1			BIT(26)	/* MT7622 */
> +#define PWR_STATUS_WB			BIT(27)	/* MT7622 */
>   
>   enum clk_id {
>   	CLK_NONE,
> @@ -73,6 +83,7 @@ enum clk_id {
>   	CLK_VENC_LT,
>   	CLK_ETHIF,
>   	CLK_VDEC,
> +	CLK_HIFSEL,
>   	CLK_MAX,
>   };
>   
> @@ -84,6 +95,7 @@ static const char * const clk_names[] = {
>   	"venc_lt",
>   	"ethif",
>   	"vdec",
> +	"hif_sel",
>   	NULL,
>   };
>   
> @@ -696,6 +708,72 @@ static int __init scpsys_probe_mt6797(struct platform_device *pdev)
>   }
>   
>   /*
> + * MT7622 power domain support
> + */
> +static const struct scp_domain_data scp_domain_data_mt7622[] = {
> +	[MT7622_POWER_DOMAIN_ETHSYS] = {
> +		.name = "ethsys",
> +		.sta_mask = PWR_STATUS_ETHSYS,
> +		.ctl_offs = SPM_ETHSYS_PWR_CON,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(15, 12),
> +		.clk_id = {CLK_NONE},
> +		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_ETHSYS,
> +		.active_wakeup = true,
> +	},
> +	[MT7622_POWER_DOMAIN_HIF0] = {
> +		.name = "hif0",
> +		.sta_mask = PWR_STATUS_HIF0,
> +		.ctl_offs = SPM_HIF0_PWR_CON,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(15, 12),
> +		.clk_id = {CLK_HIFSEL},
> +		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_HIF0,
> +		.active_wakeup = true,
> +	},
> +	[MT7622_POWER_DOMAIN_HIF1] = {
> +		.name = "hif1",
> +		.sta_mask = PWR_STATUS_HIF1,
> +		.ctl_offs = SPM_HIF1_PWR_CON,
> +		.sram_pdn_bits = GENMASK(11, 8),
> +		.sram_pdn_ack_bits = GENMASK(15, 12),
> +		.clk_id = {CLK_HIFSEL},
> +		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_HIF1,
> +		.active_wakeup = true,
> +	},
> +	[MT7622_POWER_DOMAIN_WB] = {
> +		.name = "wb",
> +		.sta_mask = PWR_STATUS_WB,
> +		.ctl_offs = SPM_WB_PWR_CON,
> +		.sram_pdn_bits = 0,
> +		.sram_pdn_ack_bits = 0,
> +		.clk_id = {CLK_NONE},
> +		.bus_prot_mask = MT7622_TOP_AXI_PROT_EN_WB,
> +		.active_wakeup = true,
> +	},
> +};
> +
> +#define NUM_DOMAINS_MT7622	ARRAY_SIZE(scp_domain_data_mt7622)
> +
> +static int __init scpsys_probe_mt7622(struct platform_device *pdev)
> +{
> +	struct scp *scp;
> +	struct scp_ctrl_reg scp_reg;
> +
> +	scp_reg.pwr_sta_offs = SPM_PWR_STATUS;
> +	scp_reg.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND;
> +
> +	scp = init_scp(pdev, scp_domain_data_mt7622, NUM_DOMAINS_MT7622,
> +		       &scp_reg);
> +	if (IS_ERR(scp))
> +		return PTR_ERR(scp);
> +
> +	mtk_register_power_domains(pdev, scp, NUM_DOMAINS_MT7622);
> +
> +	return 0;
> +}

All the scpsys_probe_mtXXXX are following the same pattern, which get's really 
obvious when comparing this function to scpsys_probe_mt2701.
Instead of adding the scpsys_probe_mtXXXX callback to the of_device_id data 
pointer, couldn't we pass a struct with a pointer to the scp_domain_data_mtXXXX 
array and a possible callback to register the subdomains?

This would reduce code duplication for every new SoC, which starts to bloat the 
driver.

Can you implement this as a separate patch of this series? Or do you prefer me 
to do so and you just rebase your series on top of that?

Regards,
Matthias

> +
> +/*
>    * MT8173 power domain support
>    */
>   
> @@ -835,6 +913,9 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
>   		.compatible = "mediatek,mt6797-scpsys",
>   		.data = scpsys_probe_mt6797,
>   	}, {
> +		.compatible = "mediatek,mt7622-scpsys",
> +		.data = scpsys_probe_mt7622,
> +	}, {
>   		.compatible = "mediatek,mt8173-scpsys",
>   		.data = scpsys_probe_mt8173,
>   	}, {
> diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
> index a5714e9..c1e5062 100644
> --- a/include/linux/soc/mediatek/infracfg.h
> +++ b/include/linux/soc/mediatek/infracfg.h
> @@ -20,7 +20,13 @@
>   #define MT8173_TOP_AXI_PROT_EN_MFG_M1		BIT(22)
>   #define MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT	BIT(23)
>   
> +#define MT7622_TOP_AXI_PROT_EN_ETHSYS		(BIT(3) | BIT(17))
> +#define MT7622_TOP_AXI_PROT_EN_HIF0		(BIT(24) | BIT(25))
> +#define MT7622_TOP_AXI_PROT_EN_HIF1		(BIT(26) | BIT(27) | \
> +						 BIT(28))
> +#define MT7622_TOP_AXI_PROT_EN_WB		(BIT(2) | BIT(6) | \
> +						 BIT(7) | BIT(8))
> +
>   int mtk_infracfg_set_bus_protection(struct regmap *infracfg, u32 mask);
>   int mtk_infracfg_clear_bus_protection(struct regmap *infracfg, u32 mask);
> -
>   #endif /* __SOC_MEDIATEK_INFRACFG_H */
> 
