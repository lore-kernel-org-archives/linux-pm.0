From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: Re: [PATCH v3 4/4] ARM64: dts: rockchip: add syscon-reboot-mode DT
 node
Date: Wed, 3 Feb 2016 10:07:50 +0800
Message-ID: <56B160F6.20308@rock-chips.com>
References: <1454406981-4692-1-git-send-email-andy.yan@rock-chips.com>
 <1454407999-5476-1-git-send-email-andy.yan@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lucky1.263xmail.com ([211.157.147.130]:54126 "EHLO
	lucky1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755216AbcBCCIF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 2 Feb 2016 21:08:05 -0500
In-Reply-To: <1454407999-5476-1-git-send-email-andy.yan@rock-chips.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andy Yan <andy.yan@rock-chips.com>, john.stultz@linaro.org
Cc: robh+dt@kernel.org, arnd@arndb.de, shawn.lin@rock-chips.com, mark.rutland@arm.com, heiko@sntech.de, catalin.marinas@arm.com, will.deacon@arm.com, linux-kernel@vger.kernel.org, alexandre.belloni@free-electrons.com, lorenzo.pieralisi@arm.com, linux@arm.linux.org.uk, dbaryshkov@gmail.com, richard@nod.at, linux-pm@vger.kernel.org, linux-rockchip@lists.infradead.org, wxt@rock-chips.com, devicetree@vger.kernel.org, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, matthias.bgg@gmail.com, linux-arm-kernel@lists.infradead.org, moritz.fischer@ettus.com, mbrugger@suse.com, sre@kernel.org, galak@codeaurora.org, jun.nie@linaro.org, dwmw2@infradead.org

On 2016/2/2 18:13, Andy Yan wrote:
> Add syscon-reboot-mode driver DT node for rk3368 platform
>
> Signed-off-by: Andy Yan <andy.yan@rock-chips.com>
>

Work fine with my rk3368-sheep board :)

Tested-by: Shawn Lin <shawn.lin@rock-chips.com>

> ---
>
> Changes in v3:
> - descirbe all reboot mode as property instead of subnode
>
> Changes in v2:
> - make this node as a subnode of pmugrf
>
> Changes in v1: None
>
>   arch/arm64/boot/dts/rockchip/rk3368.dtsi | 14 +++++++++++++-
>   1 file changed, 13 insertions(+), 1 deletion(-)
>
> diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> index 122777b..5213713 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
> @@ -45,6 +45,7 @@
>   #include <dt-bindings/interrupt-controller/irq.h>
>   #include <dt-bindings/interrupt-controller/arm-gic.h>
>   #include <dt-bindings/pinctrl/rockchip.h>
> +#include <dt-bindings/soc/rockchip_boot-mode.h>
>   #include <dt-bindings/thermal/thermal.h>
>
>   / {
> @@ -554,8 +555,19 @@
>   	};
>
>   	pmugrf: syscon@ff738000 {
> -		compatible = "rockchip,rk3368-pmugrf", "syscon";
> +		compatible = "rockchip,rk3368-pmugrf", "syscon", "simple-mfd";
>   		reg = <0x0 0xff738000 0x0 0x1000>;
> +
> +		reboot-mode {
> +			compatible = "syscon-reboot-mode";
> +			offset = <0x200>;
> +			mode-normal = <BOOT_NORMAL>;
> +			mode-recovery = <BOOT_RECOVERY>;
> +			mode-fastboot = <BOOT_FASTBOOT>;
> +			mode-loader = <BOOT_LOADER>;
> +			mode-maskrom = <BOOT_MASKROM>;
> +
> +		};
>   	};
>
>   	cru: clock-controller@ff760000 {
>


-- 
Best Regards
Shawn Lin

