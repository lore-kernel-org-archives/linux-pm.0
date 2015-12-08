From: Khiem Nguyen <khiem.nguyen.xt-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>
Subject: Re: [PATCH 6/8 v3] ARM: shmobile: r8a7790: enable to use thermal-zone
Date: Tue, 8 Dec 2015 10:06:45 +0700
Message-ID: <56664945.9070707@rvc.renesas.com>
References: <87y4d6672t.wl%kuninori.morimoto.gx@renesas.com> <87poyi66yt.wl%kuninori.morimoto.gx@renesas.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87poyi66yt.wl%kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
Cc: Simon <horms-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>, Magnus <magnus.damm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, "linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-sh-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Khiem Nguyen <khiem.nguyen.xt-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>, "Hien Duy. Dang" <hien.dang.eb-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>, Toru Oishi <toru.oishi.zj-NdPGGYSbX7otW8iMtHSHnA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Morimoto-san,

Thanks for your patch.

On 12/7/2015 2:44 PM, Kuninori Morimoto wrote:
>
> From: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
>
> This patch enables to use thermal-zone on r8a7790.
> This thermal sensor can measure temperature from -40000 to 125000,
> but over 117000 can be critical on this chip.
> Thus, default critical temperature is now set as 115000 (this driver
> is using 5000 steps) (Current critical temperature is using it as
> 90000, but there is no big reason about it)
>
> And it doesn't check thermal zone periodically (same as current
> behavior). You can exchange it by modifing polling-delay[-passive]

modifing -> modifying

> property.
>
> You can set trip temp if your kernel has CONFIG_THERMAL_WRITABLE_TRIPS,
> but you need to take care to use it, since it will call
> orderly_poweroff() it it reached to the value.

if it reaches

> echo $temp > /sys/class/thermal/thermal_zone0/trip_point_0_temp
>
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx-zM6kxYcvzFBBDgjK7y7TUQ@public.gmane.org>
> ---
> v2 -> v3
>
>   - compatible "renesas,rcar-thermal-gen2" -> "renesas,rcar-gen2-thermal"
>
>   arch/arm/boot/dts/r8a7790.dtsi | 26 ++++++++++++++++++++++++--
>   1 file changed, 24 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm/boot/dts/r8a7790.dtsi b/arch/arm/boot/dts/r8a7790.dtsi
> index 6cfd0dc..49aaa67 100644
> --- a/arch/arm/boot/dts/r8a7790.dtsi
> +++ b/arch/arm/boot/dts/r8a7790.dtsi
> @@ -112,6 +112,25 @@
>   		};
>   	};
>
> +	thermal-zones {
> +		cpu_thermal: cpu-thermal {
> +			polling-delay-passive	= <0>;
> +			polling-delay		= <0>;
> +
> +			thermal-sensors = <&thermal>;
> +
> +			trips {
> +				cpu-crit {
> +					temperature	= <1150000>;

One zero is redundant here. It should be 115000.

> +					hysteresis	= <0>;
> +					type		= "critical";
> +				};
> +			};
> +			cooling-maps {
> +			};
> +		};
> +	};
> +
>   	gic: interrupt-controller@f1001000 {
>   		compatible = "arm,gic-400";
>   		#interrupt-cells = <3>;
> @@ -202,12 +221,15 @@
>   		power-domains = <&cpg_clocks>;
>   	};
>
> -	thermal@e61f0000 {
> -		compatible = "renesas,thermal-r8a7790", "renesas,rcar-thermal";
> +	thermal: thermal@e61f0000 {
> +		compatible =	"renesas,thermal-r8a7790",
> +				"renesas,rcar-gen2-thermal",
> +				"renesas,rcar-thermal";
>   		reg = <0 0xe61f0000 0 0x14>, <0 0xe61f0100 0 0x38>;
>   		interrupts = <0 69 IRQ_TYPE_LEVEL_HIGH>;
>   		clocks = <&mstp5_clks R8A7790_CLK_THERMAL>;
>   		power-domains = <&cpg_clocks>;
> +		#thermal-sensor-cells = <0>;
>   	};
>
>   	timer {
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
