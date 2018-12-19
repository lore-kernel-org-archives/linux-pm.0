From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 24/27] drivers: firmware: psci: Support CPU hotplug
 for the hierarchical model
Date: Wed, 19 Dec 2018 12:47:53 +0100
Message-ID: <CAPDyKFoFn=3VzYLriROYEgCT=gbrsjbx8Fc1dktTJ1BdCBxniw@mail.gmail.com>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-25-ulf.hansson@linaro.org> <20181219111744.GA23393@e107981-ln.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181219111744.GA23393@e107981-ln.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux PM <linux-pm@vger.kernel.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 19 Dec 2018 at 12:17, Lorenzo Pieralisi
<lorenzo.pieralisi@arm.com> wrote:
>
> On Thu, Nov 29, 2018 at 06:46:57PM +0100, Ulf Hansson wrote:
> > When the hierarchical CPU topology is used and when a CPU has been put
> > offline (hotplug), that same CPU prevents its PM domain and thus also
> > potential master PM domains, from being powered off. This is because genpd
> > observes the CPU's struct device to remain being active from a runtime PM
> > point of view.
> >
> > To deal with this, let's decrease the runtime PM usage count by calling
> > pm_runtime_put_sync_suspend() of the CPU's struct device when putting it
> > offline. Consequentially, we must then increase the runtime PM usage for
> > the CPU, while putting it online again.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v10:
> >       - Make it work when the hierarchical CPU topology is used, which may be
> >         used both for OSI and PC mode.
> >       - Rework the code to prevent "BUG: sleeping function called from
> >         invalid context".
> > ---
> >  drivers/firmware/psci/psci.c | 20 ++++++++++++++++++++
> >  1 file changed, 20 insertions(+)
> >
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index b03bccce0a5d..f62c4963eb62 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -15,6 +15,7 @@
> >
> >  #include <linux/acpi.h>
> >  #include <linux/arm-smccc.h>
> > +#include <linux/cpu.h>
> >  #include <linux/cpuidle.h>
> >  #include <linux/errno.h>
> >  #include <linux/linkage.h>
> > @@ -199,9 +200,20 @@ static int psci_cpu_suspend(u32 state, unsigned long entry_point)
> >
> >  static int psci_cpu_off(u32 state)
> >  {
> > +     struct device *dev;
> >       int err;
> >       u32 fn;
> >
> > +     /*
> > +      * When the hierarchical CPU topology is used, decrease the runtime PM
> > +      * usage count for the current CPU, as to allow other parts in the
> > +      * topology to enter low power states.
> > +      */
> > +     if (psci_dt_topology) {
> > +             dev = get_cpu_device(smp_processor_id());
> > +             pm_runtime_put_sync_suspend(dev);
> > +     }
> > +
> >       fn = psci_function_id[PSCI_FN_CPU_OFF];
> >       err = invoke_psci_fn(fn, state, 0, 0);
> >       return psci_to_linux_errno(err);
> > @@ -209,6 +221,7 @@ static int psci_cpu_off(u32 state)
> >
> >  static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
> >  {
> > +     struct device *dev;
> >       int err;
> >       u32 fn;
> >
> > @@ -216,6 +229,13 @@ static int psci_cpu_on(unsigned long cpuid, unsigned long entry_point)
> >       err = invoke_psci_fn(fn, cpuid, entry_point, 0);
> >       /* Clear the domain state to start fresh. */
> >       psci_set_domain_state(0);
> > +
> > +     /* Increase runtime PM usage count if the hierarchical CPU toplogy. */
> > +     if (!err && psci_dt_topology) {
> > +             dev = get_cpu_device(cpuid);
>
> I do not like adding this code in the cpu_{on/off} method themselves, I will
> have a look at the patchset as whole to see how we can restructure it.

Any suggestions are welcome, of course. This was the best and most
simple option I could come up with.

Another option, could be to simply to remove the runtime PM deployment
from psci_cpu_off|on() altogether and just live with that limitation
for now. That works for me as well.

>
> More to the point, using cpuid as a logical cpu id is wrong, it is a
> physical id that you should convert to a logical id through
> get_logical_index().

Oh, didn't know that, thanks for pointing that out!

>
> Lorenzo
>
> > +             pm_runtime_get_sync(dev);
> > +     }
> > +
> >       return psci_to_linux_errno(err);
> >  }
> >
> > --
> > 2.17.1
> >

Kind regards
Uffe
