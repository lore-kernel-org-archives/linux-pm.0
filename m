From: Andreas Herrmann <aherrmann@suse.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Register when ACPI PCCH is present
Date: Wed, 18 Jul 2018 12:43:00 +0200
Message-ID: <20180718104300.dwgbqbnllvhwzrea@suselix>
References: <20180717065048.74mmgk4t5utjaa6a@suselix>
 <20180717140336.ayovaz4ksdlak6bb@suselix>
 <8115130.Fhkpr82c7G@aspire.rjw.lan>
 <2386802.jRaeHeNqoJ@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <2386802.jRaeHeNqoJ@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Peter Zijlstra <peterz@infradead.org>, Frederic Weisbecker <frederic@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Jul 17, 2018 at 08:06:54PM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Currently, intel_pstate doesn't load if _PSS is not present on
> HP Proliant systems, because it expects the firmware to take over
> CPU performance scaling in that case.  However, if ACPI PCCH is
> present, the firmware expects the kernel to use it for CPU
> performance scaling and the pcc-cpufreq driver is loaded for that.
> 
> Unfortunately, the firmware interface used by that driver is not
> scalable for fundamental reasons, so pcc-cpufreq is way suboptimal
> on systems with more than just a few CPUs.  In fact, it is better to
> avoid using it at all.
> 
> For this reason, modify intel_pstate to look for ACPI PCCH if _PSS
> is not present and register if it is there.  Also prevent the
> pcc-cpufreq driver from trying to initialize if intel_pstate has
> been registered already.
> 
> Fixes: fbbcdc0744da (intel_pstate: skip the driver if ACPI has power mgmt option)
> Reported-by: Andreas Herrmann <aherrmann@suse.com>
> Reviewed-by: Andreas Herrmann <aherrmann@suse.com>
> Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> This is a replacement for https://patchwork.kernel.org/patch/10530091/
> 
> In addition to the intel_pstate changes in the above, it also
> prevents pcc-cpufreq from trying to initialize (which will fail
> ultimately, but may confuse the firmware in the meantime).
> 
> Andreas, please test this one and let me know if it still works for you.

Done that (with system in "Dynamic Power Savings Mode"). It still
works and system was stable.

FYI, as a sniff test I've run a kernbench test. I now repeat the test
with system switched to "OS control mode". Just in case -- if there
was interference with platform code while system was in "Dynamic Power
Savings Mode" (significantly affecting performance) I might spot it
this way.


Andreas


> Thanks,
> Rafael
> 
> ---
>  drivers/cpufreq/intel_pstate.c |   17 ++++++++++++++++-
>  drivers/cpufreq/pcc-cpufreq.c  |    4 ++++
>  2 files changed, 20 insertions(+), 1 deletion(-)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -2391,6 +2391,18 @@ static bool __init intel_pstate_no_acpi_
>  	return true;
>  }
>  
> +static bool __init intel_pstate_no_acpi_pcch(void)
> +{
> +	acpi_status status;
> +	acpi_handle handle;
> +
> +	status = acpi_get_handle(NULL, "\\_SB", &handle);
> +	if (ACPI_FAILURE(status))
> +		return true;
> +
> +	return !acpi_has_method(handle, "PCCH");
> +}
> +
>  static bool __init intel_pstate_has_acpi_ppc(void)
>  {
>  	int i;
> @@ -2450,7 +2462,10 @@ static bool __init intel_pstate_platform
>  
>  	switch (plat_info[idx].data) {
>  	case PSS:
> -		return intel_pstate_no_acpi_pss();
> +		if (!intel_pstate_no_acpi_pss())
> +			return false;
> +
> +		return intel_pstate_no_acpi_pcch();
>  	case PPC:
>  		return intel_pstate_has_acpi_ppc() && !force_load;
>  	}
> Index: linux-pm/drivers/cpufreq/pcc-cpufreq.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/pcc-cpufreq.c
> +++ linux-pm/drivers/cpufreq/pcc-cpufreq.c
> @@ -580,6 +580,10 @@ static int __init pcc_cpufreq_init(void)
>  {
>  	int ret;
>  
> +	/* Skip initialization if another cpufreq driver is there. */
> +	if (cpufreq_get_current_driver())
> +		return 0;
> +
>  	if (acpi_disabled)
>  		return 0;
>  
> 
> 
