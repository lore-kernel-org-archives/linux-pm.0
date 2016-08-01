From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Do not default-yes CPU_FREQ_STAT
Date: Mon, 1 Aug 2016 10:02:25 -0700
Message-ID: <20160801170225.GM4605@ubuntu>
References: <20160801093455.12676-1-bp@alien8.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160801093455.12676-1-bp@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Borislav Petkov <bp@alien8.de>
Cc: linux-pm@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>
List-Id: linux-pm@vger.kernel.org

On 01-08-16, 11:34, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> CPU frequency transition statistics are not absolutely required for
> proper cpufreq operation on the system AFAICT so remove the default-yes
> setting in Kconfig.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/cpufreq/Kconfig | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
> index c822d72629d5..74919aa81dcb 100644
> --- a/drivers/cpufreq/Kconfig
> +++ b/drivers/cpufreq/Kconfig
> @@ -32,7 +32,6 @@ config CPU_FREQ_BOOST_SW
>  
>  config CPU_FREQ_STAT
>  	bool "CPU frequency transition statistics"
> -	default y
>  	help
>  	  Export CPU frequency statistics information through sysfs.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
