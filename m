From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 2/2] soc: mediatek: add SCPSYS power domain driver for
 MediaTek MT7623A SoC
Date: Fri, 2 Feb 2018 00:22:48 +0800
Message-ID: <1517502168.15199.43.camel@mtkswgap22>
References: <975fb80e1cdbe7f6d4a1d04fd3a2a21b619a193d.1517479588.git.sean.wang@mediatek.com>
         <de07c071f968ae9da84543bb33cc5658ed184801.1517479588.git.sean.wang@mediatek.com>
         <f0675124-c5c7-0f98-9762-c0778d7f5807@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <f0675124-c5c7-0f98-9762-c0778d7f5807-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, khilman-rdvid1DuHRBWk0Htik3J/w@public.gmane.org, ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2018-02-01 at 16:19 +0100, Matthias Brugger wrote:
> 
> On 02/01/2018 11:12 AM, sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org wrote:
> > From: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > 
> > Add SCPSYS power domain driver for MT7623A SoC. The MT7623A's power
> > domains are the subset of MT7623 SoC's ones. As MT7623 SoC has full
> > features whereas MT7623A is being designed just for router applications.
> > Thus, MT7623A doesn't include those power domains multimedia function
> > belongs to. In order to avoid certain errors undoubtedly happening at
> > registering those power domains on MT7623A SoC using the existing MT7623
> > SCPSYS driver, it's required to define another setup specifically for
> > MT7623A SoC. Also, use a meaningful definition for bus_prot_mask instead
> > of just hardcoded for it.
> 
> Also is nearly always a indicator to put it in a different patch. Could you
> please do so?
> 

Sure, I will do so in the next version.

> Otherwise the series look good.
> 

Really thanks for you prompt feedback

