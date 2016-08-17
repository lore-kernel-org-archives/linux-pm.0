From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH v6 4/8] Documentation: bindings: add dt documentation for
 dfi controller
Date: Wed, 17 Aug 2016 09:31:40 +0900
Message-ID: <57B3B06C.1040109@samsung.com>
References: <1471386989-9541-1-git-send-email-hl@rock-chips.com>
 <CGME20160816223902epcas1p1c7f4bd3bfcc7081cc741392bf6a4afe3@epcas1p1.samsung.com>
 <1471386989-9541-5-git-send-email-hl@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1471386989-9541-5-git-send-email-hl@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lin Huang <hl@rock-chips.com>, heiko@sntech.de, myungjoo.ham@samsung.com
Cc: tixy@linaro.org, mark.rutland@arm.com, typ@rock-chips.com, linux-rockchip@lists.infradead.org, airlied@linux.ie, mturquette@baylibre.com, dbasehore@chromium.org, sboyd@codeaurora.org, linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, dianders@chromium.org, kyungmin.park@samsung.com, sudeep.holla@arm.com, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, mark.yao@rock-chips.com
List-Id: linux-pm@vger.kernel.org

Hi Lin,

I add one minor comment.

After fixing it, looks good to me.
Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

On 2016년 08월 17일 07:36, Lin Huang wrote:
> This patch adds the documentation for rockchip dfi devfreq-event driver.
> 
> Signed-off-by: Lin Huang <hl@rock-chips.com>
> ---
> Changes in v6:
> -None
> 
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
>  .../bindings/devfreq/event/rockchip-dfi.txt          | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> new file mode 100644
> index 0000000..bf42255
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/devfreq/event/rockchip-dfi.txt
> @@ -0,0 +1,20 @@
> +
> +* Rockchip rk3399 DFI device
> +
> +Required properties:
> +- compatible: Must be "rockchip,rk3399-dfi".
> +- reg: physical base address of each DFI and length of memory mapped region
> +- rockchip,pmu: phandle to the syscon managing the "pmu general register files"
> +- clocks: phandles for clock specified in "clock-names" property
> +- clock-names : the name of clock used by the DFI, must be "pclk_ddr_mon";
> +
> +Example:
> +	dfi: dfi@0xff630000 {
> +		reg = <0x00 0xff630000 0x00 0x4000>;
> +		compatible = "rockchip,rk3399-dfi";
> +		rockchip,pmu = <&pmugrf>;
> +		clocks = <&cru PCLK_DDR_MON>;
> +		clock-names = "pclk_ddr_mon";
> +		status = "disabled";
> +	};
> +

Remove the blank line.

Thanks,
Chanwoo Choi
