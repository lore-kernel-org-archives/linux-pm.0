From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v5 6/8] Documentation: bindings: add dt documentation for
 rk3399 dmc
Date: Wed, 10 Aug 2016 13:38:02 +0900
Message-ID: <57AAAFAA.8060200@samsung.com>
References: <1470799604-12877-1-git-send-email-hl@rock-chips.com>
 <CGME20160810033623epcas1p2f57a2c6060ad8ba062751d133bd8afec@epcas1p2.samsung.com>
 <1470799604-12877-7-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:34164 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750877AbcHJEiF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Aug 2016 00:38:05 -0400
In-reply-to: <1470799604-12877-7-git-send-email-hl@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lin Huang <hl@rock-chips.com>, heiko@sntech.de
Cc: myungjoo.ham@samsung.com, mark.yao@rock-chips.com, airlied@linux.ie, mturquette@baylibre.com, dbasehore@chromium.org, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, dianders@chromium.org, linux-rockchip@lists.infradead.org, kyungmin.park@samsung.com, linux-arm-kernel@lists.infradead.org, tixy@linaro.org, typ@rock-chips.com, sudeep.holla@arm.com, mark.rutland@arm.com, linux-pm@vger.kernel.org

Hi Lin,

On 2016년 08월 10일 12:26, Lin Huang wrote:
> This patch adds the documentation for rockchip rk3399 dmc driver.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v5:
> -None
> 
> Changes in v4:
> -None
> 
> Changes in v3:
> -None
> 
> Changes in v2:
> -None 
> 
> Changes in v1:
> -None
> 
>  .../devicetree/bindings/devfreq/rk3399_dmc.txt     | 35 ++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> new file mode 100644
> index 0000000..90e9581
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> @@ -0,0 +1,35 @@
> +* Rockchip rk3399 dmc device

dmc -> DMC(Dynamic Memory Controller ?)

> +
> +Required properties:
> +- compatible: Must be "rockchip,rk3399-dmc".
> +- devfreq-events: Node to get ddr loading, Refer to
> +		  Documentation/devicetree/bindings/devfreq/rockchip-dif.txt
> +- interrupts: The interrupt number to the cpu. The interrupt specifier format
> +	      depends on the interrupt controller. 

If you add the specific role of this interrupt, it would be better
to understand the operation of interrupt.

> +- clocks: Phandles for clock specified in "clock-names" property
> +- clock-names : The name of clock used by the DFI, must be "pclk_ddr_mon";

"pclk_ddr_mon" -> "dmc_clk"

> +- operating-points-v2: Refer to Documentation/devicetree/bindings/power/opp.txt
> +		       for details.
> +- center-supply: Dmc supply node.
> +- status: Marks the node enabled/disabled.
> +
> +Optional properties:
> +- ddr_timing: ddr timing need to pass to arm trust firmware
> +- upthreshold: the upthreshold to simpleondeamnd policy
> +- downdifferential: The downdifferential to simpleondeamnd policy
> +
> +Example:
> +	dmc: dmc {
> +		compatible = "rockchip,rk3399-dmc";
> +		devfreq-events = <&dfi>;
> +		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
> +		clocks = <&cru SCLK_DDRCLK>;
> +		clock-names = "dmc_clk";
> +		ddr_timing = <&ddr_timing>;

I think that you should add the detailed document for 
'ddr_timing' because we don't understand the 'ddr_timing' easily
, it depends on the trust firmware.

> +		operating-points-v2 = <&dmc_opp_table>;

I think that you better to add the example of 'dmc_opp_table' 
in the documentation.

> +		center-supply = <&ppvar_centerlogic>;
> +		upthreshold = <15>;
> +		downdifferential = <10>;
> +		status = "disabled";
> +	};
> +
> 

Regards,
Chanwoo Choi
