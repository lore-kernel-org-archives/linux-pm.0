From: Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH] cpufreq: tegra: update comment for clarity
Date: Fri, 6 Jun 2014 16:49:37 -0700
Message-ID: <CAD=FV=Wq-bmN+7Kz7OjLHfQ+b6+ooSwOSbGmkuNqW=TU317TFg@mail.gmail.com>
References: <594cf0e6982c471eb314fe4a00647bfaf59a3456.1402029512.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ve0-f174.google.com ([209.85.128.174]:65246 "EHLO
	mail-ve0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbaFFXti (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 6 Jun 2014 19:49:38 -0400
Received: by mail-ve0-f174.google.com with SMTP id us18so2002042veb.5
        for <linux-pm@vger.kernel.org>; Fri, 06 Jun 2014 16:49:37 -0700 (PDT)
In-Reply-To: <594cf0e6982c471eb314fe4a00647bfaf59a3456.1402029512.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arvind Chauhan <arvind.chauhan@arm.com>, Stephen Warren <swarren@nvidia.com>

Viresh,

On Thu, Jun 5, 2014 at 9:38 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Tegra's driver got updated a bit (00917dd cpufreq: Tegra: implement intermediate
> frequency callbacks) and implements new 'intermediate freq' infrastructure of
> core. Above commit updated comments about when to call
> clk_prepare_enable(pll_x_clk) and Doug wasn't satisfied with those comments and
> said this:
>
>> The "Though when target-freq is intermediate freq, we don't need to
>> take this reference." makes me think that this function is actually
>> called when target-freq is intermediate freq.  I don't think it is,
>> right?
>
> For better clarity just make that comment more explicit about when we call
> tegra_target_intermediate(). Wasn't sure if we actually need a commit for this,
> but anyway lets other decide if its worth enough :)
>
> Reported-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/tegra-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/tegra-cpufreq.c b/drivers/cpufreq/tegra-cpufreq.c
> index a5fbc0a..48bc89b 100644
> --- a/drivers/cpufreq/tegra-cpufreq.c
> +++ b/drivers/cpufreq/tegra-cpufreq.c
> @@ -73,7 +73,7 @@ static int tegra_target_intermediate(struct cpufreq_policy *policy,
>          * off when we move the cpu off of it as enabling it again while we
>          * switch to it from tegra_target() would take additional time. Though
>          * when target-freq is intermediate freq, we don't need to take this
> -        * reference.
> +        * reference and so this routine isn't called at all.

I'm OK either way, so up to others.

Reviewed-by: Doug Anderson <dianders@chromium.org>
