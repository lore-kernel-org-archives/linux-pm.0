From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5/7] drivers: firmware: psci: Simplify state node parsing
Date: Mon, 4 Mar 2019 11:14:18 +0100
Message-ID: <CAPDyKFrqp6_NkTBVXZTa3j+-6y+m7aX2y6t=nH=Tjdo4BgMDtQ@mail.gmail.com>
References: <20190228135919.3747-1-ulf.hansson@linaro.org> <20190228135919.3747-6-ulf.hansson@linaro.org>
 <20190301172810.GR15517@lakrids.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190301172810.GR15517@lakrids.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Rutland <mark.rutland@arm.com>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Lina Iyer <ilina@codeaurora.org>, Linux PM <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Fri, 1 Mar 2019 at 18:28, Mark Rutland <mark.rutland@arm.com> wrote:
>
> On Thu, Feb 28, 2019 at 02:59:17PM +0100, Ulf Hansson wrote:
> > Instead of iterating through all the state nodes in DT, to find out how
> > many states that needs to be allocated, let's use the number already known
> > by the cpuidle driver. In this way we can drop the iteration altogether.
> >
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >  drivers/firmware/psci/psci.c | 25 ++++++++++++-------------
> >  1 file changed, 12 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index d50b46a0528f..cbfc936d251c 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -290,26 +290,20 @@ static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
> >  static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
> >                       struct device_node *cpu_node, int cpu)
> >  {
> > -     int i, ret = 0, count = 0;
> > +     int i, ret = 0, num_state_nodes = drv->state_count - 1;
> >       u32 *psci_states;
> >       struct device_node *state_node;
> >
> > -     /* Count idle states */
> > -     while ((state_node = of_parse_phandle(cpu_node, "cpu-idle-states",
> > -                                           count))) {
> > -             count++;
> > -             of_node_put(state_node);
> > -     }
> > -
>
> To be honest, I'd rather not tighten the coupling with the cpuidle
> driver here. For example, I'm not that happy with the PSCI backend
> having to know the driver has a specific WFI state.

If you ask me, the coupling is already there, only that it's hidden by
taking assumptions about the WFI state in the code.

However, I certainly agree with you, that this isn't very nice.

>
> IIUC we could get rid of the explicit counting with something like:
>
>         count = of_parse_phandle_with_args(cpu_node, "cpu-idle-states", NULL);
>
> ... but I'm not sure that the overall change is a simplification.

In my opinion, no it doesn't.

To me, it seems a kind of silly (and in-efficient) to do an OF parsing
that has already been done and given the information we need.

>
> Does this change make it easier to plumb in something in future?

Yes, I need this for additional changes on top.

Note that, patch4 also provides the opportunity to do a similar
cleanup of the initialization code in drivers/soc/qcom/spm.c. I
haven't made that part of this series though.

I guess in the end, we need to accept that part of the psci driver is
really a cpuidle driver. Trying to keep them entirely separate,
doesn't come without complexity/churns.

While working on psci changes in the recent series I have posted, I
was even considering adding a completely new cpuidle driver for psci
(in drivers/cpuidle/*) and instead define a number of psci interface
functions, which that driver could call. That would probably be a
better split, but requires quite some changes.

So, what do you want me to do with this?

>
> Thanks,
> Mark.

Thanks a lot for reviewing!

Kind regards
Uffe

>
> > -     if (!count)
> > -             return -ENODEV;
> > -
> > -     psci_states = kcalloc(count, sizeof(*psci_states), GFP_KERNEL);
> > +     psci_states = kcalloc(num_state_nodes, sizeof(*psci_states),
> > +                     GFP_KERNEL);
> >       if (!psci_states)
> >               return -ENOMEM;
> >
> > -     for (i = 0; i < count; i++) {
> > +     for (i = 0; i < num_state_nodes; i++) {
> >               state_node = of_parse_phandle(cpu_node, "cpu-idle-states", i);
> > +             if (!state_node)
> > +                     break;
> > +
> >               ret = psci_dt_parse_state_node(state_node, &psci_states[i]);
> >               of_node_put(state_node);
> >
> > @@ -319,6 +313,11 @@ static int psci_dt_cpu_init_idle(struct cpuidle_driver *drv,
> >               pr_debug("psci-power-state %#x index %d\n", psci_states[i], i);
> >       }
> >
> > +     if (i != num_state_nodes) {
> > +             ret = -ENODEV;
> > +             goto free_mem;
> > +     }
> > +
> >       /* Idle states parsed correctly, initialize per-cpu pointer */
> >       per_cpu(psci_power_state, cpu) = psci_states;
> >       return 0;
> > --
> > 2.17.1
> >
