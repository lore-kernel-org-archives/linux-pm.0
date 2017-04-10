From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH] PM / OPP: Use - instead of @ for DT entries
Date: Mon, 10 Apr 2017 12:18:51 +0530
Message-ID: <20170410064851.GC24555@vireshk-i7>
References: <5ce1fbbc7cd37a6cfe54e93eeca311a7a52093ff.1491801395.git.viresh.kumar@linaro.org>
 <20170410062258.GA24555@vireshk-i7>
 <CAK7LNAR=+k6iuqUPUNLW=EHUuOw4fBr4SbEtP-jnSyrsiEydgg@mail.gmail.com>
 <20170410063239.GB24555@vireshk-i7>
 <CAJKOXPe_+Y+9ZLE7Jymqc5nULzo+qM4cCMFg2-cV_YnpCFkRCA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAJKOXPe_+Y+9ZLE7Jymqc5nULzo+qM4cCMFg2-cV_YnpCFkRCA-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Cc: Masahiro Yamada <yamada.masahiro-uWyLwvC0a2jby3iVrkZq2A@public.gmane.org>, Rafael Wysocki <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, MyungJoo Ham <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kyungmin Park <kyungmin.park-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, Kukjin Kim <kgene-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Javier Martinez Canillas <javier-JPH+aEBZ4P+UEJcrhfAQsw@public.gmane.org>, Viresh Kumar <vireshk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Stephen Boyd <sboyd-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Daniel Mack <daniel-cYrQPVfZoowdnm+yROfE0A@public.gmane.org>, Haojian Zhuang <haojian.zhuang-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Robert Jarzmik <robert.jarzmik-GANU6spQydw@public.gmane.org>, Maxime Ripard <maxime.ripard-wi1+55ScJUtKEb57/3fJTNBPR1lH4CV8@public.gmane.org>, Chen-Yu Tsai <wens-jdAy2FN1RRM@public.gmane.org>, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Linux Kernel Mailing List <linux-kernel@vger.>
List-Id: linux-pm@vger.kernel.org

On 10-04-17, 08:45, Krzysztof Kozlowski wrote:
> Yes, keeping both make most sense, I think.
> 
> Anyway, I found now the original report thread of Masahiro and I see
> Mark's response about using '-'. In that case I am fine with this. I
> would prefer to take only the exynos part (separated to ARMv7 and
> ARMv8) through my tree but I already sent a pull request so I am fine
> with this going directly to arm-soc.

This may end up going via the PM tree.

> I think you need to update also:
> Documentation/devicetree/bindings/cpufreq/ti-cpufreq.txt

Oops. I searched for opp@ and missed the complex ones. There are some
DT files as well for TI which I missed. Will send a V2 with all that
fixed.

> With that change:
> Reviewed-by: Krzysztof Kozlowski <krzk-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
> (and implied acked-by)

Thanks.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
