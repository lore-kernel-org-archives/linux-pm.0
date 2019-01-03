From: Henry Chen <henryc.chen@mediatek.com>
Subject: Re: [RFC RESEND PATCH 4/7] arm64: dts: mt8183: add performance
 state support of scpsys
Date: Thu, 3 Jan 2019 22:16:34 +0800
Message-ID: <1546524994.6818.56.camel@mtksdaap41>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
         <1546438198-1677-5-git-send-email-henryc.chen@mediatek.com>
         <20190103044727.i34ak7vw6qfircvq@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190103044727.i34ak7vw6qfircvq@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Rutland <mark.rutland@arm.com>, Fan Chen <fan.chen@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>, James Liao <jamesjj.liao@mediatek.com>, Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2019-01-03 at 10:17 +0530, Viresh Kumar wrote:
> On 02-01-19, 22:09, Henry Chen wrote:
> > Add support for performance state of scpsys on mt8183 platform.
> > 
> > Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> > ---
> >  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > index 47926a7..e396410 100644
> > --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> > @@ -9,6 +9,7 @@
> >  #include <dt-bindings/interrupt-controller/irq.h>
> >  #include <dt-bindings/interrupt-controller/arm-gic.h>
> >  #include <dt-bindings/power/mt8183-power.h>
> > +#include <dt-bindings/soc/mtk,dvfsrc.h>
> >  
> >  / {
> >  	compatible = "mediatek,mt8183";
> > @@ -243,6 +244,26 @@
> >  			      "vpu-3", "vpu-4", "vpu-5";
> >  		infracfg = <&infracfg>;
> >  		smi_comm = <&smi_common>;
> > +		operating-points-v2 = <&dvfsrc_opp_table>;
> > +		dvfsrc_opp_table: opp-table {
> > +			compatible = "operating-points-v2-mtk-level";
> > +
> > +			dvfsrc_vol_min: opp1 {
> > +				mtk,level = <MT8183_DVFSRC_LEVEL_1>;
> > +			};
> > +
> > +			dvfsrc_freq_medium: opp2 {
> > +				mtk,level = <MT8183_DVFSRC_LEVEL_2>;
> > +			};
> > +
> > +			dvfsrc_freq_max: opp3 {
> > +				mtk,level = <MT8183_DVFSRC_LEVEL_3>;
> > +			};
> > +
> > +			dvfsrc_vol_max: opp4 {
> > +				mtk,level = <MT8183_DVFSRC_LEVEL_4>;
> > +			};
> > +		};
> >  	};
> 
> I don't see a patch which makes use of this OPP table using the required-opps
> thing. Where is that ?
> 

Those user drivers of mt8183(e.g. camera, video decoder,...etc) are
still preparing, so I send this RFC series to check if it is feasible
first then they can apply the interface and send for review later.

Henry 
