From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v2 2/4] ARM: dts: pxa: add pxa25x cpu operating points
Date: Tue, 18 Oct 2016 17:09:44 +0530
Message-ID: <20161018113944.GC11471@vireshk-i7>
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
 <1476561450-28407-3-git-send-email-robert.jarzmik@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1476561450-28407-3-git-send-email-robert.jarzmik-GANU6spQydw@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
Cc: Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 15-10-16, 21:57, Robert Jarzmik wrote:
> Add the relevant data taken from the PXA 25x Electrical, Mechanical, and
> Thermal Specfication. This will be input data for cpufreq-dt driver.
> 
> Signed-off-by: Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>
> ---
>  arch/arm/boot/dts/pxa25x.dtsi | 25 +++++++++++++++++++++++++
>  1 file changed, 25 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/pxa25x.dtsi b/arch/arm/boot/dts/pxa25x.dtsi
> index 0d1e012178c4..16b4e8bad4a5 100644
> --- a/arch/arm/boot/dts/pxa25x.dtsi
> +++ b/arch/arm/boot/dts/pxa25x.dtsi
> @@ -89,4 +89,29 @@
>  		clocks = <&clktimer>;
>  		status = "okay";
>  	};
> +
> +	pxa250_opp_table: opp_table0 {
> +		compatible = "operating-points-v2";
> +
> +		opp@99500 {

We have been keeping the values in ^^^ same as the values present
below. Any specific reason for making it different here ?

> +			opp-hz = /bits/ 64 <99532800>;
> +			opp-microvolt = <950000 1000000 1650000>;
> +			clock-latency-ns = <20>;
> +		};
> +		opp@199100 {
> +			opp-hz = /bits/ 64 <199065600>;
> +			opp-microvolt = <1000000 950000 1650000>;
> +			clock-latency-ns = <20>;
> +		};
> +		opp@298600 {
> +			opp-hz = /bits/ 64 <298598400>;
> +			opp-microvolt = <1100000 1045000 1650000>;
> +			clock-latency-ns = <20>;
> +		};
> +		opp@398100 {
> +			opp-hz = /bits/ 64 <398131200>;
> +			opp-microvolt = <1300000 1235000 1650000>;
> +			clock-latency-ns = <20>;
> +		};
> +	};
>  };
> -- 
> 2.1.4

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
