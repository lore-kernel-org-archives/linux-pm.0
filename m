From: Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>
Subject: Re: [PATCH 4/5] ARM: sun8i: h3: add operating-points-v2
 table for CPU
Date: Tue, 11 Apr 2017 11:13:46 +0200
Message-ID: <20170411091346.mcwyskezadabsobn@lukather>
References: <20170408185025.53841-1-icenowy@aosc.io>
 <20170408185025.53841-5-icenowy@aosc.io>
Reply-To: maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ugizphasj3wc7vbe"
Return-path: <linux-sunxi+bncBDSJBYGBRIMBBVN4WLDQKGQETKAHQNY-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
Sender: linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
Content-Disposition: inline
In-Reply-To: <20170408185025.53841-5-icenowy-h8G6r0blFSE@public.gmane.org>
List-Post: <https://groups.google.com/group/linux-sunxi/post>, <mailto:linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Help: <https://groups.google.com/support/>, <mailto:linux-sunxi+help-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Archive: <https://groups.google.com/group/linux-sunxi
List-Subscribe: <https://groups.google.com/group/linux-sunxi/subscribe>, <mailto:linux-sunxi+subscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>
List-Unsubscribe: <mailto:googlegroups-manage+1076902468213+unsubscribe-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org>,
 <https://groups.google.com/group/linux-sunxi/subscribe>
To: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
Cc: Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, Quentin Schulz <quentin.schulz-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-clk-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-sunxi-/JYPxA39Uh5TLH3MbocFFw@public.gmane.org
List-Id: linux-pm@vger.kernel.org


--ugizphasj3wc7vbe
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline

On Sun, Apr 09, 2017 at 02:50:24AM +0800, Icenowy Zheng wrote:
> The CPU on Allwinner H3 can do dynamic frequency scaling.
> 
> Add a DVFS table based on the one tweaked by Armbian developers, which
> are proven to work stably on BSP kernels.
> 
> Frequencies higher than 1008MHz are temporarily dropped in the table, as
> they may lead to over voltage on boards without proper regulator
> settings or over temperature on boards with proper regulator settings.
> They will be added back once regulator settings are ready and thermal
> sensor driver is merged.
> 
> In order to satisfy all different regulators (SY8106A which is 50mV per
> level, SY8113B which have two states: 1.1V and 1.3V, and some board with
> non-tweakable regulators), all the OPPs are defined with a range which has
> the target value as the minimum allowed value, and 1.3V (the highest
> VDD-CPUX voltage suggested by the datasheet) as the maximum allowed value.
> It's proven to work well with a board with SY8113B.
> 
> Signed-off-by: Icenowy Zheng <icenowy-h8G6r0blFSE@public.gmane.org>
> ---
>  arch/arm/boot/dts/sun8i-h3.dtsi | 38 +++++++++++++++++++++++++++++++++++++-
>  1 file changed, 37 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sun8i-h3.dtsi b/arch/arm/boot/dts/sun8i-h3.dtsi
> index b36f9f423c39..a0cee17fe44b 100644
> --- a/arch/arm/boot/dts/sun8i-h3.dtsi
> +++ b/arch/arm/boot/dts/sun8i-h3.dtsi
> @@ -43,32 +43,68 @@
>  #include "sunxi-h3-h5.dtsi"
>  
>  / {
> +	cpu0_opp_table: opp_table0 {
> +		compatible = "operating-points-v2";
> +		opp-shared;
> +
> +		opp@480000000 {
> +			opp-hz = /bits/ 64 <480000000>;
> +			opp-microvolt = <980000 980000 1300000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@648000000 {
> +			opp-hz = /bits/ 64 <816000000>;
> +			opp-microvolt = <1020000 1020000 1300000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@912000000 {
> +			opp-hz = /bits/ 64 <960000000>;
> +			opp-microvolt = <1080000 1080000 1300000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +
> +		opp@1008000000 {
> +			opp-hz = /bits/ 64 <1008000000>;
> +			opp-microvolt = <1140000 1140000 1300000>;
> +			clock-latency-ns = <244144>; /* 8 32k periods */
> +		};
> +	};
> +

>From your serie, I guess you never actually tested those OPPs on any
board without SY8113B, right?

(and therefore, without operating at the voltages listed here).

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
--ugizphasj3wc7vbe--
