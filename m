From: Henry Chen <henryc.chen@mediatek.com>
Subject: Re: [RFC RESEND PATCH 1/7] dt-bindings: soc: Add DVFSRC driver
 bindings
Date: Mon, 18 Feb 2019 12:55:32 +0800
Message-ID: <1550465732.32365.6.camel@mtksdaap41>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
         <1546438198-1677-2-git-send-email-henryc.chen@mediatek.com>
         <20190111160918.GA20480@bogus>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190111160918.GA20480@bogus>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kees Cook <keescook@chromium.org>, Weiyi Lu <weiyi.lu@mediatek.com>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>, linux-kernel@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hi Rob,

Sorry for late reply. I missed this mail before.

On Fri, 2019-01-11 at 10:09 -0600, Rob Herring wrote:
> On Wed, Jan 02, 2019 at 10:09:52PM +0800, Henry Chen wrote:
> > Document the binding for enabling DVFSRC on MediaTek SoC.
> > 
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > ---
> >  .../devicetree/bindings/soc/mediatek/dvfsrc.txt    | 26 ++++++++++++++++++++++
> >  include/dt-bindings/soc/mtk,dvfsrc.h               | 18 +++++++++++++++
> >  2 files changed, 44 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> >  create mode 100644 include/dt-bindings/soc/mtk,dvfsrc.h
> > 
> > diff --git a/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> > new file mode 100644
> > index 0000000..402c885
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
> > @@ -0,0 +1,26 @@
> > +MediaTek DVFSRC Driver
> 
> Bindings are for h/w blocks, not drivers.
ok.
> 
> > +The Dynamic Voltage and Frequency Scaling Resource Collector (DVFSRC) is a
> > +HW module which is used to collect all the requests from both software and
> > +hardware and turn into the decision of minimum operating voltage and minimum
> > +DRAM frequency to fulfill those requests.
> 
> Seems like the OPP table should be a child of this instead of where you 
> currently have it?
Do you means the opp table that I put on scpsys likes below?
I think this opp table is used for mapping the performance state of
power domain, so I put it on scpsys device tree document.

		dvfsrc_opp_table: opp-table {
			compatible = "operating-points-v2-level";

			dvfsrc_vol_min: opp1 {
				opp,level = <MT8183_DVFSRC_LEVEL_1>;
			};

			dvfsrc_freq_medium: opp2 {
				opp,level = <MT8183_DVFSRC_LEVEL_2>;
			};

			dvfsrc_freq_max: opp3 {
				opp,level = <MT8183_DVFSRC_LEVEL_3>;
			};

			dvfsrc_vol_max: opp4 {
				opp,level = <MT8183_DVFSRC_LEVEL_4>;
			};
		};

> 
> > +
> > +Required Properties:
> > +- compatible: Should be one of the following
> > +	- "mediatek,mt8183-dvfsrc": For MT8183 SoC
> > +- reg: Address range of the DVFSRC unit
> > +- dram_type: Refer to <include/dt-bindings/soc/mtk,dvfsrc.h> for the
> > +	different dram type support.
> 
> This information should come from the DDR controller or memory nodes 
> probably. And we already have some properties related to DDR type.
Sorry, I don't know that before, could you give some hint or example for
that?

> 
> > +- clock-names: Must include the following entries:
> > +	"dvfsrc": DVFSRC module clock
> > +- clocks: Must contain an entry for each entry in clock-names.
> > +
> > +Example:
> > +
> > +	dvfsrc_top@10012000 {
> 
> Drop the '_top'. (Don't use '_' in node and property names)..
ok
> 
> > +		compatible = "mediatek,mt8183-dvfsrc";
> > +		reg = <0 0x10012000 0 0x1000>;
> > +		clocks = <&infracfg CLK_INFRA_DVFSRC>;
> > +		clock-names = "dvfsrc";
> > +		dram_type = <MT8183_DVFSRC_OPP_LP4>;
> > +	};
> > diff --git a/include/dt-bindings/soc/mtk,dvfsrc.h b/include/dt-bindings/soc/mtk,dvfsrc.h
> > new file mode 100644
> > index 0000000..60b3497
> > --- /dev/null
> > +++ b/include/dt-bindings/soc/mtk,dvfsrc.h
> > @@ -0,0 +1,18 @@
> > +/* SPDX-License-Identifier: GPL-2.0
> > + *
> > + * Copyright (c) 2018 MediaTek Inc.
> > + */
> > +
> > +#ifndef _DT_BINDINGS_POWER_MTK_DVFSRC_H
> > +#define _DT_BINDINGS_POWER_MTK_DVFSRC_H
> > +
> > +#define MT8183_DVFSRC_OPP_LP4	0
> > +#define MT8183_DVFSRC_OPP_LP4X	1
> > +#define MT8183_DVFSRC_OPP_LP3	2
> > +
> > +#define MT8183_DVFSRC_LEVEL_1	1
> > +#define MT8183_DVFSRC_LEVEL_2	2
> > +#define MT8183_DVFSRC_LEVEL_3	3
> > +#define MT8183_DVFSRC_LEVEL_4	4
> > +
> > +#endif /* _DT_BINDINGS_POWER_MTK_DVFSRC_H */
> > -- 
> > 1.9.1
> > 
> 
> _______________________________________________
> Linux-mediatek mailing list
> Linux-mediatek@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-mediatek
