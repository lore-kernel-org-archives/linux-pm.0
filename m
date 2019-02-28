From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 3/7] drivers: firmware: psci: Split psci_dt_cpu_init_idle()
Date: Thu, 28 Feb 2019 23:13:09 +0100
Message-ID: <CAPDyKFo8nZwNHuxY0Vr3CXW=Z5B4ho7dy_iiDD5pS3yUWGBA7A@mail.gmail.com>
References: <20190228135919.3747-1-ulf.hansson@linaro.org> <20190228135919.3747-4-ulf.hansson@linaro.org>
 <02a96f2c-dde1-73be-683d-b51d8c6b1b03@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <02a96f2c-dde1-73be-683d-b51d8c6b1b03@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Lina Iyer <ilina@codeaurora.org>, Linux PM <linux-pm@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 28 Feb 2019 at 15:42, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 28/02/2019 14:59, Ulf Hansson wrote:
> > Let's split the psci_dt_cpu_init_idle() function into two functions. This
> > makes the code clearer and provides better re-usability.
> >
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
>
> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>
> but one question below.
>
>
> > ---
> >  drivers/firmware/psci/psci.c | 42 ++++++++++++++++++++----------------
> >  1 file changed, 23 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.c
> > index c80ec1d03274..9788bfc1cf8b 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -270,9 +270,26 @@ static int __init psci_features(u32 psci_func_id)
> >  #ifdef CONFIG_CPU_IDLE
> >  static DEFINE_PER_CPU_READ_MOSTLY(u32 *, psci_power_state);
> >
> > +static int psci_dt_parse_state_node(struct device_node *np, u32 *state)
> > +{
> > +     int err = of_property_read_u32(np, "arm,psci-suspend-param", state);
> > +
> > +     if (err) {
> > +             pr_warn("%pOF missing arm,psci-suspend-param property\n", np);
> > +             return err;
> > +     }
> > +
> > +     if (!psci_power_state_is_valid(*state)) {
> > +             pr_warn("Invalid PSCI power state %#x\n", *state);
> > +             return -EINVAL;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >  static int psci_dt_cpu_init_idle(struct device_node *cpu_node, int cpu)
> >  {
> > -     int i, ret, count = 0;
> > +     int i, ret = 0, count = 0;
>
> Why do you need to intialize the ret variable? If the count is zero we
> go directly to return 0, otherwise we enter in the loop and ret is
> affected with the new function call.

Depending on the compiler and the compiler flags, one could otherwise
potentially get a warning about using an uninitialized variable at the
free_mem label (not shown in the patch).

So, I just wanted to play safe.

Thanks a lot for reviewing!

Kind regards
Uffe
