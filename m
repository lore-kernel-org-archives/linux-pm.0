From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: dbx500: use builtin_platform_driver
Date: Thu, 24 Nov 2016 09:19:39 +0530
Message-ID: <20161124034939.GA9376@vireshk-i7>
References: <3e21f3c9748b18f97d3b7e2e534b31a64601177c.1479912098.git.geliangtang@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <3e21f3c9748b18f97d3b7e2e534b31a64601177c.1479912098.git.geliangtang@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geliang Tang <geliangtang@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 23-11-16, 22:42, Geliang Tang wrote:
> Use builtin_platform_driver() helper to simplify the code.
> 
> Signed-off-by: Geliang Tang <geliangtang@gmail.com>
> ---
>  drivers/cpufreq/dbx500-cpufreq.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/dbx500-cpufreq.c b/drivers/cpufreq/dbx500-cpufreq.c
> index 5c3ec1d..d257a75 100644
> --- a/drivers/cpufreq/dbx500-cpufreq.c
> +++ b/drivers/cpufreq/dbx500-cpufreq.c
> @@ -73,11 +73,7 @@ static struct platform_driver dbx500_cpufreq_plat_driver = {
>  	.probe = dbx500_cpufreq_probe,
>  };
>  
> -static int __init dbx500_cpufreq_register(void)
> -{
> -	return platform_driver_register(&dbx500_cpufreq_plat_driver);
> -}
> -device_initcall(dbx500_cpufreq_register);
> +builtin_platform_driver(dbx500_cpufreq_plat_driver);
>  
>  MODULE_LICENSE("GPL v2");
>  MODULE_DESCRIPTION("cpufreq driver for DBX500");

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
-- 
viresh
