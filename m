From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 01/14] cpufreq: stats: don't break strings into multiple lines
Date: Sat, 03 Jan 2015 22:57:20 +0100
Message-ID: <2484780.nK5uWU02Mz@vostro.rjw.lan>
References: <cover.1420177186.git.viresh.kumar@linaro.org> <70f04ca65a4283afcb21eefa3da88a48de2c2e2e.1420177186.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:62215 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751311AbbACVfJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 3 Jan 2015 16:35:09 -0500
In-Reply-To: <70f04ca65a4283afcb21eefa3da88a48de2c2e2e.1420177186.git.viresh.kumar@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, prarit@redhat.com, skannan@codeaurora.org

On Friday, January 02, 2015 11:16:38 AM Viresh Kumar wrote:
> The MODULE_DESCRIPTION() string is broken into multiple lines just to make
> checkpatch happy. Its less readable now and prone to errors. Fix it.
> 
> Reviewed-by: Prarit Bhargava <prarit@redhat.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/cpufreq_stats.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
> index 0cd9b4dcef99..81be4d637ab4 100644
> --- a/drivers/cpufreq/cpufreq_stats.c
> +++ b/drivers/cpufreq/cpufreq_stats.c
> @@ -374,8 +374,7 @@ static void __exit cpufreq_stats_exit(void)
>  }
>  
>  MODULE_AUTHOR("Zou Nan hai <nanhai.zou@intel.com>");
> -MODULE_DESCRIPTION("'cpufreq_stats' - A driver to export cpufreq stats "
> -				"through sysfs filesystem");
> +MODULE_DESCRIPTION("'cpufreq_stats' - exports cpufreq stats through sysfs filesystem");

What about 

+MODULE_DESCRIPTION("Export cpufreq stats via sysfs");

This doesn't seem to be substantially less information than the original to me.

>  MODULE_LICENSE("GPL");
>  
>  module_init(cpufreq_stats_init);
> 

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
