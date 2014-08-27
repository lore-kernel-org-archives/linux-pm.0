From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: s5pv210: Remove spurious __init annotation
Date: Wed, 27 Aug 2014 16:34:28 +0530
Message-ID: <CAKohpokyUWnzUOdTtevGG8G8vrdxBCo3XsH9YdvmSt8BPZ1KwA@mail.gmail.com>
References: <1409137227-27080-1-git-send-email-broonie@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:36631 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756688AbaH0LE3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Aug 2014 07:04:29 -0400
Received: by mail-ob0-f172.google.com with SMTP id wn1so23978obc.31
        for <linux-pm@vger.kernel.org>; Wed, 27 Aug 2014 04:04:28 -0700 (PDT)
In-Reply-To: <1409137227-27080-1-git-send-email-broonie@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-samsung-soc <linux-samsung-soc@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, Mark Brown <broonie@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 27 August 2014 16:30, Mark Brown <broonie@kernel.org> wrote:
> From: Mark Brown <broonie@linaro.org>
>
> Since this is a platform driver and can be probed at any time we can't
> annotate funtions in the probe path as __init, the code can't safely be
> discarded at the end of kernel init.
>
> Signed-off-by: Mark Brown <broonie@linaro.org>
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index 9a68225a757e..3f9791f07b8e 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -501,7 +501,7 @@ static int check_mem_type(void __iomem *dmc_reg)
>         return val >> 8;
>  }
>
> -static int __init s5pv210_cpu_init(struct cpufreq_policy *policy)
> +static int s5pv210_cpu_init(struct cpufreq_policy *policy)
>  {
>         unsigned long mem_type;
>         int ret;

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
