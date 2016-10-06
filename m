From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 4/8] PM / Domains: Add fwnode provider to genpd states
Date: Thu, 6 Oct 2016 14:01:33 +0200
Message-ID: <CAPDyKFrsLjchkbkqg4O=RfKamO+EgOhZtzw1-_3e5QphLON0XQ@mail.gmail.com>
References: <1475699519-109623-1-git-send-email-lina.iyer@linaro.org> <1475699519-109623-5-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <1475699519-109623-5-git-send-email-lina.iyer@linaro.org>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Brendan Jackman <brendan.jackman@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

On 5 October 2016 at 22:31, Lina Iyer <lina.iyer@linaro.org> wrote:
> Save the fwnode for the genpd state in the state node. PM Domain clients
> may use the fwnode to read in the rest of the properties for the domain
> state.

What is the "rest"? I assume you mean the non PM domain generic parts,
but perhaps you could elaborate a bit on that?

>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  drivers/base/power/domain.c | 1 +
>  include/linux/pm_domain.h   | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 368a5b8..52fcdb2 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1937,6 +1937,7 @@ static int read_genpd_state(struct genpd_power_state *genpd_state,
>         latency = entry_latency + exit_latency;
>         genpd_state->power_on_latency_ns = 1000 * latency;
>         genpd_state->power_off_latency_ns = 1000 * entry_latency;
> +       genpd_state->provider = &state_node->fwnode;
>
>         return 0;
>  }
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 4c9152d..eacfa71 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -39,6 +39,7 @@ struct genpd_power_state {
>         s64 power_off_latency_ns;
>         s64 power_on_latency_ns;
>         s64 residency_ns;
> +       struct fwnode_handle *provider;

I don't think this is a provider, but just a fwnode_handle to a
domain-idle-state. Therefore, I would suggest you to rename it to
"fwnode" instead.

>  };
>
>  struct generic_pm_domain {
> --
> 2.7.4
>

Kind regards
Uffe
