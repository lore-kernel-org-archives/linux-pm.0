From: Caesar Wang <wxt@rock-chips.com>
Subject: Re: [PATCH 1/5] dt-bindings: rockchip-thermal: Support the RV1108 SoC
 compatible
Date: Fri, 15 Sep 2017 09:49:11 +0800
Message-ID: <12073627-41af-3480-6379-839e07f5e8f3@rock-chips.com>
References: <1503570475-7850-1-git-send-email-rocky.hao@rock-chips.com>
 <1503570475-7850-2-git-send-email-rocky.hao@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.135]:59441 "EHLO
        regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751781AbdIOBt7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 14 Sep 2017 21:49:59 -0400
In-Reply-To: <1503570475-7850-2-git-send-email-rocky.hao@rock-chips.com>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rocky Hao <rocky.hao@rock-chips.com>
Cc: rui.zhang@intel.com, edubezval@gmail.com, heiko@sntech.de, robh+dt@kernel.org, mark.rutland@arm.com, catalin.marinas@arm.com, will.deacon@arm.com, huangtao@rock-chips.com, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, shawn.lin@rock-chips.com, linux-kernel@vger.kernel.org, linux-rockchip@lists.infradead.org, cl@rock-chips.com, william.wu@rock-chips.com, jay.xu@rock-chips.com, xxx@rock-chips.com, linux-arm-kernel@lists.infradead.org, wxt@rock-chips.com

Hi Rocky,

在 2017年08月24日 18:27, Rocky Hao 写道:
> Add a new compatible for thermal founding on RV1108 SoCs.
>
> Signed-off-by: Rocky Hao <rocky.hao@rock-chips.com>
> ---
>   Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> index e3a6234fb1ac..43d744e5305e 100644
> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> @@ -2,6 +2,7 @@
>   
>   Required properties:
>   - compatible : should be "rockchip,<name>-tsadc"
> +   "rockchip,rv1108-tsadc": found on RV1108 SoCs

According to the order,  we should put the string after the 
"rockchip,rk3399-tsadc"..., not here.
>      "rockchip,rk3228-tsadc": found on RK3228 SoCs
>      "rockchip,rk3288-tsadc": found on RK3288 SoCs
>      "rockchip,rk3328-tsadc": found on RK3328 SoCs
