From: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH 2/2] cpufreq: Remove cpu hotplug callbacks only if they
 were initialized
Date: Thu, 15 Dec 2016 17:47:59 +0100 (CET)
Message-ID: <alpine.DEB.2.20.1612151747480.3470@nanos>
References: <1481814058-4799-1-git-send-email-boris.ostrovsky@oracle.com> <1481814058-4799-3-git-send-email-boris.ostrovsky@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1481814058-4799-3-git-send-email-boris.ostrovsky@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: bigeasy@linutronix.de, rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, xen-devel@lists.xenproject.org
List-Id: linux-pm@vger.kernel.org

On Thu, 15 Dec 2016, Boris Ostrovsky wrote:

> Since cpu hotplug callbacks are requested for CPUHP_AP_ONLINE_DYN state,
> successful callback initialization will result in cpuhp_setup_state()
> returning a positive value. Therefore acpi_cpufreq_online being zero
> indicates that callbacks have not been installed.
> 
> This means that acpi_cpufreq_boost_exit() should only remove them if
> acpi_cpufreq_online is positive. Trying to call
> cpuhp_remove_state_nocalls(0) will cause a BUG().
> 
> Signed-off-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>

Reviewed-by: Thomas Gleixner <tglx@linutronix.de>

> ---
>  drivers/cpufreq/acpi-cpufreq.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/cpufreq/acpi-cpufreq.c b/drivers/cpufreq/acpi-cpufreq.c
> index 3a98702..3a2ca0f 100644
> --- a/drivers/cpufreq/acpi-cpufreq.c
> +++ b/drivers/cpufreq/acpi-cpufreq.c
> @@ -930,7 +930,7 @@ static void __init acpi_cpufreq_boost_init(void)
>  
>  static void acpi_cpufreq_boost_exit(void)
>  {
> -	if (acpi_cpufreq_online >= 0)
> +	if (acpi_cpufreq_online > 0)
>  		cpuhp_remove_state_nocalls(acpi_cpufreq_online);
>  }
>  
> -- 
> 1.7.1
> 
> 
