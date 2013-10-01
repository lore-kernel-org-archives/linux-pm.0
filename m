From: Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>
Subject: Re: [PATCH 3/7] arm: dts: dra7: add bandgap entry
Date: Tue, 1 Oct 2013 17:46:47 -0500
Message-ID: <20131001224645.GC11451@kahuna>
References: <1380652344-18819-1-git-send-email-eduardo.valentin@ti.com>
 <1380652344-18819-4-git-send-email-eduardo.valentin@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1380652344-18819-4-git-send-email-eduardo.valentin-l0cyMroinI0@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
Cc: swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ian.campbell-Sxgqhf6Nn4DQT0dZR+AlfA@public.gmane.org, rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org, linux-0h96xk9xTtrk1uMJSBkQmQ@public.gmane.org, rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lm-sensors-GZX6beZjE8VD60Wz+7aTrA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 14:32-20131001, Eduardo Valentin wrote:
> This patch adds bandgap IP entry on DRA7 dtsi device tree file.
> 
> Signed-off-by: Eduardo Valentin <eduardo.valentin-l0cyMroinI0@public.gmane.org>
> ---
>  arch/arm/boot/dts/dra7.dtsi | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/dra7.dtsi b/arch/arm/boot/dts/dra7.dtsi
> index 3a746c2..4e9b159 100644
> --- a/arch/arm/boot/dts/dra7.dtsi
> +++ b/arch/arm/boot/dts/dra7.dtsi
> @@ -53,6 +53,18 @@
>  		};
>  	};
>  
> +	bandgap: bandgap {
	would you like to follow bandgap: bandgap@4a0021e0 convention?
Also, could you move it under ocp?
I already commented about this previously here: 
https://lkml.org/lkml/2013/9/27/300

> +		reg = <0x4a0021e0 0xc
> +			0x4a00232c 0xc
> +			0x4a002380 0x2c
> +			0x4a0023C0 0x3c
> +			0x4a002564 0x8
> +			0x4a002574 0x50>;
> +		compatible = "ti,dra752-bandgap";
> +		interrupts = <GIC_SPI 126 IRQ_TYPE_LEVEL_HIGH>;
> +		#thermal-sensor-cells = <1>;
> +	};
> +
>  	gic: interrupt-controller@48211000 {
>  		compatible = "arm,cortex-a15-gic";
>  		interrupt-controller;
-- 
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
