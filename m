From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 13/27] drivers: firmware: psci: Support hierarchical
 CPU idle states
Date: Wed, 19 Dec 2018 13:53:23 +0100
Message-ID: <CAPDyKFpa6cCfQtfNo=CN0=BpY6bARfnVWRH0N=apQgVr1m24Og@mail.gmail.com>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-14-ulf.hansson@linaro.org> <a5c19c01-31d5-f703-663c-3d5bd2ea8201@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <a5c19c01-31d5-f703-663c-3d5bd2ea8201@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux PM <linux-pm@vger.kernel.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Lina Iyer <lina.iyer@linaro.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 19 Dec 2018 at 13:11, Daniel Lezcano <daniel.lezcano@linaro.org> wr=
ote:
>
> On 29/11/2018 18:46, Ulf Hansson wrote:
> > From: Lina Iyer <lina.iyer@linaro.org>
> >
> > Currently CPU's idle states are represented in a flattened model, via t=
he
> > "cpu-idle-states" binding from within the CPU's device nodes.
> >
> > Support the hierarchical layout, simply by converting to calling the ne=
w OF
> > helper, of_get_cpu_state_node().
> >
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
> > Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> > Co-developed-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
>
> Fold it with 07/27 ?

I can do that. However, normally we try to keep changes that touches
different subsystems, separate from each other. Of course sometimes
it's not possible and sometimes it just doesn't make sense to separate
changes.

Perhaps the PSCI maintainers and Rafael can give their opinion.

Kind regards
Uffe

>
> >
> > Changes in v10:
> >       - None.
> >
> > ---
> >  drivers/firmware/psci/psci.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/firmware/psci/psci.c b/drivers/firmware/psci/psci.=
c
> > index cbfc936d251c..631e20720a22 100644
> > --- a/drivers/firmware/psci/psci.c
> > +++ b/drivers/firmware/psci/psci.c
> > @@ -300,7 +300,7 @@ static int psci_dt_cpu_init_idle(struct cpuidle_dri=
ver *drv,
> >               return -ENOMEM;
> >
> >       for (i =3D 0; i < num_state_nodes; i++) {
> > -             state_node =3D of_parse_phandle(cpu_node, "cpu-idle-state=
s", i);
> > +             state_node =3D of_get_cpu_state_node(cpu_node, i);
> >               if (!state_node)
> >                       break;
> >
> >
>
>
> --
>  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for A=
RM SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
