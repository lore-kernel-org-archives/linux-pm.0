From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH v2 4/8] PM / Domains: Save the fwnode in genpd_power_state
Date: Mon, 10 Oct 2016 12:03:33 +0200
Message-ID: <CAPDyKFqp8B67Hxpj+07aQ_8kEZNJ_5M+MexWz21jLpWWacw+bw@mail.gmail.com>
References: <1475879821-8035-1-git-send-email-lina.iyer@linaro.org> <1475879821-8035-5-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qt0-f171.google.com ([209.85.216.171]:34290 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbcJJKDf (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 Oct 2016 06:03:35 -0400
Received: by mail-qt0-f171.google.com with SMTP id q7so48535467qtq.1
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2016 03:03:34 -0700 (PDT)
In-Reply-To: <1475879821-8035-5-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Brendan Jackman <brendan.jackman@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>

On 8 October 2016 at 00:36, Lina Iyer <lina.iyer@linaro.org> wrote:
> Save the fwnode for the genpd state in the state node. PM Domain clients
> may use the fwnode to read in the platform specific domain state
> properties and associate them with the state.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  drivers/base/power/domain.c | 1 +
>  include/linux/pm_domain.h   | 1 +
>  2 files changed, 2 insertions(+)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 4208b67..e0f31fe 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -1957,6 +1957,7 @@ static int genpd_parse_state(struct genpd_power_state *genpd_state,
>
>         genpd_state->power_on_latency_ns = 1000 * exit_latency;
>         genpd_state->power_off_latency_ns = 1000 * entry_latency;
> +       genpd_state->fwnode = &state_node->fwnode;
>
>         return 0;
>  }
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index b489496..6a89881 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -39,6 +39,7 @@ struct genpd_power_state {
>         s64 power_off_latency_ns;
>         s64 power_on_latency_ns;
>         s64 residency_ns;
> +       struct fwnode_handle *fwnode;
>  };
>
>  struct generic_pm_domain {
> --
> 2.7.4
>
