From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: unicore32: replace IS_ERR and PTR_ERR with PTR_ERR_OR_ZERO
Date: Fri, 11 Apr 2014 13:45:55 +0530
Message-ID: <CAKohpomaPtvxFXKcCm-pF+xSXrbN6Fg=QvfHSYkzDhWcWX005w@mail.gmail.com>
References: <1397203178-16780-1-git-send-email-duanj.fnst@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f45.google.com ([209.85.219.45]:40680 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755893AbaDKIP4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Apr 2014 04:15:56 -0400
Received: by mail-oa0-f45.google.com with SMTP id eb12so5740340oac.4
        for <linux-pm@vger.kernel.org>; Fri, 11 Apr 2014 01:15:56 -0700 (PDT)
In-Reply-To: <1397203178-16780-1-git-send-email-duanj.fnst@cn.fujitsu.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Duan Jiong <duanj.fnst@cn.fujitsu.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 11 April 2014 13:29, Duan Jiong <duanj.fnst@cn.fujitsu.com> wrote:
> This patch fixes coccinelle error regarding usage of IS_ERR and
> PTR_ERR instead of PTR_ERR_OR_ZERO.
>
> Signed-off-by: Duan Jiong <duanj.fnst@cn.fujitsu.com>
> ---
>  drivers/cpufreq/unicore2-cpufreq.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/drivers/cpufreq/unicore2-cpufreq.c b/drivers/cpufreq/unicore2-cpufreq.c
> index 8d045af..6f9dfa8 100644
> --- a/drivers/cpufreq/unicore2-cpufreq.c
> +++ b/drivers/cpufreq/unicore2-cpufreq.c
> @@ -60,9 +60,7 @@ static int __init ucv2_cpu_init(struct cpufreq_policy *policy)
>         policy->max = policy->cpuinfo.max_freq = 1000000;
>         policy->cpuinfo.transition_latency = CPUFREQ_ETERNAL;
>         policy->clk = clk_get(NULL, "MAIN_CLK");
> -       if (IS_ERR(policy->clk))
> -               return PTR_ERR(policy->clk);
> -       return 0;
> +       return PTR_ERR_OR_ZERO(policy->clk);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
