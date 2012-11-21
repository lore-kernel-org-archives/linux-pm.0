From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 396/493] cpufreq: remove use of __devexit
Date: Wed, 21 Nov 2012 01:50:30 +0100
Message-ID: <1594563.dNM4NPViat@vostro.rjw.lan>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu> <1353349642-3677-396-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1353349642-3677-396-git-send-email-wfp5p@virginia.edu>
Sender: cpufreq-owner@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, November 19, 2012 01:25:45 PM Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit is no
> longer needed.

Applied to the linux-next branch of the linux-pm.git tree as v3.8 material.

Thanks,
Rafael


> Signed-off-by: Bill Pemberton <wfp5p@virginia.edu>
> Cc: "Rafael J. Wysocki" <rjw@sisk.pl> 
> Cc: cpufreq@vger.kernel.org 
> Cc: linux-pm@vger.kernel.org 
> ---
>  drivers/cpufreq/longhaul.c    | 2 +-
>  drivers/cpufreq/powernow-k8.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cpufreq/longhaul.c b/drivers/cpufreq/longhaul.c
> index 8d7ebb2..f1fa500 100644
> --- a/drivers/cpufreq/longhaul.c
> +++ b/drivers/cpufreq/longhaul.c
> @@ -930,7 +930,7 @@ static int __cpuinit longhaul_cpu_init(struct cpufreq_policy *policy)
>  	return 0;
>  }
>  
> -static int __devexit longhaul_cpu_exit(struct cpufreq_policy *policy)
> +static int longhaul_cpu_exit(struct cpufreq_policy *policy)
>  {
>  	cpufreq_frequency_table_put_attr(policy->cpu);
>  	return 0;
> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
> index 1fd0c8a..056faf6 100644
> --- a/drivers/cpufreq/powernow-k8.c
> +++ b/drivers/cpufreq/powernow-k8.c
> @@ -1186,7 +1186,7 @@ err_out:
>  	return -ENODEV;
>  }
>  
> -static int __devexit powernowk8_cpu_exit(struct cpufreq_policy *pol)
> +static int powernowk8_cpu_exit(struct cpufreq_policy *pol)
>  {
>  	struct powernow_k8_data *data = per_cpu(powernow_data, pol->cpu);
>  
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
