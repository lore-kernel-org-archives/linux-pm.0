From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: ia64: Remove unused header files
Date: Mon, 17 Dec 2018 12:44:20 +0100
Message-ID: <2029526.yj18hjzxFf@aspire.rjw.lan>
References: <20181205154449.15725-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181205154449.15725-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, December 5, 2018 4:44:49 PM CET Yangtao Li wrote:
> seq_file.h does not need to be included, so remove it. Moreover deleted
> a line of meaningless return and some useless blank lines. In a function
> whose return type is void, returning on the last line is not required.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> changes in v2:
> -revert modify of MODULE_
> -delete some blank lines
> ---
>  drivers/cpufreq/ia64-acpi-cpufreq.c | 5 -----
>  1 file changed, 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/ia64-acpi-cpufreq.c b/drivers/cpufreq/ia64-acpi-cpufreq.c
> index dd5440d3372d..80c5bf590acb 100644
> --- a/drivers/cpufreq/ia64-acpi-cpufreq.c
> +++ b/drivers/cpufreq/ia64-acpi-cpufreq.c
> @@ -16,7 +16,6 @@
>  #include <linux/init.h>
>  #include <linux/cpufreq.h>
>  #include <linux/proc_fs.h>
> -#include <linux/seq_file.h>
>  #include <asm/io.h>
>  #include <linux/uaccess.h>
>  #include <asm/pal.h>
> @@ -28,7 +27,6 @@ MODULE_AUTHOR("Venkatesh Pallipadi");
>  MODULE_DESCRIPTION("ACPI Processor P-States Driver");
>  MODULE_LICENSE("GPL");
>  
> -
>  struct cpufreq_acpi_io {
>  	struct acpi_processor_performance	acpi_data;
>  	unsigned int				resume;
> @@ -348,10 +346,7 @@ acpi_cpufreq_exit (void)
>  	pr_debug("acpi_cpufreq_exit\n");
>  
>  	cpufreq_unregister_driver(&acpi_cpufreq_driver);
> -	return;
>  }
>  
> -
>  late_initcall(acpi_cpufreq_init);
>  module_exit(acpi_cpufreq_exit);
> -
> 

Applied, thanks!
