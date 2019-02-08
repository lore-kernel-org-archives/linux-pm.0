From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/2] cpufreq/opp: rework regulator initialization
Date: Fri, 8 Feb 2019 11:18:11 +0100
Message-ID: <CAJZ5v0jB7CDd9+gX+R3e+yrEsJty1E2MwuJGnuaJS0QeHeJ5rg@mail.gmail.com>
References: <CGME20190207122255eucas1p1cdebed838c799eca46cce6a654a26187@eucas1p1.samsung.com>
 <20190207122227.19873-1-m.szyprowski@samsung.com> <20190208064957.zhyue42kpgaoslwm@vireshk-i7>
 <dc3802db-2931-e4fa-72f4-fa6e9b5c0e9a@samsung.com> <20190208085544.vqkebcgg7jpbv2a6@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190208085544.vqkebcgg7jpbv2a6@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Marek Szyprowski <m.szyprowski@samsung.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Dave Gerlach <d-gerlach@ti.com>, Wolfram Sang <wsa@the-dreams.de>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 8, 2019 at 9:55 AM Viresh Kumar <viresh.kumar@linaro.org> wrote:
>
> On 08-02-19, 09:12, Marek Szyprowski wrote:
> > On 2019-02-08 07:49, Viresh Kumar wrote:
> > > Why don't you get similar problem during suspend? I think you can get
> > > it when the CPUs are offlined as I2C would have gone by then. The
> > > cpufreq or OPP core can try and run some regulator or genpd or clk
> > > calls to disable resources, etc. Even if doesn't happen, it certainly
> > > can.
> >
> > CPUfreq is suspended very early during system suspend and thus it does
> > nothing when CPUs are being offlined.
>
> > > Also at resume the cpufreq core may try to change the frequency right
> > > from ->init() on certain cases, though not everytime and so the
> > > problem can come despite of this series.
> >
> > cpufreq is still in suspended state (it is being 'resume' very late in
> > the system resume procedure), so if driver doesn't explicitly change any
> > opp in ->init(), then cpufreq core waits until everything is resumed. To
> > sum up, this seems to be fine, beside the issue with regulator
> > initialization I've addressed in this patchset.
>
> Yeah, the governors are suspended very soon, but any frequency change
> starting from cpufreq core can still happen. There are at least two
> points in cpufreq_online() where we may end up changing the frequency,
> but that is conditional and may not be getting hit.
>
> > > We guarantee that the resources are available during probe but not
> > > during resume, that's where the problem is.
> >
> > Yes, so I've changed cpufreq-dt to the common approach, in which the
> > driver keeps all needed resources for the whole lifetime of the device.
>
> That's not what I was saying actually. I was saying that it should be
> fine to do a I2C transfer during resume,

Surely not before resuming the I2C controller involved?

> else we will always have
> problems and have to fix them with hacks like the one you proposed
> where you acquire resources for all the possible CPUs. Maybe we can
> fix it once and for all.

Obviously, all I2C transfers need to take place either before
suspending the I2C controller or after resuming it.
