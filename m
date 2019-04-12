From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v14 4/4] PM / Domains: Add genpd governor for CPUs
Date: Fri, 12 Apr 2019 09:59:52 +0200
Message-ID: <CAPDyKFqesUc5PaZGvkMPcpiLUX1cRvFcSCVdv+p6LtpO4QpK3g@mail.gmail.com>
References: <20190411181733.21437-1-ulf.hansson@linaro.org> <CAJZ5v0hVkgF2MYUh4VkXN0L2ZtxMoC8bUV6CY7=fAnSHRLpqUA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0hVkgF2MYUh4VkXN0L2ZtxMoC8bUV6CY7=fAnSHRLpqUA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Stephen Boyd <sboyd@kernel.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>Linux
List-Id: linux-pm@vger.kernel.org

On Thu, 11 Apr 2019 at 22:44, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Apr 11, 2019 at 8:17 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > After some preceding changes, PM domains managed by genpd may contain
> > CPU devices, so idle state residency values should be taken into
> > account during the state selection process. [The residency value is
> > the minimum amount of time to be spent by a CPU (or a group of CPUs)
> > in an idle state in order to save more energy than could be saved
> > by picking up a shallower idle state.]
> >
> > For this purpose, add a new genpd governor, pm_domain_cpu_gov, to be
> > used for selecting idle states of PM domains with CPU devices attached
> > either directly or through subdomains.
> >
> > The new governor computes the minimum expected idle duration for all
> > online CPUs attached to a PM domain and its subdomains.  Next, it
> > finds the deepest idle state whose target residency is within the
> > expected idle duration and selects it as the target idle state of
> > the domain.
> >
> > It should be noted that the minimum expected idle duration computation
> > is based on the closest timer event information stored in the per-CPU
> > variables cpuidle_devices for all of the CPUs in the domain.  That
> > needs to be revisited in future, as obviously there are other reasons
> > why a CPU may be woken up from idle.
> >
> > Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
> > Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> > Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
> > [ rjw: Changelog ]
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Applied instead of the previous version, thanks!

Thanks - and sorry for the mess!

When things have settled, here's the reposted PSCI cleanup series in
case it slipped through your filters.
https://patchwork.kernel.org/project/linux-pm/list/?series=103537

Kind regards
Uffe
