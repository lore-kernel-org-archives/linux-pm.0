From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [Query] thermal: Who is using "cooling-{min|max}-level}"
 properties ?
Date: Wed, 7 Feb 2018 11:04:45 +0100
Message-ID: <c7bd6ed5-b93e-3a07-b4a2-4c3b1eef5fac@linaro.org>
References: <20180207065959.GN28462@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20180207065959.GN28462@vireshk-i7>
Content-Language: en-US
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Punit.Agrawal-5wv7dgnIgG8@public.gmane.org, ionela.voinescu-5wv7dgnIgG8@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 07/02/2018 07:59, Viresh Kumar wrote:
> Looks like I am missing the obvious and sorry for the noise in advance.
> 
> But I couldn't find any code that parses the "cooling-{min|max}-level" DT
> bindings in the kernel. Yeah, almost every ARM platform have these properties
> set for their CPU nodes in DT, but I don't see how these are getting used.
> 
> I even tried to remove them for my hikey platform and everything worked as if
> nothing has changed (which I was expecting anyway). The deal is that the
> ->get_max_state() callback of the cooling drivers are getting called to get the
> range at runtime and none of them refers to these bindings.
> 
> Removing code is always fun and I would be happy to post a series to clean
> things up if everyone agrees. Please let me know if my understanding is correct
> and if it would be fine to remove these bindings completely.

Yeah, this is a bit fuzzy. There are still cooling-{min|max}-*state*
definitions in the DTs

Documentation/devicetree/bindings/hwmon/pwm-fan.txt:
cooling-min-state = <0>;
arch/arm/boot/dts/exynos4412-odroidu3.dts:
cooling-min-state = <0>;
arch/arm/boot/dts/exynos5410-odroidxu.dts:
cooling-min-state = <0>;
arch/arm/boot/dts/exynos5422-odroidxu3-common.dtsi:
cooling-min-state = <0>;
arch/arm64/boot/dts/rockchip/rk3399-puma.dtsi:
cooling-min-state = <0>;


IIUC, the cooling-device in the mapping defines the min and max states
which are the values used in the thermal zone binding.

And the cooling-[min|max]-level are the hardware limits:

cooling-min-level <= cooling-device min|max state <= cooling-max-level

For example on the hikey6220:

The DT specifies for CPU0:

	operating-points-v2 = <&cpu_opp_table>;
	cooling-min-level = <4>;
	cooling-max-level = <0>;
	#cooling-cells = <2>; /* min followed by max */

and for the cooling device for map0

	cooling-device = <&cpu0 THERMAL_NO_LIMIT THERMAL_NO_LIMIT>;

So if my understanding is correct, the optional property
cooling-[min|max]-level is used to make sure the cooling device min
state and max state are in the hardware boundaries. And the thermal
framework misses to do the consistency check at init.

I'm not sure how useful are cooling-{min|max}-*state* bindings.

-- 
 <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
