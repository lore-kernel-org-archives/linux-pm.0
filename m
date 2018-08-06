From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v8 07/26] PM / Domains: Add genpd governor for CPUs
Date: Mon, 6 Aug 2018 11:20:59 +0200
Message-ID: <CAJZ5v0hX3gC0J_z1tMu-KkNBRf3GuJ91tbFC2Z+0D1BnHkY8kg@mail.gmail.com>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <20180620172226.15012-8-ulf.hansson@linaro.org> <3574880.GjmnMm1lMq@aspire.rjw.lan>
 <10360149.m4MlxDWZY5@aspire.rjw.lan> <CAPDyKFonHYSq32WxvB1x5PXissXZvraqazgU_ZyLR=tsyD9vAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFonHYSq32WxvB1x5PXissXZvraqazgU_ZyLR=tsyD9vAA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Aug 3, 2018 at 4:28 PM, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> On 26 July 2018 at 11:14, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> On Thursday, July 19, 2018 12:32:52 PM CEST Rafael J. Wysocki wrote:
>>> On Wednesday, June 20, 2018 7:22:07 PM CEST Ulf Hansson wrote:
>>> > As it's now perfectly possible that a PM domain managed by genpd contains
>>> > devices belonging to CPUs, we should start to take into account the
>>> > residency values for the idle states during the state selection process.
>>> > The residency value specifies the minimum duration of time, the CPU or a
>>> > group of CPUs, needs to spend in an idle state to not waste energy entering
>>> > it.
>>> >
>>> > To deal with this, let's add a new genpd governor, pm_domain_cpu_gov, that
>>> > may be used for a PM domain that have CPU devices attached or if the CPUs
>>> > are attached through subdomains.
>>> >
>>> > The new governor computes the minimum expected idle duration time for the
>>> > online CPUs being attached to the PM domain and its subdomains. Then in the
>>> > state selection process, trying the deepest state first, it verifies that
>>> > the idle duration time satisfies the state's residency value.
>>> >
>>> > It should be noted that, when computing the minimum expected idle duration
>>> > time, we use the information from tick_nohz_get_next_wakeup(), to find the
>>> > next wakeup for the related CPUs. Future wise, this may deserve to be
>>> > improved, as there are more reasons to why a CPU may be woken up from idle.
>>> >
>>> > Cc: Thomas Gleixner <tglx@linutronix.de>
>>> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> > Cc: Lina Iyer <ilina@codeaurora.org>
>>> > Cc: Frederic Weisbecker <fweisbec@gmail.com>
>>> > Cc: Ingo Molnar <mingo@kernel.org>
>>> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
>>> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>>> > ---
>>> >  drivers/base/power/domain_governor.c | 58 ++++++++++++++++++++++++++++
>>> >  include/linux/pm_domain.h            |  2 +
>>> >  2 files changed, 60 insertions(+)
>>> >
>>> > diff --git a/drivers/base/power/domain_governor.c b/drivers/base/power/domain_governor.c
>>> > index 99896fbf18e4..1aad55719537 100644
>>> > --- a/drivers/base/power/domain_governor.c
>>> > +++ b/drivers/base/power/domain_governor.c
>>> > @@ -10,6 +10,9 @@
>>> >  #include <linux/pm_domain.h>
>>> >  #include <linux/pm_qos.h>
>>> >  #include <linux/hrtimer.h>
>>> > +#include <linux/cpumask.h>
>>> > +#include <linux/ktime.h>
>>> > +#include <linux/tick.h>
>>> >
>>> >  static int dev_update_qos_constraint(struct device *dev, void *data)
>>> >  {
>>> > @@ -245,6 +248,56 @@ static bool always_on_power_down_ok(struct dev_pm_domain *domain)
>>> >     return false;
>>> >  }
>>> >
>>> > +static bool cpu_power_down_ok(struct dev_pm_domain *pd)
>>> > +{
>>> > +   struct generic_pm_domain *genpd = pd_to_genpd(pd);
>>> > +   ktime_t domain_wakeup, cpu_wakeup;
>>> > +   s64 idle_duration_ns;
>>> > +   int cpu, i;
>>> > +
>>> > +   if (!(genpd->flags & GENPD_FLAG_CPU_DOMAIN))
>>> > +           return true;
>>> > +
>>> > +   /*
>>> > +    * Find the next wakeup for any of the online CPUs within the PM domain
>>> > +    * and its subdomains. Note, we only need the genpd->cpus, as it already
>>> > +    * contains a mask of all CPUs from subdomains.
>>> > +    */
>>> > +   domain_wakeup = ktime_set(KTIME_SEC_MAX, 0);
>>> > +   for_each_cpu_and(cpu, genpd->cpus, cpu_online_mask) {
>>> > +           cpu_wakeup = tick_nohz_get_next_wakeup(cpu);
>>> > +           if (ktime_before(cpu_wakeup, domain_wakeup))
>>> > +                   domain_wakeup = cpu_wakeup;
>>> > +   }
>>
>> Here's a concern I have missed before. :-/
>>
>> Say, one of the CPUs you're walking here is woken up in the meantime.
>
> Yes, that can happen - when we miss-predicted "next wakeup".
>
>>
>> I don't think it is valid to evaluate tick_nohz_get_next_wakeup() for it then
>> to update domain_wakeup.  We really should just avoid the domain power off in
>> that case at all IMO.
>
> Correct.
>
> However, we also want to avoid locking contentions in the idle path,
> which is what this boils done to.

This already is done under genpd_lock() AFAICS, so I'm not quite sure
what exactly you mean.

Besides, this is not just about increased latency, which is a concern
by itself but maybe not so much in all environments, but also about
possibility of missing a CPU wakeup, which is a major issue.

If one of the CPUs sharing the domain with the current one is woken up
during cpu_power_down_ok() and the wakeup is an edge-triggered
interrupt and the domain is turned off regardless, the wakeup may be
missed entirely if I'm not mistaken.

It looks like there needs to be a way for the hardware to prevent a
domain poweroff when there's a pending interrupt or I don't quite see
how this can be handled correctly.

>> Sure enough, if the domain power off is already started and one of the CPUs
>> in the domain is woken up then, too bad, it will suffer the latency (but in
>> that case the hardware should be able to help somewhat), but otherwise CPU
>> wakeup should prevent domain power off from being carried out.
>
> The CPU is not prevented from waking up, as we rely on the FW to deal with that.
>
> Even if the above computation turns out to wrongly suggest that the
> cluster can be powered off, the FW shall together with the genpd
> backend driver prevent it.

Fine, but then the solution depends on specific FW/HW behavior, so I'm
not sure how generic it really is.  At least, that expectation should
be clearly documented somewhere, preferably in code comments.

> To cover this case for PSCI, we also use a per cpu variable for the
> CPU's power off state, as can be seen later in the series.

Oh great, but the generic part should be independent on the underlying
implementation of the driver.  If it isn't, then it also is not
generic.

> Hope this clarifies your concern, else tell and will to elaborate a bit more.

Not really.

There also is one more problem and that is the interaction between
this code and the idle governor.

Namely, the idle governor may select a shallower state for some
reason, for example due to an additional latency limit derived from
CPU utilization (like in the menu governor), and how does the code in
cpu_power_down_ok() know what state has been selected and how does it
honor the selection made by the idle governor?
