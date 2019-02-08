From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Date: Fri, 8 Feb 2019 11:08:38 +0100
Message-ID: <CAJZ5v0i=q78gXjCUUgXVHFFjwEiY9H2Ds7ba3gAHNC11JQ6q9A@mail.gmail.com>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com> <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
 <dc3802db-2931-e4fa-72f4-fa6e9b5c0e9a@samsung.com> <20190208085544.vqkebcgg7jpbv2a6@vireshk-i7>
 <bbab0116-c2e5-a3a6-30e4-cbd8c583a120@samsung.com> <20190208092348.uqkfgxwx2pe3lmpd@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208092348.uqkfgxwx2pe3lmpd@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Gerlach <d-gerlach@ti.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 8, 2019 at 10:23 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 08-02-19, 10:15, Marek Szyprowski wrote:
> > On 2019-02-08 09:55, Viresh Kumar wrote:
> > > On 08-02-19, 09:12, Marek Szyprowski wrote:
> > >> On 2019-02-08 07:49, Viresh Kumar wrote:
> > >>> Why don't you get similar problem during suspend? I think you can get
> > >>> it when the CPUs are offlined as I2C would have gone by then. The
> > >>> cpufreq or OPP core can try and run some regulator or genpd or clk
> > >>> calls to disable resources, etc. Even if doesn't happen, it certainly
> > >>> can.
> > >> CPUfreq is suspended very early during system suspend and thus it does
> > >> nothing when CPUs are being offlined.
> > >>> Also at resume the cpufreq core may try to change the frequency right
> > >>> from ->init() on certain cases, though not everytime and so the
> > >>> problem can come despite of this series.
> > >> cpufreq is still in suspended state (it is being 'resume' very late in
> > >> the system resume procedure), so if driver doesn't explicitly change any
> > >> opp in ->init(), then cpufreq core waits until everything is resumed. To
> > >> sum up, this seems to be fine, beside the issue with regulator
> > >> initialization I've addressed in this patchset.
> > > Yeah, the governors are suspended very soon, but any frequency change
> > > starting from cpufreq core can still happen. There are at least two
> > > points in cpufreq_online() where we may end up changing the frequency,
> > > but that is conditional and may not be getting hit.
> >
> > Then probably cpufreq core suspend should handle this.
>
> Handle what ? That code is part of cpufreq_online() and needs to be
> there only.
>
> > >>> We guarantee that the resources are available during probe but not
> > >>> during resume, that's where the problem is.
> > >> Yes, so I've changed cpufreq-dt to the common approach, in which the
> > >> driver keeps all needed resources for the whole lifetime of the device.
> > > That's not what I was saying actually. I was saying that it should be
> > > fine to do a I2C transfer during resume, else we will always have
> > > problems and have to fix them with hacks like the one you proposed
> > > where you acquire resources for all the possible CPUs. Maybe we can
> > > fix it once and for all.
> >
> > It is fine to do i2c transfers during cpufreq resume (see
>
> By resume I meant system resume and the whole onlining process of
> non-boot CPUs.
>
> > drivers/base/power/main.c dpm_resume() function for exact call place).
> > The problem is that such calls are not allowed in ->init(), which might
> > be called very early from CPU hotplug path (CPUs are resumed in the
> > first step of system resume procedure).
>
> Right and that's where I think we can do something to fix it in a
> proper way.
>
> > What's wrong with my proposed fix? It is not that uncommon to gather all
> > resources in probe() and keep them until remove() happens.
>
> For cpufreq drivers, we must be doing most of the stuff in init/exit
> only as far as possible. I am not saying your patch is bad, that is
> the best we can do in such situations. But I don't like that we have
> to get the resources for all CPUs, despite the fact that many of them
> would be part of the same policy and hence share resources. The
> problem was that we need to get sharing-cpus detail as well in probe
> then, etc.
>
> I was thinking about doing disable_nonboot_cpus() much earlier as the
> userspace is already frozen by then.
>
> @Rafael: Will that slowdown the suspend/resume process? Maybe not as
> we are doing everything from a single CPU/thread anyways ?

First, we used to do that and we switched over to what we have right
now several years ago, because it didn't work reliably then.

Arguably, CPU hotplug is in a much better shape now, so it might be
working better, but that would be a huge change and lots of
documentation would need to be revised. :-)

Also it is not true that everything is done on a single CPU, but I'm
not really sure about the possible slowdown.

Second, there are (many) systems for which that change is not really
necessary and it is risky because of possible regressions.

I guess that CPUs depending on I2C for online/offline could be taken
offline earlier and brought back online later during suspend/resume,
like before/after the _noirq suspend of devices, but doing that on all
systems altogether is almost guaranteed to introduce regressions.
