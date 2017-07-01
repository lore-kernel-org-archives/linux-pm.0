From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [Patch v2 3/3] arm64: dts: register Hi3660's thermal sensor
Date: Fri, 30 Jun 2017 20:06:14 -0700
Message-ID: <20170701030613.GC11424@localhost.localdomain>
References: <1497930035-60894-3-git-send-email-kevin.wangtao@hisilicon.com>
 <1498102923-68481-1-git-send-email-kevin.wangtao@hisilicon.com>
 <1498102923-68481-3-git-send-email-kevin.wangtao@hisilicon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:35202 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751994AbdGADGU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jun 2017 23:06:20 -0400
Content-Disposition: inline
In-Reply-To: <1498102923-68481-3-git-send-email-kevin.wangtao@hisilicon.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tao Wang <kevin.wangtao@hisilicon.com>
Cc: rui.zhang@intel.com, robh+dt@kernel.org, mark.rutland@arm.com, xuwei5@hisilicon.com, catalin.marinas@arm.com, will.deacon@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, sunzhaosheng@hisilicon.com, leo.yan@linaro.org

On Thu, Jun 22, 2017 at 11:42:03AM +0800, Tao Wang wrote:
> Bind thermal sensor driver for Hi3660.
> 
> Signed-off-by: Tao Wang <kevin.wangtao@hisilicon.com>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
> Changes in v2:
> - rebase changes on linux next
> 
>  arch/arm64/boot/dts/hisilicon/hi3660.dtsi |    6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> index c6a1961..a6a1e01 100644
> --- a/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> +++ b/arch/arm64/boot/dts/hisilicon/hi3660.dtsi
> @@ -848,5 +848,11 @@
>  				     &sdio_cfg_func>;
>  			status = "disabled";
>  		};
> +
> +		tsensor: tsensor {
> +			compatible = "hisilicon,hi3660-thermal";
> +			reg = <0x0 0xfff30000 0x0 0x1000>;
> +			#thermal-sensor-cells = <1>;
> +		};

Are you planning to also add thermal zone entries?

>  	};
>  };
> -- 
> 1.7.9.5
> 
