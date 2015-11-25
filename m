From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 3/5] dt-bindings: rockchip-thermal: Support the
 RK3228/RK3399 SoCs compatible
Date: Wed, 25 Nov 2015 14:05:39 -0600
Message-ID: <20151125200539.GC30473@rob-hp-laptop>
References: <1448438377-29203-1-git-send-email-wxt@rock-chips.com>
 <1448438377-29203-4-git-send-email-wxt@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1448438377-29203-4-git-send-email-wxt@rock-chips.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Caesar Wang <wxt@rock-chips.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, linux-rockchip@lists.infradead.org, Heiko Stuebner <heiko@sntech.de>, Dan Carpenter <dan.carpenter@oracle.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Kumar Gala <galak@codeaurora.org>, linux-kernel@vger.kernel.org, Ian Campbell <ijc+devicetree@hellion.org.uk>, linux-arm-kernel@lists.infradead.org, Pawel Moll <pawel.moll@arm.com>, Zhang Rui <rui.zhang@intel.com>, Mark Rutland <mark.rutland@arm.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Nov 25, 2015 at 03:59:35PM +0800, Caesar Wang wrote:
> This patchset attempts to new compatible for thermal founding
> on RK3228/RK3399 SoCs.
> 
> Signed-off-by: Caesar Wang <wxt@rock-chips.com>

Acked-by: Rob Herring <robh@kernel.org>

> ---
> 
>  Documentation/devicetree/bindings/thermal/rockchip-thermal.txt | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> index 0dfa60d..af5f802 100644
> --- a/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> +++ b/Documentation/devicetree/bindings/thermal/rockchip-thermal.txt
> @@ -2,8 +2,10 @@
>  
>  Required properties:
>  - compatible : should be "rockchip,<name>-tsadc"
> +   "rockchip,rk3228-tsadc": found on RK3228 SoCs
>     "rockchip,rk3288-tsadc": found on RK3288 SoCs
>     "rockchip,rk3368-tsadc": found on RK3368 SoCs
> +   "rockchip,rk3368-tsadc": found on RK3399 SoCs
>  - reg : physical base address of the controller and length of memory mapped
>  	region.
>  - interrupts : The interrupt number to the cpu. The interrupt specifier format
> -- 
> 1.9.1
> 
