From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v3] cpufreq: intel_pstate: wrong call to acpi_processor_unregister_performance
Date: Mon, 16 Nov 2015 13:09:19 +0100
Message-ID: <1976139.BTAbAQ7onH@vostro.rjw.lan>
References: <1447463821-14595-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1447463821-14595-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54758 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751223AbbKPLjw (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 16 Nov 2015 06:39:52 -0500
In-Reply-To: <1447463821-14595-2-git-send-email-srinivas.pandruvada@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Cc: linux-pm@vger.kernel.org

On Friday, November 13, 2015 05:17:01 PM Srinivas Pandruvada wrote:
> When the no_acpi_perf is set to 1, that means that we haven't called
> acpi_processor_register_performance(), so we shouldn't also call
> acpi_processor_unregister_performance in intel_pstate_exit_perf_limits().
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

OK, but this is my patch. :-)

I'll apply it with the right From: line.

> ---
>  drivers/cpufreq/intel_pstate.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 6ec39ef..bad1ee3 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -326,13 +326,9 @@ static int intel_pstate_init_perf_limits(struct cpufreq_policy *policy)
>  
>  static int intel_pstate_exit_perf_limits(struct cpufreq_policy *policy)
>  {
> -	struct cpudata *cpu;
> -
>  	if (!no_acpi_perf)
> -		return 0;
> +		acpi_processor_unregister_performance(policy->cpu);
>  
> -	cpu = all_cpu_data[policy->cpu];
> -	acpi_processor_unregister_performance(policy->cpu);
>  	return 0;
>  }
>  
> 

Thanks,
Rafael

