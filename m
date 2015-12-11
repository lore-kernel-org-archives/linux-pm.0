From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH RFC 07/27] PM / Domains: Read domain residency from DT
Date: Fri, 11 Dec 2015 12:54:17 +0100
Message-ID: <CAPDyKFqwmvxvAAkreryrHhMfvs-9sxanOoz+D7kNeKgRorwRJQ@mail.gmail.com>
References: <1447799871-56374-1-git-send-email-lina.iyer@linaro.org>
	<1447799871-56374-8-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qk0-f175.google.com ([209.85.220.175]:33525 "EHLO
	mail-qk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754370AbbLKLyS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Dec 2015 06:54:18 -0500
Received: by qkdb5 with SMTP id b5so34445808qkd.0
        for <linux-pm@vger.kernel.org>; Fri, 11 Dec 2015 03:54:17 -0800 (PST)
In-Reply-To: <1447799871-56374-8-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Geert Uytterhoeven <geert@linux-m68k.org>, =?UTF-8?Q?Krzysztof_Koz=C5=82owski?= <k.kozlowski@samsung.com>, msivasub@codeaurora.org, Andy Gross <agross@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Axel Haslam <ahaslam@baylibre.com>, Marc Titinger <mtitinger@baylibre.com>

On 17 November 2015 at 23:37, Lina Iyer <lina.iyer@linaro.org> wrote:
> Domains that have expensive suspend resume operations, may require a
> certain amount of time be spent in an idle state to reap the power
> saving benefit. Such domains, may provide the residency requirement for
> a domain state.
>
> Read the residency for a domain state from the DT. A domain governor may
> use this information in determining the state for the domain.
>
> Cc: Axel Haslam <ahaslam@baylibre.com>
> Cc: Marc Titinger <mtitinger@baylibre.com>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
> ---
>  Documentation/devicetree/bindings/power/power_domain.txt | 7 +++++++

Please split DT documentation into a separate patch preceding $subject
patch. Don't forget to send it to the DT maintainers as well.

>  drivers/base/power/domain.c                              | 6 ++++++
>  include/linux/pm_domain.h                                | 1 +
>  3 files changed, 14 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/power/power_domain.txt b/Documentation/devicetree/bindings/power/power_domain.txt
> index ecfaf44..d71da29 100644
> --- a/Documentation/devicetree/bindings/power/power_domain.txt
> +++ b/Documentation/devicetree/bindings/power/power_domain.txt
> @@ -67,6 +67,13 @@ have the following properties -
>                 If omitted, this is assumed to be equal to:
>                         entry-latency-us + exit-latency-us
>
> +       - residency-us:
> +               Usage: Optional
> +               Value type: <prop-encoded-array>
> +               Definition: A u32 value representing the time for which a
> +               domain must be idle in the state to reap power saving benefits
> +               of entering the state.
> +
>         - state-param:
>                 Usage: Optional
>                 Value type: <prop-encoded-array>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 9a0df09..abc81bd 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1245,6 +1245,7 @@ static int genpd_alloc_states_data(struct generic_pm_domain *genpd,
>                         st[i].power_on_latency_ns;
>                 genpd->states[i].power_off_latency_ns =
>                         st[i].power_off_latency_ns;
> +               genpd->states[i].residency_ns = st[i].residency_ns;
>                 genpd->states[i].param = st[i].param;
>         }
>
> @@ -1513,6 +1514,7 @@ static int of_get_genpd_power_state(struct genpd_power_state *genpd_state,
>         const struct of_device_id *match_id;
>         int err = 0;
>         u32 latency;
> +       u32 residency;
>         u32 param;
>
>         match_id = of_match_node(power_state_match, state_node);
> @@ -1554,6 +1556,10 @@ static int of_get_genpd_power_state(struct genpd_power_state *genpd_state,
>                 return -EINVAL;
>         }
>
> +       err = of_property_read_u32(state_node, "residency-us", &residency);
> +       if (!err)
> +               genpd_state->residency_ns = 1000 * residency;
> +
>         err = of_property_read_u32(state_node, "state-param", &param);
>         if (!err)
>                 genpd_state->param = param;
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index 108a4b3..fed024a 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -41,6 +41,7 @@ struct genpd_power_state {
>         char *name;
>         s64 power_off_latency_ns;
>         s64 power_on_latency_ns;
> +       s64 residency_ns;
>         u32 param;
>  };
>
> --
> 2.1.4
>

A general comment.

I would as step prior $subject patch, add the mechanism in genpd to
deal with this new concept of residency values. When *all* that
mechanism is in place (perhaps it needs more than one patch), then add
the DT parts.

Kind regards
Uffe
