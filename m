From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] PM / Domains: Convert to using %pOF instead of full_name
Date: Fri, 21 Jul 2017 09:56:52 +0200
Message-ID: <CAPDyKFpBGY+xZyubW6HdQyoJ1GVkEM04ZiJSB_hOq_gpjqZ4CQ@mail.gmail.com>
References: <20170718214339.7774-10-robh@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ua0-f178.google.com ([209.85.217.178]:33744 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752979AbdGUH4x (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 21 Jul 2017 03:56:53 -0400
Received: by mail-ua0-f178.google.com with SMTP id 80so39980514uas.0
        for <linux-pm@vger.kernel.org>; Fri, 21 Jul 2017 00:56:53 -0700 (PDT)
In-Reply-To: <20170718214339.7774-10-robh@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 18 July 2017 at 23:42, Rob Herring <robh@kernel.org> wrote:
> Now that we have a custom printf format specifier, convert users of
> full_name to use %pOF instead. This is preparation to remove storing
> of the full path string for each node.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Kevin Hilman <khilman@kernel.org>
> Cc: Ulf Hansson <ulf.hansson@linaro.org>
> Cc: Pavel Machek <pavel@ucw.cz>
> Cc: Len Brown <len.brown@intel.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: linux-pm@vger.kernel.org

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 3b8210ebb50e..d0989f9b5e67 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1743,7 +1743,7 @@ static int genpd_add_provider(struct device_node *np, genpd_xlate_t xlate,
>         mutex_lock(&of_genpd_mutex);
>         list_add(&cp->link, &of_genpd_providers);
>         mutex_unlock(&of_genpd_mutex);
> -       pr_debug("Added domain provider from %s\n", np->full_name);
> +       pr_debug("Added domain provider from %pOF\n", np);
>
>         return 0;
>  }
> @@ -2149,16 +2149,16 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
>         err = of_property_read_u32(state_node, "entry-latency-us",
>                                                 &entry_latency);
>         if (err) {
> -               pr_debug(" * %s missing entry-latency-us property\n",
> -                                               state_node->full_name);
> +               pr_debug(" * %pOF missing entry-latency-us property\n",
> +                                               state_node);
>                 return -EINVAL;
>         }
>
>         err = of_property_read_u32(state_node, "exit-latency-us",
>                                                 &exit_latency);
>         if (err) {
> -               pr_debug(" * %s missing exit-latency-us property\n",
> -                                               state_node->full_name);
> +               pr_debug(" * %pOF missing exit-latency-us property\n",
> +                                               state_node);
>                 return -EINVAL;
>         }
>
> @@ -2212,8 +2212,8 @@ int of_genpd_parse_idle_states(struct device_node *dn,
>                 ret = genpd_parse_state(&st[i++], np);
>                 if (ret) {
>                         pr_err
> -                       ("Parsing idle state node %s failed with err %d\n",
> -                                                       np->full_name, ret);
> +                       ("Parsing idle state node %pOF failed with err %d\n",
> +                                                       np, ret);
>                         of_node_put(np);
>                         kfree(st);
>                         return ret;
> --
> 2.11.0
>
