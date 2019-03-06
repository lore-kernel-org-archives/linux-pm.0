From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Subject: Re: [PATCH 5/7] drivers: firmware: psci: Simplify state node parsing
Date: Wed, 6 Mar 2019 18:15:19 +0000
Message-ID: <20190306181519.GA3355@e107981-ln.cambridge.arm.com>
References: <20190228135919.3747-1-ulf.hansson@linaro.org>
 <20190228135919.3747-6-ulf.hansson@linaro.org>
 <20190301172810.GR15517@lakrids.cambridge.arm.com>
 <CAPDyKFrqp6_NkTBVXZTa3j+-6y+m7aX2y6t=nH=Tjdo4BgMDtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAPDyKFrqp6_NkTBVXZTa3j+-6y+m7aX2y6t=nH=Tjdo4BgMDtQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lina Iyer <ilina@codeaurora.org>, Linux PM <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 04, 2019 at 11:14:18AM +0100, Ulf Hansson wrote:
> On Fri, 1 Mar 2019 at 18:28, Mark Rutland <mark.rutland@arm.com> wrote:
> >
> > On Thu, Feb 28, 2019 at 02:59:17PM +0100, Ulf Hansson wrote:
> > > Instead of iterating through all the state nodes in DT, to find out how
> > > many states that needs to be allocated, let's use the number already known
> > > by the cpuidle driver. In this way we can drop the iteration altogether.
> > >
> > > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > > ---
> > >  drivers/firmware/psci/psci.c | 25 ++++++++++++-------------
> > >  1 file changed, 12 insertions(+), 13 deletions(-)
> > >
> > > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > > index d50b46a0528f..cbfc936d251c 100644
> > > --- a/drivers/firmware/psci/psci.c
> > > +++ b/drivers/firmware/psci/psci.c
> > > @@ -290,26 +290,20 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
> > >  static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
> > >                       struct device_node *cpu_node, int cpu)
> > >  {
> > > -     int i, ret = 0, count = 0;
> > > +     int i, ret = 0, num_state_nodes = drv->state_count - 1;
> > >       u32 *psci_states;
> > >       struct device_node *state_node;
> > >
> > > -     /* Count idle states */
> > > -     while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
> > > -                                           count))) {
> > > -             count++;
> > > -             of_node_put(state_node);
> > > -     }
> > > -
> >
> > To be honest, I'd rather not tighten the coupling with the cpuidle
> > driver here. For example, I'm not that happy with the PSCI backend
> > having to know the driver has a specific WFI state.
> 
> If you ask me, the coupling is already there, only that it's hidden by
> taking assumptions about the WFI state in the code.

There is no assumption taken - I wrote it down here:

https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/arm/idle-states.txt?h=v5.0


> However, I certainly agree with you, that this isn't very nice.

The idea behind the generic ARM CPU idle driver is as follows:

- A generic front-end in drivers/cpuidle/cpuidle-arm.c
- An arch back-end (that is defined by the enable-method), on ARM64
  it is PSCI

As usual with the ARM CPUidle mess, there must be logic connecting
the front-end and the back-end. An idle state index was used since
I saw no other generic way. If there are better ideas they are welcome.

Otherwise we must go back to having a PSCI specific CPUIdle driver
and, on arch/arm, platform specific CPUidle drivers.

The aim was to simplify but to do that we need a connection logic
between drivers<->arch code, that's the only way we can have a generic
idle driver and corresponding boilerplate.

> > IIUC we could get rid of the explicit counting with something like:
> >
> >         count = of_parse_phandle_with_args(cpu_node, "cpu-idle-states", NULL);
> >
> > ... but I'm not sure that the overall change is a simplification.
> 
> In my opinion, no it doesn't.
> 
> To me, it seems a kind of silly (and in-efficient) to do an OF parsing
> that has already been done and given the information we need.

Yeah. It is boot path with idle states in the order of (max) dozens,
silly and inefficient, maybe but that should be fine.

See above.

> > Does this change make it easier to plumb in something in future?
> 
> Yes, I need this for additional changes on top.
> 
> Note that, patch4 also provides the opportunity to do a similar
> cleanup of the initialization code in drivers/soc/qcom/spm.c. I
> haven't made that part of this series though.
> 
> I guess in the end, we need to accept that part of the psci driver is
> really a cpuidle driver. Trying to keep them entirely separate,
> doesn't come without complexity/churns.

PSCI driver is a kernel interface to firmware, it is not a CPUidle
driver per-se, we tried to decouple firmware interfaces from kernel
data structures as much as possible, again, see above.

> While working on psci changes in the recent series I have posted, I
> was even considering adding a completely new cpuidle driver for psci
> (in drivers/cpuidle/*) and instead define a number of psci interface
> functions, which that driver could call. That would probably be a
> better split, but requires quite some changes.

It can be done but with it the whole generic ARM CPUidle driver
infrastructure must go with it (and you will still have a standard wfi
state in the PSCI idle state array anyway).

The idea behind ARM64 cpu_ops clashes a bit with this approach so
there is a discussion to be had here.

> So, what do you want me to do with this?

We need to answer the question above.

Thanks,
Lorenzo

> > Thanks,
> > Mark.
> 
> Thanks a lot for reviewing!
> 
> Kind regards
> Uffe
> 
> >
> > > -     if (!count)
> > > -             return -ENODEV;
> > > -
> > > -     psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
> > > +     psci_states = kcalloc(num_state_nodes, sizeof(*psci_states),
> > > +                     GFP_KERNEL);
> > >       if (!psci_states)
> > >               return -ENOMEM;
> > >
> > > -     for (i = 0; i < count; i++) {
> > > +     for (i = 0; i < num_state_nodes; i++) {
> > >               state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
> > > +             if (!state_node)
> > > +                     break;
> > > +
> > >               ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
> > >               of_node_put(state_node);
> > >
> > > @@ -319,6 +313,11 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
> > >               pr_debug("psci-power-state %#x index %d\n", psci_states[i], i);
> > >       }
> > >
> > > +     if (i != num_state_nodes) {
> > > +             ret = -ENODEV;
> > > +             goto free_mem;
> > > +     }
> > > +
> > >       /* Idle states parsed correctly, initialize per-cpu pointer */
> > >       per_cpu(psci_power_state, cpu) = psci_states;
> > >       return 0;
> > > --
> > > 2.17.1
> > >
