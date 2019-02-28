From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 5/7] drivers: firmware: psci: Simplify state node parsing
Date: Thu, 28 Feb 2019 23:26:41 +0100
Message-ID: <CAPDyKFrdwkERTGOkfjCZv-cb0sTvDqtNWY6kKyaeWLHSumRp1A@mail.gmail.com>
References: <20190228135919.3747-1-ulf.hansson@linaro.org> <20190228135919.3747-6-ulf.hansson@linaro.org>
 <a66689f2-51ba-6358-f161-66778daa1f09@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a66689f2-51ba-6358-f161-66778daa1f09@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lina Iyer <ilina@codeaurora.org>, Linux PM <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 28 Feb 2019 at 16:40, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 28/02/2019 14:59, Ulf Hansson wrote:
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
>
> why -1 ?

Because of the WFI state. The cpuidle-arm driver always carries this
state at index 0, which also is never used in
psci_cpu_suspend_enter(), where the similar is taken into account.

It's a bit of magic, so perhaps someone should post a patch that
documents this a bit better in the code, wherever it makes sense.

>
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
> >

Again, thanks a lot for reviewing!

Kind regards
Uffe
