From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH] base/power/domain: fix wrong do_div() usage
Date: Thu, 5 Nov 2015 09:34:37 +0100
Message-ID: <CAPDyKFoB2FgVsK-McmWrmjZfgzmLas3V3b0+RQB_ao9YEgzHAA@mail.gmail.com>
References: <alpine.LFD.2.20.1511041325170.630@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yk0-f179.google.com ([209.85.160.179]:34157 "EHLO
	mail-yk0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030329AbbKEIei (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2015 03:34:38 -0500
Received: by ykdr3 with SMTP id r3so118700998ykd.1
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2015 00:34:37 -0800 (PST)
In-Reply-To: <alpine.LFD.2.20.1511041325170.630@knanqh.ubzr>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 4 November 2015 at 19:29, Nicolas Pitre <nicolas.pitre@linaro.org> wrote:
> do_div() is meant to be used with an unsigned dividend.
>
> Signed-off-by: Nicolas Pitre <nico@linaro.org>
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 16550c63d6..5722ad73ad 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -142,7 +142,7 @@ static void genpd_sd_counter_inc(struct generic_pm_domain *genpd)
>
>  static void genpd_recalc_cpu_exit_latency(struct generic_pm_domain *genpd)
>  {
> -       s64 usecs64;
> +       u64 usecs64;
>
>         if (!genpd->cpuidle_data)
>                 return;

Hi Nico,

The entire funtion genpd_recalc_cpu_exit_latency() has been removed in
the below commit. Anyway, thanks for pointing out the issue.

commit cea3ad93d9a5e054d916f1ad71da02cb306e4828
Author: Daniel Lezcano <daniel.lezcano@linaro.org>
Date:   Tue Sep 1 20:37:49 2015 +0200
PM / Domains: Remove cpuidle attach

The patch should show up in 4.4 rc1, via Rafael's linux-pm tree.

Kind regards
Uffe
