From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] cpufreq: s5pv210: remove superfluous CONFIG_PM ifdefs
Date: Wed, 09 Sep 2015 03:14:35 +0200
Message-ID: <5636818.tTEsh48iXg@vostro.rjw.lan>
References: <1441731732-8624-1-git-send-email-b.zolnierkie@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <1441731732-8624-1-git-send-email-b.zolnierkie@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, September 08, 2015 07:02:12 PM Bartlomiej Zolnierkiewicz wrote:
> CONFIG_PM ifdefs are superfluous and can be removed.

I guess Kukjin can apply this one?

> Cc: Kukjin Kim <kgene@kernel.org>
> Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  drivers/cpufreq/s5pv210-cpufreq.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/s5pv210-cpufreq.c b/drivers/cpufreq/s5pv210-cpufreq.c
> index 9e231f5..ef5282b 100644
> --- a/drivers/cpufreq/s5pv210-cpufreq.c
> +++ b/drivers/cpufreq/s5pv210-cpufreq.c
> @@ -576,10 +576,8 @@ static struct cpufreq_driver s5pv210_driver = {
>  	.get		= cpufreq_generic_get,
>  	.init		= s5pv210_cpu_init,
>  	.name		= "s5pv210",
> -#ifdef CONFIG_PM
>  	.suspend	= cpufreq_generic_suspend,
>  	.resume		= cpufreq_generic_suspend, /* We need to set SLEEP FREQ again */
> -#endif
>  };
>  
>  static struct notifier_block s5pv210_cpufreq_reboot_notifier = {
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
