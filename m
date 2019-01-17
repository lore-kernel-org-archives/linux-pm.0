From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v1 00/10] cpufreq: Add flag to auto-register as cooling device
Date: Thu, 17 Jan 2019 11:14:16 +0100
Message-ID: <CAJZ5v0jMOnV-maVfxbD-8HWOV30qzLfYUYN+xMNBhhgJWB2aFw@mail.gmail.com>
References: <cover.1547481320.git.amit.kucheria@linaro.org>
 <20190117054916.dqduckt7larn32av@vireshk-i7> <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0jUKcRQot9m5VOxqppWWrD-Cy=USpKMRtcq4zJ5EgmHCg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Amit Kucheria <amit.kucheria@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Eduardo Valentin <edubezval@gmail.com>, Stephen Boyd <swboyd@chromium.org>, Doug Anderson <dianders@chromium.org>, Matthias Kaehlcke <mka@chromium.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Matthias Brugger <matthias.bgg@gmail.com>, Sudeep Holla <sudeep.holla@arm.com>, "moderated list:ARM/Mediatek SoC support" <linux-arm-kernel@lists.infradead.org>, "moderated list:ARM/Mediatek SoC support" <linux-mediatek@lists.infradead.org>, "open list:CPU FREQUENCY DRIVERS" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jan 17, 2019 at 11:08 AM Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Jan 17, 2019 at 6:49 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 14-01-19, 22:04, Amit Kucheria wrote:
> > > Add a flag to be used by cpufreq drivers to tell cpufreq core to
> > > auto-register themselves as a thermal cooling device.
> > >
> > > There series converts over all the drivers except arm_big_little.c.
> > > Tested on SDM845 with the qcom-cpufreq-hw driver. Only compile-tested the
> > > others.
> > >
> > > Things needing fixing:
> > >  - Look at how to detect that we're not in IKS mode in arm_big_little's
> > >    .ready callback.
> >
> > is_bL_switching_enabled() lets you know if IKS is enabled or not.
> > Set/clear flag conditionally before the cpufreq-driver is registered,
> > based on the output of is_bL_switching_enabled().
> >
> > >  - The other pending issue is to fix allmodconfig that leaves us with
> > >    CPU_FREQ=y and THERMAL=m (CPU_THERMAL=y). That leads to undefined
> > >    references for functions defined in cpu_cooling.c
> >
> > Okay, that's a terrible thing and the solution looks to be rather
> > difficult.
> >
> > For others who may not be aware of the issue here, currently the
> > cpufreq drivers use helpers of cpu_cooling.c (CONFIG_CPU_THERMAL),
> > which uses helpers of the thermal core (CONFIG_THERMAL).
> > CONFIG_THERMAL is defined as tristate and CONFIG_CPU_THERMAL as bool
> > in Kconfigs.
>
> And CONFIG_CPU_THERMAL is defined under "if THERMAL".
>
> > The cpufreq drivers using the cpu_cooling.c file have this in their
> > Kconfig entry:
> >
> > # if CPU_THERMAL is on and THERMAL=m, ARM_BIT_LITTLE_CPUFREQ cannot be =y
> > #       depends on !CPU_THERMAL || THERMAL
> >
> >
> > This series now places the cpufreq core in place of the cpufreq driver
> > and it messes up everything. It is not just about allmodconfig, but
> > any configuration which makes the compilation fail.
> >
> > What are the solutions we have now ?
> >
> > 1. Have following for CONFIG_CPU_FREQ
> >        depends on !CPU_THERMAL || THERMAL
>
> Sorry, but this makes my teeth hurt.
>
> >    The platforms which don't need CPU_THERMAL (like x86) should not
> >    enable CPU_THERMAL anymore if they want CONFIG_THERMAL=m.
> >
> >    @amit: If this gets accepted, please update the Kconfig entries for
> >    all those drivers to not have above lines anymore.
> >
> > - Change CONFIG_THERMAL to bool instead of tristate ?
> >
> > - Anything else ?
>
> The design in the thermal subsystem seems to be upside-down.
> Non-modular code should never be made depend on anything only defined
> in a module.
>
> Would an explicit "select THERMAL" under CPU_THERMAL cause THERMAL to be 'y'?

Alternatively, "depends on THERMAL=y" under CPU_THERMAL should work
too, shouldn't it?  "!CPU_THERMAL || THERMAL" would be always true
then, AFAICS.
