From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 9/9] arm64: dts: register Hi3660's thermal sensor
Date: Mon, 2 Oct 2017 21:06:00 +0200
Message-ID: <f83a0936-23cc-0f5e-b6a3-c3adf1a0d7a0@linaro.org>
References: <1506073332-92438-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1506073332-92438-10-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f50.google.com ([74.125.82.50]:53725 "EHLO
        mail-wm0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751062AbdJBTGF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 2 Oct 2017 15:06:05 -0400
Received: by mail-wm0-f50.google.com with SMTP id q132so12530436wmd.2
        for <linux-pm@vger.kernel.org>; Mon, 02 Oct 2017 12:06:05 -0700 (PDT)
In-Reply-To: <1506073332-92438-10-git-send-email-kevin.wangtao@hisilicon.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tao Wang <kevin.wangtao@hisilicon.com>, rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com
Cc: leo.yan@linaro.org, lonela.Voinescu@arm.com, Valentin.Schneider@arm.com, vincent.guittot@linaro.org, sunzhaosheng@hisilicon.com, gengyanping@hisilicon.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Kevin Wangtao <kevin.wangtao@linaro.org>

On 22/09/2017 11:42, Tao Wang wrote:
> From: Kevin Wangtao <kevin.wangtao@linaro.org>
> 
> add binding for tsensor on H3660, this tsensor is used for
> SoC thermal control, it supports alarm interrupt.
> 
> Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>

I'm not able to apply this patch. Does it rely on another patch?

> ---
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index b7a90d6..ae90991 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -978,5 +978,13 @@
>  			clocks = <&crg_ctrl HI3660_OSC32K>;
>  			clock-names = "apb_pclk";
>  		};
> +
> +		tsensor: tsensor@fff30000 {
> +			compatible = "hisilicon,hi3660-tsensor";
> +			reg = <0x0 0xfff30000 0x0 0x1000>;
> +			interrupts = <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
> +			#thermal-sensor-cells = <1>;
> +		};
> +
>  	};
>  };
> 


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
