From: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [RFC PATCH v12 5/5] arm64: dts: rockchip: Move PCIe WAKE# irq to
 pcie port for Gru
Date: Fri, 29 Dec 2017 09:55:39 -0800
Message-ID: <20171229175539.GK3875@atomide.com>
References: <20171226023646.17722-1-jeffy.chen@rock-chips.com>
 <20171226023646.17722-6-jeffy.chen@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20171226023646.17722-6-jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, bhelgaas-hpIqsD4AKlfQT0dZR+AlfA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, shawn.lin-TNX95d0MmH7DzftRWevZcw@public.gmane.org, briannorris-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org, dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org, Matthias Kaehlcke <mka-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Klaus Goger <klaus.goger-SN7IsUiht6C/RdPyistoZJqQE7yCjDx5@public.gmane.org>, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

* Jeffy Chen <jeffy.chen-TNX95d0MmH7DzftRWevZcw@public.gmane.org> [171226 02:41]:
> Currently we are handling PCIe WAKE# irq in mrvl wifi driver.
> 
> Move it to rockchip pcie port since we are going to handle it in the
> pci core.

Yes in the PCIe case, the pcie port node is the right place for
the wakeirq instead of the child the mvl_wifi node. So one
question further down below to verify this..

> Also avoid this irq been considered as the PCI interrupt pin in the
> of_irq_parse_pci().

The above paragraph needs a bit more clarification to be
readable :)

> --- a/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3399-gru.dtsi
> @@ -719,15 +719,16 @@ ap_i2c_audio: &i2c8 {
>  		#size-cells = <2>;
>  		ranges;
>  
> +		interrupts-extended = <&pcie0 1>, <&gpio0 8 IRQ_TYPE_LEVEL_LOW>;
> +		interrupt-names = "pci", "wakeup";
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&wlan_host_wake_l>;
> +		wakeup-source;
> +
>  		mvl_wifi: wifi@0,0 {
>  			compatible = "pci1b4b,2b42";
>  			reg = <0x83010000 0x0 0x00000000 0x0 0x00100000
>  			       0x83010000 0x0 0x00100000 0x0 0x00100000>;
> -			interrupt-parent = <&gpio0>;
> -			interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&wlan_host_wake_l>;
> -			wakeup-source;
>  		};
>  	};
>  };

So the above modifies pcie@0,0 node. And that node describes
the particular PCIe port that the WLAN is connected to instead
of describing the whole PCIe controller device, right?

If so, then yeah it's totally where the wakeirq should be
defined for a PCIe device in the dts file :)

Regards,

Tony
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
