From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH -next] power/domain_governor: fix a compilation error
Date: Thu, 11 Apr 2019 20:00:43 +0200
Message-ID: <CAPDyKFpVsNB3T7FtveK1rcTOtmOzEOQrSZ3zS+ze6jexVqw9nA@mail.gmail.com>
References: <20190411124739.5542-1-cai@lca.pw> <CAPDyKFqmP3pORhufTsCg1nuqSPGz8hEQNTpZgr24fFqk13hM3w@mail.gmail.com>
 <CAJZ5v0hWL1dGPZX0aotcJ7cT_LdHvreZvx-fR7B_9Y=mqxSyzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hWL1dGPZX0aotcJ7cT_LdHvreZvx-fR7B_9Y=mqxSyzw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Qian Cai <cai@lca.pw>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Lina Iyer <lina.iyer@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 11 Apr 2019 at 16:37, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Apr 11, 2019 at 3:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > On Thu, 11 Apr 2019 at 14:48, Qian Cai <cai@lca.pw> wrote:
> > >
> > > The commit 50899f7d5078 ("PM / Domains: Add genpd governor for CPUs")
> > > introduced a compilation error on arm64 with CONFIG_CPU_IDLE=n because
> > > cpuidle_devices is undefined there.
> > >
> > > drivers/base/power/domain_governor.o: In function `cpu_power_down_ok':
> > > drivers/base/power/domain_governor.c:263: undefined reference to
> > > 'cpuidle_devices' ld: drivers/base/power/domain_governor.o: relocation
> > > R_AARCH64_ADR_PREL_PG_HI21 against symbol 'cpuidle_devices' which may
> > > bind externally can not be used when making a shared object; recompile
> > > with -fPIC
> > > drivers/base/power/domain_governor.c:263:(.text+0x638): dangerous
> > > relocation: unsupported relocation
> > > drivers/base/power/domain_governor.c:263: undefined reference to
> > > 'cpuidle_devices'
> > > make: *** [Makefile:1047: vmlinux] Error 1
> > >
> > > Signed-off-by: Qian Cai <cai@lca.pw>
> >
> > Qian, thanks for you patch!
> >
> > > ---
> > >  drivers/base/power/domain_governor.c | 12 +++++++-----
> > >  1 file changed, 7 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
> > > index 39c8a699cb53..252d88fcf760 100644
> > > --- a/drivers/base/power/domain_governor.c
> > > +++ b/drivers/base/power/domain_governor.c
> > > @@ -270,11 +270,13 @@ static bool cpu_power_down_ok(struct dev_pm_domain *pd)
> > >          */
> > >         domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
> > >         for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
> > > -               dev = per_cpu(cpuidle_devices, cpu);
> > > -               if (dev) {
> > > -                       next_hrtimer = READ_ONCE(dev->next_hrtimer);
> > > -                       if (ktime_before(next_hrtimer, domain_wakeup))
> > > -                               domain_wakeup = next_hrtimer;
> > > +               if (IS_ENABLED(CONFIG_CPU_IDLE)) {
> > > +                       dev = per_cpu(cpuidle_devices, cpu);
> > > +                       if (dev) {
> > > +                               next_hrtimer = READ_ONCE(dev->next_hrtimer);
> > > +                               if (ktime_before(next_hrtimer, domain_wakeup))
> > > +                                       domain_wakeup = next_hrtimer;
> > > +                       }
> >
> > This works as quick fix, but I think there is two possible options
> > that is probably better in long run.
> >
> > 1) Extend the cpuidle interface with a new function:
> >
> > struct cpuidle_device *cpuidle_get_cpu_device(unsigned int cpu)
> >
> > Then when CONFIG_CPU_IDLE is unset, we can just have a stub function
> > returning NULL.
>
> So why exactly cpu_power_down_ok() would be still needed with
> CONFIG_CPU_IDLE unset?
>
> > 2) Have the struct dev_power_governor pm_domain_cpu_gov to be defined
> > (and the corresponding functionality), but only when CONFIG_CPU_IDLE
> > is set and when CONFIG_PM_GENERIC_DOMAINS is set.
>
> So please do that.
>
> Can you please send a replacement patch for the [4/4] in the series
> with this fixed?

Yes, I do that!

Kind regards
Uffe
