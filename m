From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v10 01/27] PM / Domains: Add generic data pointer to
 genpd_power_state struct
Date: Tue, 18 Dec 2018 12:53:28 +0100
Message-ID: <CAPDyKFp=z0TS5oDD7muRCSuqqJ5sj-vOUyTf9tUJfXgWyE64Mg@mail.gmail.com>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
 <20181129174700.16585-2-ulf.hansson@linaro.org> <81caa4b6-d0ac-f351-2ecf-47fb0f7dcc74@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <81caa4b6-d0ac-f351-2ecf-47fb0f7dcc74@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux PM <linux-pm@vger.kernel.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 18 Dec 2018 at 11:39, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
> On 29/11/2018 18:46, Ulf Hansson wrote:
> > Let's add a data pointer to the genpd_power_state struct, to allow a genpd
> > backend driver to store per state specific data. In order to introduce the
> > pointer, we also need to adopt how genpd frees the allocated data for the
> > default genpd_power_state struct, that it may allocate at pm_genpd_init().
> >
> > More precisely, let's use an internal genpd flag to understand when the
> > states needs to be freed by genpd. When freeing the states data in
> > genpd_remove(), let's also clear the corresponding genpd->states pointer
> > and reset the genpd->state_count. In this way, a genpd backend driver
> > becomes aware of when there is state specific data for it to free.
> >
> > Cc: Lina Iyer <ilina@codeaurora.org>
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > ---
> >
> > Changes in v10:
> >       - Update the patch allow backend drivers to free the states specific
> >         data during genpd removal. Due to this added complexity, I decided to
> >         keep the patch separate, rather than fold it into the patch that makes
> >         use of the new void pointer, which was suggested by Rafael.
> >       - Claim authorship of the patch as lots of changes has been done since
> >         the original pick up from Lina Iyer.
> >
> > ---
> >  drivers/base/power/domain.c | 8 ++++++--
> >  include/linux/pm_domain.h   | 3 ++-
> >  2 files changed, 8 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> > index 7f38a92b444a..e27b91d36a2a 100644
> > --- a/drivers/base/power/domain.c
> > +++ b/drivers/base/power/domain.c
> > @@ -1620,7 +1620,7 @@ static int genpd_set_default_power_state(struct generic_pm_domain *genpd)
> >
> >       genpd->states = state;
> >       genpd->state_count = 1;
> > -     genpd->free = state;
> > +     genpd->free_state = true;
> >
> >       return 0;
> >  }
> > @@ -1736,7 +1736,11 @@ static int genpd_remove(struct generic_pm_domain *genpd)
> >       list_del(&genpd->gpd_list_node);
> >       genpd_unlock(genpd);
> >       cancel_work_sync(&genpd->power_off_work);
> > -     kfree(genpd->free);
> > +     if (genpd->free_state) {
> > +             kfree(genpd->states);
> > +             genpd->states = NULL;
> > +             genpd->state_count = 0;
>
> Why these two initializations? After genpd_remove, this structure
> shouldn't be used anymore, no ?

Correct.

>
> > +     }
>
> Instead of a flag, replacing the 'free' pointer to a 'free' callback
> will allow to keep the free path self-encapsulated in domain.c
>
> genpd->free(genpd->states);

Right, I get your idea and it makes sense. Let me convert to that.

>
> Patch 18/27 can fill this field with its specific free pointer.

Yep!

[...]

Thanks for reviewing!

Kind regards
Uffe
