From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [RFC RESEND PATCH 4/7] arm64: dts: mt8183: add performance state
 support of scpsys
Date: Thu, 3 Jan 2019 10:17:27 +0530
Message-ID: <20190103044727.i34ak7vw6qfircvq@vireshk-i7>
References: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
 <1546438198-1677-5-git-send-email-henryc.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1546438198-1677-5-git-send-email-henryc.chen@mediatek.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Henry Chen <henryc.chen@mediatek.com>
Cc: Mark Rutland <mark.rutland@arm.com>, James Liao <jamesjj.liao@mediatek.com>, Ulf Hansson <ulf.hansson@linaro.org>, Kees Cook <keescook@chromium.org>, Weiyi Lu <weiyi.lu@mediatek.com>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <vireshk@kernel.org>, linux-kernel@vger.kernel.org, Fan Chen <fan.chen@mediatek.com>, devicetree@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 02-01-19, 22:09, Henry Chen wrote:
> Add support for performance state of scpsys on mt8183 platform.
> 
> Signed-off-by: Henry Chen <henryc.chen@mediatek.com>
> ---
>  arch/arm64/boot/dts/mediatek/mt8183.dtsi | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/mediatek/mt8183.dtsi b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> index 47926a7..e396410 100644
> --- a/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> +++ b/arch/arm64/boot/dts/mediatek/mt8183.dtsi
> @@ -9,6 +9,7 @@
>  #include <dt-bindings/interrupt-controller/irq.h>
>  #include <dt-bindings/interrupt-controller/arm-gic.h>
>  #include <dt-bindings/power/mt8183-power.h>
> +#include <dt-bindings/soc/mtk,dvfsrc.h>
>  
>  / {
>  	compatible = "mediatek,mt8183";
> @@ -243,6 +244,26 @@
>  			      "vpu-3", "vpu-4", "vpu-5";
>  		infracfg = <&infracfg>;
>  		smi_comm = <&smi_common>;
> +		operating-points-v2 = <&dvfsrc_opp_table>;
> +		dvfsrc_opp_table: opp-table {
> +			compatible = "operating-points-v2-mtk-level";
> +
> +			dvfsrc_vol_min: opp1 {
> +				mtk,level = <MT8183_DVFSRC_LEVEL_1>;
> +			};
> +
> +			dvfsrc_freq_medium: opp2 {
> +				mtk,level = <MT8183_DVFSRC_LEVEL_2>;
> +			};
> +
> +			dvfsrc_freq_max: opp3 {
> +				mtk,level = <MT8183_DVFSRC_LEVEL_3>;
> +			};
> +
> +			dvfsrc_vol_max: opp4 {
> +				mtk,level = <MT8183_DVFSRC_LEVEL_4>;
> +			};
> +		};
>  	};

I don't see a patch which makes use of this OPP table using the required-opps
thing. Where is that ?

-- 
viresh
