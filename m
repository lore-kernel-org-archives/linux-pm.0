From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 2/8] PM / Domain: Add residency property to genpd states
Date: Thu, 6 Oct 2016 10:38:52 +0200
Message-ID: <CAPDyKFqw-yo8Ha-PJP3z1wc64Nq1QVr=U4V=0HEEh+BEPd6fKA@mail.gmail.com>
References: <1475699519-109623-1-git-send-email-lina.iyer@linaro.org> <1475699519-109623-3-git-send-email-lina.iyer@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f44.google.com ([74.125.82.44]:37573 "EHLO
        mail-wm0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S941845AbcJFIiy (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 6 Oct 2016 04:38:54 -0400
Received: by mail-wm0-f44.google.com with SMTP id b201so31253251wmb.0
        for <linux-pm@vger.kernel.org>; Thu, 06 Oct 2016 01:38:54 -0700 (PDT)
In-Reply-To: <1475699519-109623-3-git-send-email-lina.iyer@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: Kevin Hilman <khilman@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Andy Gross <andy.gross@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>, Brendan Jackman <brendan.jackman@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, Sudeep Holla <sudeep.holla@arm.com>, Juri Lelli <Juri.Lelli@arm.com>

On 5 October 2016 at 22:31, Lina Iyer <lina.iyer@linaro.org> wrote:
> Residency of a domain's idle state indicates that the minimum idle time
> for the domain's idle state to be beneficial for power. Add the
> parameter to the state node. Future patches, will use the residency
> value in the genpd governor to determine if it is worth while to enter
> an idle state.
>
> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>

Acked-by: Ulf Hansson <ulf.hansson@linaro.org>

Kind regards
Uffe

> ---
>  include/linux/pm_domain.h | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/include/linux/pm_domain.h b/include/linux/pm_domain.h
> index bd1ffb9..c113713 100644
> --- a/include/linux/pm_domain.h
> +++ b/include/linux/pm_domain.h
> @@ -38,6 +38,7 @@ struct gpd_dev_ops {
>  struct genpd_power_state {
>         s64 power_off_latency_ns;
>         s64 power_on_latency_ns;
> +       s64 residency_ns;
>  };
>
>  struct generic_pm_domain {
> --
> 2.7.4
>
