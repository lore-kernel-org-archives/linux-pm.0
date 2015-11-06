From: Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3 0/2] thermal: mediatek: Add cpu power cooling model
Date: Fri, 6 Nov 2015 08:50:46 +0530
Message-ID: <20151106032046.GK3773@ubuntu>
References: <1445515359-8587-1-git-send-email-dawei.chien@mediatek.com>
 <20151028154449.GH3716@ubuntu>
 <1446461181.10039.28.camel@mtksdaap41>
 <20151102121034.GA3639@ubuntu>
 <1446721761.4016.56.camel@mtksdaap41>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1446721761.4016.56.camel@mtksdaap41>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: dawei chien <dawei.chien-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Pawel Moll <pawel.moll-5wv7dgnIgG8@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Ian Campbell <ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org>, Kumar Gala <galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Matthias Brugger <matthias.bgg-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Daniel Kurtz <djkurtz-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, Sascha Hauer <s.hauer-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-mediatek-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, srv_heupstream-NuS5LvNUpcJWk0Htik3J/w@public.gmane.org, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 05-11-15, 19:09, dawei chien wrote:
> Thank you for your kindly explaining, now I could understand what I
> miss, I will send device tree binding on next version such like
> following description.
> 
> --- a/Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt
> +++ b/Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt
> @@ -10,6 +10,17 @@ Required properties:
>         Please refer to
> Documentation/devicetree/bindings/clk/clock-bindings.txt for
>         generic clock consumer properties.
>  - proc-supply: Regulator for Vproc of CPU cluster.
> +- dynamic-power-coefficient:
> +       Usage: optional
> +       Value type: <prop-encoded-array>
> +       Definition: A u32 value that represents an indicative
> +       running time dynamic power coefficient in
> +       fundamental units of mW/MHz/uVolt^2.
> +       The dynamic energy consumption of the CPU
> +       is proportional to the square of the
> +       Voltage (V) and the clock frequency (f).
> +       Pdyn = dynamic-power-coefficient * V^2 * f
> +       where voltage is in uV, frequency is in MHz.

Please check with Punit if he is planning to add the same..

> Thank you for your kindly explaining, Now I know I should develop and
> test on mainline branch since this is where I try to add code.
> 
> However, please understanding currently mt8173_cpufreq.c is not ready
> for OPPV2 in mainline as far, that's the reason why currently I can't
> reuse OPPV2 and extend for static power table. My propose is for adding
> CPU cooling device for our own product.

Firstly, we don't care. You are pushing something to mainline, you
have to get it tested someway on mainline.

Secondly, there are *almost* no changes required to the mtk cpufreq
driver for OPPV2. Just update your DT in a similar way it is done for
one of the exynos platforms and it should just work fine.

-- 
viresh
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
