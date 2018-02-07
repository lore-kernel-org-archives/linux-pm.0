From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [Query] thermal: Who is using "cooling-{min|max}-level}"
 properties ?
Date: Wed, 7 Feb 2018 15:54:46 +0530
Message-ID: <20180207102446.GS28462@vireshk-i7>
References: <20180207065959.GN28462@vireshk-i7>
 <c7bd6ed5-b93e-3a07-b4a2-4c3b1eef5fac@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <c7bd6ed5-b93e-3a07-b4a2-4c3b1eef5fac-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Punit.Agrawal-5wv7dgnIgG8@public.gmane.org, ionela.voinescu-5wv7dgnIgG8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 07-02-18, 11:04, Daniel Lezcano wrote:
> Yeah, this is a bit fuzzy. There are still cooling-{min|max}-*state*
> definitions in the DTs
> 
> Documentation/devicetree/bindings/hwmon/pwm-fan.txt:
> cooling-min-state = <0>;
> arch/arm/boot/dts/exynos4412-odroidu3.dts:
> cooling-min-state = <0>;
> arch/arm/boot/dts/exynos5410-odroidxu.dts:
> cooling-min-state = <0>;
> arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi:
> cooling-min-state = <0>;
> arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi:
> cooling-min-state = <0>;
> 
> 
> IIUC, the cooling-device in the mapping defines the min and max states
> which are the values used in the thermal zone binding.
> 
> And the cooling-[min|max]-level are the hardware limits:
> 
> cooling-min-level <= cooling-device min|max state <= cooling-max-level
> 
> For example on the hikey6220:
> 
> The DT specifies for CPU0:
> 
> 	operating-points-v2 = <&cpu_opp_table>;
> 	cooling-min-level = <4>;
> 	cooling-max-level = <0>;
> 	#cooling-cells = <2>; /* min followed by max */
> 
> and for the cooling device for map0
> 
> 	cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;
> 
> So if my understanding is correct, the optional property
> cooling-[min|max]-level is used to make sure the cooling device min
> state and max state are in the hardware boundaries. And the thermal
> framework misses to do the consistency check at init.
> 
> I'm not sure how useful are cooling-{min|max}-*state* bindings.

Okay, but we aren't validating it this way in code. Isn't it ?

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
