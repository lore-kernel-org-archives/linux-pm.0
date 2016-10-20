From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2 1/4] cpufreq: pxa: use generic platdev driver for
 device-tree
Date: Thu, 20 Oct 2016 09:04:35 +0530
Message-ID: <20161020033435.GD11766@vireshk-i7>
References: <1476561450-28407-1-git-send-email-robert.jarzmik@free.fr>
 <1476561450-28407-2-git-send-email-robert.jarzmik@free.fr>
 <20161018113835.GB11471@vireshk-i7>
 <87r37d4qlw.fsf@belgarion.home>
 <20161019135208.GG11471@vireshk-i7>
 <87bmyg3xzh.fsf@belgarion.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <87bmyg3xzh.fsf@belgarion.home>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Mack <daniel@zonque.org>, Haojian Zhuang <haojian.zhuang@gmail.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Rafael Wysocki <rjw@rjwysocki.net>, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 19-10-16, 22:06, Robert Jarzmik wrote:
> Viresh Kumar <viresh.kumar@linaro.org> writes:
> 
> >> >> +	{ .compatible = "marvell,pxa250", },
> >> >> +	{ .compatible = "marvell,pxa270", },
> >> >>  
> >> >>  	{ .compatible = "samsung,exynos3250", },
> >> >>  	{ .compatible = "samsung,exynos4210", },
> >> >
> >> > Isn't there a race between cpufreq-dt and the platform driver to
> >> > register first ?
> >> Ah, could you be more specific about the race you're talking of ?
> >> 
> >> My understanding was that cpufreq-dt-platdev does create the device, and
> >> cpufreq-dt is a driver for it, so there is no race but a direct relationship
> >> AFAIU.
> >
> > I mean that both the driver may try to register to the cpufreq core if
> > they are both compiled in a single image.
> Euh I still don't follow you. The only driver that can register to the cpufreq
> core is cpufreq-dt.

I was wondering on what will happen if both cpufreq-dt and your pxa2xx-cpufreq
driver are present in the same kernel image. In that case the init routines of
both of them will try to call cpufreq_register_driver().

-- 
viresh
