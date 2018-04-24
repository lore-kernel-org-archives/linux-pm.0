From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 4/6] dt-bindings: devfreq: rk3399_dmc: remove interrupts
 as is not required.
Date: Tue, 24 Apr 2018 12:56:33 +0900
Message-ID: <5ADEAAF1.9030901@samsung.com>
References: <20180419104019.24406-1-enric.balletbo@collabora.com>
        <CGME20180419104138epcas2p3e6a9246fa4abddb1ef5e358e8f3e9ee6@epcas2p3.samsung.com>
        <20180419104019.24406-5-enric.balletbo@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20180419104019.24406-5-enric.balletbo@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Enric Balletbo i Serra <enric.balletbo@collabora.com>, myungjoo.ham@samsung.com, kyungmin.park@samsung.com, robh+dt@kernel.org
Cc: devicetree@vger.kernel.org, heiko@sntech.de, linux-pm@vger.kernel.org, dbasehore@chromium.org, linux-kernel@vger.kernel.org, kernel@collabora.com, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On 2018년 04월 19일 19:40, Enric Balletbo i Serra wrote:
> In ATF we already wait for DDR dvfs finish, so don't need to do this in
> kernel, so remove the interrupts properties as is not longer required.
> 
> Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> ---
> 
>  Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> index d83ef821d282..e5307155e901 100644
> --- a/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> +++ b/Documentation/devicetree/bindings/devfreq/rk3399_dmc.txt
> @@ -5,10 +5,6 @@ Required properties:
>  - devfreq-events:	 Node to get DDR loading, Refer to
>  			 Documentation/devicetree/bindings/devfreq/event/
>  			 rockchip-dfi.txt
> -- interrupts:		 The CPU interrupt number. The interrupt specifier
> -			 format depends on the interrupt controller.
> -			 It should be a DCF interrupt. When DDR DVFS finishes
> -			 a DCF interrupt is triggered.
>  - clocks:		 Phandles for clock specified in "clock-names" property
>  - clock-names :		 The name of clock used by the DFI, must be
>  			 "pclk_ddr_mon";
> @@ -172,7 +168,6 @@ Example:
>  	dmc: dmc {
>  		compatible = "rockchip,rk3399-dmc";
>  		devfreq-events = <&dfi>;
> -		interrupts = <GIC_SPI 1 IRQ_TYPE_LEVEL_HIGH>;
>  		clocks = <&cru SCLK_DDRCLK>;
>  		clock-names = "dmc_clk";
>  		operating-points-v2 = <&dmc_opp_table>;
> 

The patch3[1] removes the code related to irq. So, Looks good to me.
[1] "[PATCH 3/6] devfreq: rk3399_dmc: remove wait for dcf irq event."

Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Chanwoo Choi
Samsung Electronics
