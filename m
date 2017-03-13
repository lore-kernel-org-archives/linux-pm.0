From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH V5 1/9] PM / Domains: Ignore domain-idle-states that are
 not compatible
Date: Mon, 13 Mar 2017 16:56:06 +0100
Message-ID: <CAPDyKFqHzVJd0+rEPDmOp9BCtbVSRtvnobGemCnmTabmu6x=Sg@mail.gmail.com>
References: <1488573695-106680-1-git-send-email-lina.iyer@linaro.org> <1488573695-106680-2-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f53.google.com ([209.85.213.53]:35933 "EHLO
        mail-vk0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752359AbdCMP4I (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 13 Mar 2017 11:56:08 -0400
Received: by mail-vk0-f53.google.com with SMTP id t8so37455812vke.3
        for <linux-pm@vger.kernel.org>; Mon, 13 Mar 2017 08:56:07 -0700 (PDT)
In-Reply-To: <1488573695-106680-2-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Brendan Jackman <brendan.jackman@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh@kernel.org>

On 3 March 2017 at 21:41, Lina Iyer <lina.iyer@linaro.org> wrote:
> domain-idle-states property may have phandles to idle state bindings
> that may not be compatible with idle state definition defined in [1].

I can't find the reference to [1] here, perhaps just point to the DT
doc file path is better.

> Such phandles would just be ignored and not throw and error when read by
> the domain core.
>
> Cc: <devicetree@vger.kernel.org>
> Cc: Rob Herring <robh@kernel.org>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

With an updated change-log, you may add:

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

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
> index e697dec..de3e489 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -2079,11 +2079,6 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
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
> @@ -2132,6 +2127,7 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>         int err, ret;
>         int count;
>         struct of_phandle_iterator it;
> +       const struct of_device_id *match_id;
>
>         count = of_count_phandle_with_args(dn, "domain-idle-states", NULL);
>         if (count <= 0)
> @@ -2144,6 +2140,9 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>         /* Loop over the phandles until all the requested entry is found */
>         of_for_each_phandle(&it, err, dn, "domain-idle-states", NULL, 0) {
>                 np = it.node;
> +               match_id = of_match_node(idle_state_match, np);
> +               if (!match_id)
> +                       continue;
>                 ret = genpd_parse_state(&st[i++], np);
>                 if (ret) {
>                         pr_err
> @@ -2155,8 +2154,11 @@ int of_genpd_parse_idle_states(struct device_node *dn,
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
