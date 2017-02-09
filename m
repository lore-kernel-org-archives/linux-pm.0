From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 1/2] PM / Domains: Ignore domain-idle-states that are not
 compatible
Date: Thu, 9 Feb 2017 09:40:29 +0100
Message-ID: <CAPDyKFpj4LNPH-V2cziw1ULm9Ff9a3jeyrQK9XVp2G2OaQbtXw@mail.gmail.com>
References: <1486571692-33212-1-git-send-email-lina.iyer@linaro.org>
 <1486571692-33212-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1486571692-33212-3-git-send-email-lina.iyer@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@codeaurora.org>, Sudeep Holla <sudeep.holla@arm.com>, Brendan Jackman <brendan.jackman@arm.com>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Andy Gross <andy.gross@linaro.org>, Rob Herring <robh@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On 8 February 2017 at 17:34, Lina Iyer <lina.iyer@linaro.org> wrote:
> domain-idle-states property may have phandles to idle state bindings
> that may not be compatible with idle state definition defined in [1].

I don't find the reference to [1] in the change-log, could you please add it.

> Such phandles would just be ignored and not throw and error when read by
> the domain core.

Perhaps, you could also share a minimal snipped from a DTS as it helps
to describe why and what this change is needed.

>
> Cc: <devicetree@vger.kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/power_domain.txt |  4 +++-
>  drivers/base/power/domain.c                              | 16 +++++++++-------
>  2 files changed, 12 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> index 723e1ad..940707d 100644
> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> @@ -31,7 +31,9 @@ Optional properties:
>
>  - domain-idle-states : A phandle of an idle-state that shall be soaked into a
>                  generic domain power state. The idle state definitions are
> -                compatible with domain-idle-state specified in [1].
> +                compatible with domain-idle-state specified in [1]. phandles
> +                that are not compatible with domain-idle-state will be
> +                ignored.
>    The domain-idle-state property reflects the idle state of this PM domain and
>    not the idle states of the devices or sub-domains in the PM domain. Devices
>    and sub-domains have their own idle-states independent of the parent
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 6b23d82..3825bb9 100644
> --- a/drivers/base/power/domain.c

Always split DT documentation changes from the code changes and make
the DT doc changes precede the code changes in the series of patches.

> +++ b/drivers/base/power/domain.c
> @@ -2065,11 +2065,6 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
>         int err;
>         u32 residency;
>         u32 entry_latency, exit_latency;
> -       const struct of_device_id *match_id;
> -
> -       match_id = of_match_node(idle_state_match, state_node);
> -       if (!match_id)
> -               return -EINVAL;
>
>         err = of_property_read_u32(state_node, "entry-latency-us",
>                                                 &entry_latency);
> @@ -2118,6 +2113,7 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>         int err, ret;
>         int count;
>         struct of_phandle_iterator it;
> +       const struct of_device_id *match_id;
>
>         count = of_count_phandle_with_args(dn, "domain-idle-states", NULL);
>         if (count <= 0)
> @@ -2130,6 +2126,9 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>         /* Loop over the phandles until all the requested entry is found */
>         of_for_each_phandle(&it, err, dn, "domain-idle-states", NULL, 0) {
>                 np = it.node;
> +               match_id = of_match_node(idle_state_match, np);
> +               if (!match_id)
> +                       continue;

Earlier we have allocated "count" numbers of struct genpd_power_state,
by using a kcalloc().

This change may lead to that we could have allocated more memory than
actually needed - because there may be some nodes that doesn't match.

Perhaps it's better to do a pre-iteration to find the real numbers of
how many struct genpd_power_state we actually need to allocate!?

>                 ret = genpd_parse_state(&st[i++], np);
>                 if (ret) {
>                         pr_err
> @@ -2141,8 +2140,11 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>                 }
>         }
>
> -       *n = count;
> -       *states = st;
> +       *n = i;
> +       if (!i)
> +               kfree(st);
> +       else
> +               *states = st;
>
>         return 0;
>  }
> --
> 2.7.4
>

Kind regards
Uffe
