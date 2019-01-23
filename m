From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2 1/9] thermal: cpu_cooling: Require thermal core to be
 compiled in
Date: Wed, 23 Jan 2019 11:54:15 +0100
Message-ID: <CAJZ5v0hhjDpSgizMazsbXiOyEhycyVihdMmsT_i7eAQ7K6vqAA@mail.gmail.com>
References: <cover.1548084260.git.amit.kucheria@linaro.org>
 <3f3e38e55c2de4b730fd7c6aa30c125f3a6a8704.1548084260.git.amit.kucheria@linaro.org>
 <20190123103451.ap5vws3kj2ch4uba@vireshk-i7> <CAP245DWTyaOFhS3SYwAmLGpczQo9JR+gsDbGdHAnoxpTWayjgg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAP245DWTyaOFhS3SYwAmLGpczQo9JR+gsDbGdHAnoxpTWayjgg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Amit Kucheria <amit.kucheria@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Stephen Boyd <swboyd@chromium.org>, Doug Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, Zhang Rui <rui.zhang@intel.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 23, 2019 at 11:53 AM Amit Kucheria <amit.kucheria@linaro.org> wrote:
>
> On Wed, Jan 23, 2019 at 4:04 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 21-01-19, 21:10, Amit Kucheria wrote:
> > > The CPU cooling driver (cpu_cooling.c) allows the platform's cpufreq
> > > driver to register as a cooling device and cool down the platform by
> > > throttling the CPU frequency. In order to be able to auto-register a
> > > cpufreq driver as a cooling device from the cpufreq core, we need access
> > > to code inside cpu_cooling.c which, in turn, accesses code inside
> > > thermal core.
> > >
> > > CPU_FREQ is a bool while THERMAL is tristate.  In some configurations
> > > (e.g. allmodconfig), CONFIG_THERMAL ends up as a module while
> > > CONFIG_CPU_FREQ is compiled in. This leads to following error:
> > >
> > > drivers/cpufreq/cpufreq.o: In function `cpufreq_offline':
> > > cpufreq.c:(.text+0x407c): undefined reference to `cpufreq_cooling_unregister'
> > > drivers/cpufreq/cpufreq.o: In function `cpufreq_online':
> > > cpufreq.c:(.text+0x70c0): undefined reference to `of_cpufreq_cooling_register'
> > >
> > > Given that platforms using CPU_THERMAL usually want it compiled-in so it
> > > is available early in boot, make CPU_THERMAL depend on THERMAL being
> > > compiled-in instead of allowing it to be a module.
> > >
> > > Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > > Signed-off-by: Amit Kucheria <amit.kucheria@linaro.org>
> > > ---
> > >  drivers/thermal/Kconfig | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/thermal/Kconfig b/drivers/thermal/Kconfig
> > > index 30323426902e..58bb7d72dc2b 100644
> > > --- a/drivers/thermal/Kconfig
> > > +++ b/drivers/thermal/Kconfig
> > > @@ -152,6 +152,7 @@ config CPU_THERMAL
> > >       bool "generic cpu cooling support"
> > >       depends on CPU_FREQ
> > >       depends on THERMAL_OF
> > > +     depends on THERMAL=y
> > >       help
> > >         This implements the generic cpu cooling mechanism through frequency
> > >         reduction. An ACPI version of this already exists
> >
> > Please remove all Kconfig crap, which gets fixed with this, as well in
> > this patch itself. Like:
>
> OK, I planned to if/when this series was accepted. Will send out a patch.

You can make it part of this series, though.
