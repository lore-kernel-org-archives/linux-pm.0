From: Brian Norris <briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Subject: Re: [PATCH v7 3/3] arm64: dts: rockchip: Handle pcie wake in pcie
 driver for Gru
Date: Mon, 23 Oct 2017 18:27:46 -0700
Message-ID: <20171024012744.GA103893@google.com>
References: <20171019111007.25234-1-jeffy.chen@rock-chips.com>
 <20171019111007.25234-4-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171019111007.25234-4-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Klaus Goger <klaus.goger-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Caesar Wang <wxt-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

+ linux-pm

On Thu, Oct 19, 2017 at 07:10:07PM +0800, Jeffy Chen wrote:
> Currently we are handling pcie wake irq in mrvl wifi driver.
> Move it to rockchip pcie driver for Gru boards.

It might be worth documenting one of the reasons for this patch, which
I'll comment on below:

> Signed-off-by: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
> ---
> 
> Changes in v7: None
> Changes in v6: None
> Changes in v5:
> Use "wakeup" instead of "wake"
> 
> Changes in v3: None
> Changes in v2: None
> 
>  arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> index 470105d651c2..04499714f541 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> @@ -708,7 +708,15 @@ ap_i2c_audio: &i2c8 {
>  
>  	ep-gpios = <&gpio2 27 GPIO_ACTIVE_HIGH>;
>  	pinctrl-names = "default";
> -	pinctrl-0 = <&pcie_clkreqn_cpm>, <&wifi_perst_l>;
> +	pinctrl-0 = <&pcie_clkreqn_cpm>, <&wlan_host_wake_l>, <&wifi_perst_l>;
> +
> +	interrupts-extended = <&gic GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH 0>,
> +			      <&gic GIC_SPI 50 IRQ_TYPE_LEVEL_HIGH 0>,
> +			      <&gic GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH 0>,
> +			      <&gpio0 8 IRQ_TYPE_LEVEL_LOW>;
> +	interrupt-names = "sys", "legacy", "client", "wakeup";
> +	/delete-property/ interrupts;
> +
>  	vpcie3v3-supply = <&pp3300_wifi_bt>;
>  	vpcie1v8-supply = <&wlan_pd_n>; /* HACK: see &wlan_pd_n */
>  	vpcie0v9-supply = <&pp900_pcie>;
> @@ -723,11 +731,6 @@ ap_i2c_audio: &i2c8 {
>  			compatible = "pci1b4b,2b42";
>  			reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
>  			       0x83010000 0x0 0x00100000 0x0 0x00100000>;
> -			interrupt-parent = <&gpio0>;
> -			interrupts = <8 IRQ_TYPE_LEVEL_LOW>;

One of the problems here is that this is a definition for a WAKE#
interrupt, not for a legacy INTx interrupt. So this creates a conflict
when both of these happen:

(a) the PCI bus sets up this interrupt for use as INTx support (as a
    shared interrupt), instead of using the actual PCI controller
    interrupt and
(b) the mwifiex driver requests this interrupt as a non-shared wake
    interrupt, and fails to get it (and so fails to probe).

IOW, non-MSI interrupts are broken today on these devices. Jeffy's patch
fixes that.

If we want to support something like the existing binding, we should
clarify/update
Documentation/devicetree/bindings/net/wireless/marvell-8xxx.txt.
Personally, I would just declare that binding invalid for the PCI
version. (It might still be valid for SDIO.)

Also, if for some reason we *do* want WAKE# handling to be supported on
a per-device basis (part of the discussion on patch 1), we should look
at extending the existing PCI interrupt bindings in a way that doesn't
break legacy interrupts.

Brian

> -			pinctrl-names = "default";
> -			pinctrl-0 = <&wlan_host_wake_l>;
> -			wakeup-source;
>  		};
>  	};
>  };
> -- 
> 2.11.0
> 
> 
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
