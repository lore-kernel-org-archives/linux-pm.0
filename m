From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 0/4] PM / Domains: Improve support for CPUs in genpd
Date: Thu, 25 Apr 2019 12:32:24 +0200
Message-ID: <CAJZ5v0iK03ajPVE2LdkJHKBQzeeS+dkkaYfvUuVYAcZKStU-EQ@mail.gmail.com>
References: <20190425090413.10700-1-ulf.hansson@linaro.org>
 <CAJZ5v0jxGcFu-aqvyR4UgjRuCwB9q9fZCiXf+D3NL3TJ5OVEPA@mail.gmail.com>
 <CAPDyKFqP+92wwscW2V3352DVS1QM=DjMZ3e0uty1eQ4=5JyHWA@mail.gmail.com>
 <CAJZ5v0jTRF1wvcYTxfSd59ByhnzXdLL8CVg1qnUfQhAj1L1qLA@mail.gmail.com> <CAPDyKFq3QTjX5m9HoNYFTd-e-p_BXsqPH8s+P_yQ5YEJvHBoag@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFq3QTjX5m9HoNYFTd-e-p_BXsqPH8s+P_yQ5YEJvHBoag@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Rajendra Nayak <rnayak@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Niklas Cassel <niklas.cassel@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Apr 25, 2019 at 12:17 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Thu, 25 Apr 2019 at 12:14, Rafael J. Wysocki <rafael@kernel.org> wrote:
> >
> > On Thu, Apr 25, 2019 at 12:11 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > >
> > > On Thu, 25 Apr 2019 at 11:56, Rafael J. Wysocki <rafael@kernel.org> wrote:
> > > >
> > > > On Thu, Apr 25, 2019 at 11:04 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> > > > >
> > > > > Recently genpd was extended to cope with devices belonging to CPUs. However,
> > > > > attaching CPU devices via genpd_dev_pm_attach_by_id|name() doesn't work,
> > > > > because of the virtual device that genpd allocates in this path.
> > > > >
> > > > > In this series, this limitation is addressed, together with a few other related
> > > > > fixes/cleanups.
> > > > >
> > > > > Ulf Hansson (4):
> > > > >   PM / Domains: Use the base device for
> > > > >     driver_deferred_probe_check_state()
> > > > >   PM / Domains: Drop unused in-parameter to some genpd functions
> > > > >   PM / Domains: Search for the CPU device outside the genpd lock
> > > > >   PM / Domains: Allow to attach a CPU via
> > > > >     genpd_dev_pm_attach_by_id|name()
> > > > >
> > > > >  drivers/base/power/domain.c | 73 ++++++++++++++++++-------------------
> > > > >  include/linux/pm_domain.h   |  1 +
> > > > >  2 files changed, 36 insertions(+), 38 deletions(-)
> > > >
> > > > Are there any dependencies between this and the series you've recently posted?
> > >
> > > Yep. I should have stated that, sorry. This should be applied on top.
> >
> > On top of which series?
>
> [PATCH 0/3] PM / Domains: Improve support for multi PM domains
>
> and
>
> [PATCH v13 0/4] PM / Domains: Support hierarchical CPU arrangement (PSCI/ARM)

OK, thanks!
