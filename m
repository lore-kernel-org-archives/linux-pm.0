From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v1 2/3] dt-bindings: rockchip-thermal: Support the PX30
 SoC compatible
Date: Thu, 4 Apr 2019 05:04:24 +0200
Message-ID: <54ec9ef5-5295-4ea0-2d61-e386609cd993@linaro.org>
References: <1554100985-11385-1-git-send-email-zhangqing@rock-chips.com>
 <1554100985-11385-3-git-send-email-zhangqing@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1554100985-11385-3-git-send-email-zhangqing@rock-chips.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Elaine Zhang <zhangqing@rock-chips.com>, heiko@sntech.de
Cc: rui.zhang@intel.com, edubezval@gmail.com, robh+dt@kernel.org, mark.rutland@arm.com, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, xxx@rock-chips.com, xf@rock-chips.com, huangtao@rock-chips.com
List-Id: linux-pm@vger.kernel.org

On 01/04/2019 08:43, Elaine Zhang wrote:
> Add a new compatible for thermal founding on PX30 SoCs.
> 
> Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
> ---
>  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> index 43d744e5305e..c6aac9bcacf1 100644
> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> @@ -2,6 +2,7 @@
>  
>  Required properties:
>  - compatible : should be "rockchip,<name>-tsadc"
> +   "rockchip,px30-tsadc":   found on PX30 SoCs
>     "rockchip,rv1108-tsadc": found on RV1108 SoCs
>     "rockchip,rk3228-tsadc": found on RK3228 SoCs
>     "rockchip,rk3288-tsadc": found on RK3288 SoCs

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>


-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