> Regards,
> Matthias
> 
> > 
> > Signed-off-by: Sean Wang <sean.wang-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
> > ---
> >  drivers/soc/mediatek/mtk-scpsys.c         | 60 +++++++++++++++++++++++++++++--
> >  include/dt-bindings/power/mt7623a-power.h | 10 ++++++
> >  include/linux/soc/mediatek/infracfg.h     |  4 +++
> >  3 files changed, 72 insertions(+), 2 deletions(-)
> >  create mode 100644 include/dt-bindings/power/mt7623a-power.h
> > 
> > diff --git a/drivers/soc/mediatek/mtk-scpsys.c b/drivers/soc/mediatek/mtk-scpsys.c
> > index 435ce5e..fc55faa 100644
> > --- a/drivers/soc/mediatek/mtk-scpsys.c
> > +++ b/drivers/soc/mediatek/mtk-scpsys.c
> > @@ -24,6 +24,7 @@
> >  #include <dt-bindings/power/mt2712-power.h>
> >  #include <dt-bindings/power/mt6797-power.h>
> >  #include <dt-bindings/power/mt7622-power.h>
> > +#include <dt-bindings/power/mt7623a-power.h>
> >  #include <dt-bindings/power/mt8173-power.h>
> >  
> >  #define SPM_VDE_PWR_CON			0x0210
> > @@ -518,7 +519,8 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
> >  		.name = "conn",
> >  		.sta_mask = PWR_STATUS_CONN,
> >  		.ctl_offs = SPM_CONN_PWR_CON,
> > -		.bus_prot_mask = 0x0104,
> > +		.bus_prot_mask = MT2701_TOP_AXI_PROT_EN_CONN_M |
> > +				 MT2701_TOP_AXI_PROT_EN_CONN_S,
> >  		.clk_id = {CLK_NONE},
> >  		.active_wakeup = true,
> >  	},
> > @@ -528,7 +530,7 @@ static const struct scp_domain_data scp_domain_data_mt2701[] = {
> >  		.ctl_offs = SPM_DIS_PWR_CON,
> >  		.sram_pdn_bits = GENMASK(11, 8),
> >  		.clk_id = {CLK_MM},
> > -		.bus_prot_mask = 0x0002,
> > +		.bus_prot_mask = MT2701_TOP_AXI_PROT_EN_MM_M0,
> >  		.active_wakeup = true,
> >  	},
> >  	[MT2701_POWER_DOMAIN_MFG] = {
> > @@ -794,6 +796,47 @@ static const struct scp_domain_data scp_domain_data_mt7622[] = {
> >  };
> >  
> >  /*
> > + * MT7623A power domain support
> > + */
> > +
> > +static const struct scp_domain_data scp_domain_data_mt7623a[] = {
> > +	[MT7623A_POWER_DOMAIN_CONN] = {
> > +		.name = "conn",
> > +		.sta_mask = PWR_STATUS_CONN,
> > +		.ctl_offs = SPM_CONN_PWR_CON,
> > +		.bus_prot_mask = MT2701_TOP_AXI_PROT_EN_CONN_M |
> > +				 MT2701_TOP_AXI_PROT_EN_CONN_S,
> > +		.clk_id = {CLK_NONE},
> > +		.active_wakeup = true,
> > +	},
> > +	[MT7623A_POWER_DOMAIN_ETH] = {
> > +		.name = "eth",
> > +		.sta_mask = PWR_STATUS_ETH,
> > +		.ctl_offs = SPM_ETH_PWR_CON,
> > +		.sram_pdn_bits = GENMASK(11, 8),
> > +		.sram_pdn_ack_bits = GENMASK(15, 12),
> > +		.clk_id = {CLK_ETHIF},
> > +		.active_wakeup = true,
> > +	},
> > +	[MT7623A_POWER_DOMAIN_HIF] = {
> > +		.name = "hif",
> > +		.sta_mask = PWR_STATUS_HIF,
> > +		.ctl_offs = SPM_HIF_PWR_CON,
> > +		.sram_pdn_bits = GENMASK(11, 8),
> > +		.sram_pdn_ack_bits = GENMASK(15, 12),
> > +		.clk_id = {CLK_ETHIF},
> > +		.active_wakeup = true,
> > +	},
> > +	[MT7623A_POWER_DOMAIN_IFR_MSC] = {
> > +		.name = "ifr_msc",
> > +		.sta_mask = PWR_STATUS_IFR_MSC,
> > +		.ctl_offs = SPM_IFR_MSC_PWR_CON,
> > +		.clk_id = {CLK_NONE},
> > +		.active_wakeup = true,
> > +	},
> > +};
> > +
> > +/*
> >   * MT8173 power domain support
> >   */
> >  
> > @@ -934,6 +977,16 @@ static const struct scp_soc_data mt7622_data = {
> >  	.bus_prot_reg_update = true,
> >  };
> >  
> > +static const struct scp_soc_data mt7623a_data = {
> > +	.domains = scp_domain_data_mt7623a,
> > +	.num_domains = ARRAY_SIZE(scp_domain_data_mt7623a),
> > +	.regs = {
> > +		.pwr_sta_offs = SPM_PWR_STATUS,
> > +		.pwr_sta2nd_offs = SPM_PWR_STATUS_2ND
> > +	},
> > +	.bus_prot_reg_update = true,
> > +};
> > +
> >  static const struct scp_soc_data mt8173_data = {
> >  	.domains = scp_domain_data_mt8173,
> >  	.num_domains = ARRAY_SIZE(scp_domain_data_mt8173),
> > @@ -964,6 +1017,9 @@ static const struct of_device_id of_scpsys_match_tbl[] = {
> >  		.compatible = "mediatek,mt7622-scpsys",
> >  		.data = &mt7622_data,
> >  	}, {
> > +		.compatible = "mediatek,mt7623a-scpsys",
> > +		.data = &mt7623a_data,
> > +	}, {
> >  		.compatible = "mediatek,mt8173-scpsys",
> >  		.data = &mt8173_data,
> >  	}, {
> > diff --git a/include/dt-bindings/power/mt7623a-power.h b/include/dt-bindings/power/mt7623a-power.h
> > new file mode 100644
> > index 0000000..ac15b5d
> > --- /dev/null
> > +++ b/include/dt-bindings/power/mt7623a-power.h
> > @@ -0,0 +1,10 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +#ifndef _DT_BINDINGS_POWER_MT7623A_POWER_H
> > +#define _DT_BINDINGS_POWER_MT7623A_POWER_H
> > +
> > +#define MT7623A_POWER_DOMAIN_CONN	0
> > +#define MT7623A_POWER_DOMAIN_ETH	1
> > +#define MT7623A_POWER_DOMAIN_HIF	2
> > +#define MT7623A_POWER_DOMAIN_IFR_MSC	3
> > +
> > +#endif /* _DT_BINDINGS_POWER_MT2701_POWER_H */
> > diff --git a/include/linux/soc/mediatek/infracfg.h b/include/linux/soc/mediatek/infracfg.h
> > index b0a507d..fd25f01 100644
> > --- a/include/linux/soc/mediatek/infracfg.h
> > +++ b/include/linux/soc/mediatek/infracfg.h
> > @@ -21,6 +21,10 @@
> >  #define MT8173_TOP_AXI_PROT_EN_MFG_M1		BIT(22)
> >  #define MT8173_TOP_AXI_PROT_EN_MFG_SNOOP_OUT	BIT(23)
> >  
> > +#define MT2701_TOP_AXI_PROT_EN_MM_M0		BIT(1)
> > +#define MT2701_TOP_AXI_PROT_EN_CONN_M		BIT(2)
> > +#define MT2701_TOP_AXI_PROT_EN_CONN_S		BIT(8)
> > +
> >  #define MT7622_TOP_AXI_PROT_EN_ETHSYS		(BIT(3) | BIT(17))
> >  #define MT7622_TOP_AXI_PROT_EN_HIF0		(BIT(24) | BIT(25))
> >  #define MT7622_TOP_AXI_PROT_EN_HIF1		(BIT(26) | BIT(27) | \
> > 
> 


--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
