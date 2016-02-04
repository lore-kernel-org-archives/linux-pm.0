From: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 2/6] drivers/cpufreq: implement
 init_cpu_capacity_default()
Date: Thu, 4 Feb 2016 12:16:20 +0000
Message-ID: <20160204121620.GB29586@e106622-lin>
References: <1454500799-18451-1-git-send-email-juri.lelli@arm.com>
 <1454500799-18451-3-git-send-email-juri.lelli@arm.com>
 <CAKfTPtDGk5BC25WqHdhDYDOBgUsuidAMhrXS=eDi6wJPZjfrwA@mail.gmail.com>
 <20160204093559.GA14099@e105550-lin.cambridge.arm.com>
 <CAKfTPtB4G3bP5N0hU6zWXJTddO34x3RnyGpp-4_otc8O=Wq2hw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <CAKfTPtB4G3bP5N0hU6zWXJTddO34x3RnyGpp-4_otc8O=Wq2hw-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Vincent Guittot <vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Morten Rasmussen <morten.rasmussen-5wv7dgnIgG8@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, LAK <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Peter Zijlstra <peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Sudeep Holla <sudeep.holla-5wv7dgnIgG8@public.gmane.org>, Lorenzo Pieralisi <lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Will Deacon <will.deacon-5wv7dgnIgG8@public.gmane.org>, Dietmar Eggemann <dietmar.eggemann-5wv7dgnIgG8@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Vincent,

On 04/02/16 13:03, Vincent Guittot wrote:
> On 4 February 2016 at 10:36, Morten Rasmussen <morten.rasmussen-5wv7dgnIgG8@public.gmane.org> wrote:
> > On Wed, Feb 03, 2016 at 10:04:37PM +0100, Vincent Guittot wrote:
> >> On 3 February 2016 at 12:59, Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org> wrote:
> 
> [snip]
> 
> >> > diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
> >> > index 9e63fb1..c4025fd 100644
> >> > --- a/drivers/cpufreq/Makefile
> >> > +++ b/drivers/cpufreq/Makefile
> >> > @@ -1,5 +1,5 @@
> >> >  # CPUfreq core
> >> > -obj-$(CONFIG_CPU_FREQ)                 += cpufreq.o freq_table.o
> >> > +obj-$(CONFIG_CPU_FREQ)                 += cpufreq.o freq_table.o cpufreq_capacity.o
> >>
> >> Do you really want to have the calibration of capacity dependent of
> >> cpufreq ? It means that we can't use it without a cpufreq driver.
> >> IMHO, this creates a unnecessary dependency. I understand that you
> >> must ensure that core runs at max fequency if a driver is present but
> >> you should be able to calibrate the capacity if cpufreq is not
> >> available but you have different capacity because micro architecture
> >
> > We could remove the dependency on cpufreq, but it would make things more
> > complicated for systems which do have frequency scaling as we would have
> > to either:
> >
> > 1) Run the calibration again once cpufreq has been initialized.
> 
> or wait and let time for a driver to initialize and trig the
> calibration. If calibration has not been done at the end of the boot,
> you can force a calibration. If the cpufeq driver is a module and is
> loaded far later for any good or bad reason, we will have to run the
> calibration once again but at least the capacity will reflect he
> current capacity of the CPUs.
> I'm mainly worried that the compilation of the calibration is
> dependent of CONFIG_CPU_FREQ not that cpufreq can trig the calibration
> sequence
> 

Yes, I guess we can make this work in some way. Out of curiosity,
though, are out there heterogenous platforms that don't use cpufreq?
I mean, I wouldn't add code and complexity from start, if there are not
good reasons to do so.

Thanks,

- Juri
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
