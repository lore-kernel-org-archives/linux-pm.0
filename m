From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 0/4] PM / Domains: Improve support for CPUs in genpd
Date: Thu, 25 Apr 2019 12:11:09 +0200
Message-ID: <CAPDyKFqP+92wwscW2V3352DVS1QM=DjMZ3e0uty1eQ4=5JyHWA@mail.gmail.com>
References: <20190425090413.10700-1-ulf.hansson@linaro.org>
 <CAJZ5v0jxGcFu-aqvyR4UgjRuCwB9q9fZCiXf+D3NL3TJ5OVEPA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAJZ5v0jxGcFu-aqvyR4UgjRuCwB9q9fZCiXf+D3NL3TJ5OVEPA@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Rajendra Nayak <rnayak@codeaurora.org>, Linux PM <linux-pm@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Tony Lindgren <tony@atomide.com>, Niklas Cassel <niklas.cassel@linaro.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 25 Apr 2019 at 11:56, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Thu, Apr 25, 2019 at 11:04 AM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > Recently genpd was extended to cope with devices belonging to CPUs. However,
> > attaching CPU devices via genpd_dev_pm_attach_by_id|name() doesn't work,
> > because of the virtual device that genpd allocates in this path.
> >
> > In this series, this limitation is addressed, together with a few other related
> > fixes/cleanups.
> >
> > Ulf Hansson (4):
> >   PM / Domains: Use the base device for
> >     driver_deferred_probe_check_state()
> >   PM / Domains: Drop unused in-parameter to some genpd functions
> >   PM / Domains: Search for the CPU device outside the genpd lock
> >   PM / Domains: Allow to attach a CPU via
> >     genpd_dev_pm_attach_by_id|name()
> >
> >  drivers/base/power/domain.c | 73 ++++++++++++++++++-------------------
> >  include/linux/pm_domain.h   |  1 +
> >  2 files changed, 36 insertions(+), 38 deletions(-)
>
> Are there any dependencies between this and the series you've recently posted?

Yep. I should have stated that, sorry. This should be applied on top.

Kind regards
Uffe
