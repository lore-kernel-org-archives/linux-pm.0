From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 052/493] cpufreq: remove use of __devexit_p
Date: Wed, 21 Nov 2012 01:50:53 +0100
Message-ID: <41029175.4HqNPcvdqv@vostro.rjw.lan>
References: <1353349642-3677-1-git-send-email-wfp5p@virginia.edu> <1353349642-3677-52-git-send-email-wfp5p@virginia.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1353349642-3677-52-git-send-email-wfp5p@virginia.edu>
Sender: cpufreq-owner@vger.kernel.org
To: Bill Pemberton <wfp5p@virginia.edu>
Cc: gregkh@linuxfoundation.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Monday, November 19, 2012 01:20:01 PM Bill Pemberton wrote:
> CONFIG_HOTPLUG is going away as an option so __devexit_p is no longer
> needed.

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
> index 53ddbc7..8d7ebb2 100644
> --- a/drivers/cpufreq/longhaul.c
> +++ b/drivers/cpufreq/longhaul.c
> @@ -946,7 +946,7 @@ static struct cpufreq_driver longhaul_driver = {
>  	.target	= longhaul_target,
>  	.get	= longhaul_get,
>  	.init	= longhaul_cpu_init,
> -	.exit	= __devexit_p(longhaul_cpu_exit),
> +	.exit	= longhaul_cpu_exit,
>  	.name	= "longhaul",
>  	.owner	= THIS_MODULE,
>  	.attr	= longhaul_attr,
> diff --git a/drivers/cpufreq/powernow-k8.c b/drivers/cpufreq/powernow-k8.c
> index e3ebb4f..1fd0c8a 100644
> --- a/drivers/cpufreq/powernow-k8.c
> +++ b/drivers/cpufreq/powernow-k8.c
> @@ -1242,7 +1242,7 @@ static struct cpufreq_driver cpufreq_amd64_driver = {
>  	.target		= powernowk8_target,
>  	.bios_limit	= acpi_processor_get_bios_limit,
>  	.init		= powernowk8_cpu_init,
> -	.exit		= __devexit_p(powernowk8_cpu_exit),
> +	.exit		= powernowk8_cpu_exit,
>  	.get		= powernowk8_get,
>  	.name		= "powernow-k8",
>  	.owner		= THIS_MODULE,
> 
-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
