From: Wei Xu <xuwei5@hisilicon.com>
Subject: Re: [PATCH 25/25] arm64: dts: Register Hi3660's thermal sensor
Date: Fri, 13 Oct 2017 09:49:54 +0100
Message-ID: <59E07E32.6050700@hisilicon.com>
References: <79a5f10c-0fb7-3e4f-caac-c1625904b137@linaro.org>
 <1507658570-32675-1-git-send-email-daniel.lezcano@linaro.org>
 <1507658570-32675-25-git-send-email-daniel.lezcano@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:8441 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751762AbdJMIvE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 13 Oct 2017 04:51:04 -0400
In-Reply-To: <1507658570-32675-25-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, kevin.wangtao@linaro.org, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, "moderated list:ARM/HISILICON SOC SUPPORT" <linux-arm-kernel@lists.infradead.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>

Hi Daniel,

On 2017/10/10 19:02, Daniel Lezcano wrote:
> From: Kevin Wangtao <kevin.wangtao@linaro.org>
> 
> Add binding for tsensor on H3660, this tsensor is used for
> SoC thermal control, it supports alarm interrupt.
> 
> Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> ---

Applied this and 23rd into hisilicon dt tree.
Thanks!

BR,
Wei

>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index c6a1961..d9c0cf3 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -848,5 +848,13 @@
>  				     &sdio_cfg_func>;
>  			status = "disabled";
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
