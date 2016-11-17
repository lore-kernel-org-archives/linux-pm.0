From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Request P-states control from
 SMM if needed
Date: Wed, 16 Nov 2016 16:04:52 -0800
Message-ID: <1479341092.6544.121.camel@linux.intel.com>
References: <1679905.fG5YOIvtAJ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1679905.fG5YOIvtAJ@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2016-11-16 at 03:36 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Currently, intel_pstate is unable to control P-states on my
> IvyBridge-based Acer Aspire S5, because they are controlled by SMM
> on that machine by default and it is necessary to request OS control
> of P-states from it via the SMI Command register exposed in the ACPI
> FADT.  intel_pstate doesn't do that now, but acpi-cpufreq and other
> cpufreq drivers for x86 platforms do.
> 
> Address this problem by making intel_pstate use the ACPI-defined
> mechanism as well.  However, intel_pstate is not modular and it
> doesn't need the module refcount tricks played by
> acpi_processor_notify_smm(), so export the core of this function
> to it as acpi_processor_pstate_control() and make it call that.
> [The changes in processor_perflib.c related to this should not
> make any functional difference for the acpi_processor_notify_smm()
> users].
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Suggested-by: Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  drivers/acpi/processor_perflib.c |   45 ++++++++++++++++++++++++--
> -------------
>  drivers/cpufreq/intel_pstate.c   |    8 ++++++
>  include/acpi/processor.h         |    1 
>  3 files changed, 37 insertions(+), 17 deletions(-)
> 
> Index: linux-pm/drivers/acpi/processor_perflib.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/processor_perflib.c
> +++ linux-pm/drivers/acpi/processor_perflib.c
> @@ -465,11 +465,33 @@ int acpi_processor_get_performance_info(
>  	return result;
>  }
>  EXPORT_SYMBOL_GPL(acpi_processor_get_performance_info);
> -int acpi_processor_notify_smm(struct module *calling_module)
> +
> +int acpi_processor_pstate_control(void)
>  {
>  	acpi_status status;
> -	static int is_done = 0;
>  
> +	if (!acpi_gbl_FADT.smi_command ||
> !acpi_gbl_FADT.pstate_control)
> +		return 0;
> +
> +	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> +			  "Writing pstate_control [0x%x] to
> smi_command [0x%x]\n",
> +			  acpi_gbl_FADT.pstate_control,
> acpi_gbl_FADT.smi_command));
> +
> +	status = acpi_os_write_port(acpi_gbl_FADT.smi_command,
> +				    (u32)acpi_gbl_FADT.pstate_contro
> l, 8);
> +	if (ACPI_SUCCESS(status))
> +		return 1;
> +
> +	ACPI_EXCEPTION((AE_INFO, status,
> +			"Failed to write pstate_control [0x%x] to
> smi_command [0x%x]",
> +			acpi_gbl_FADT.pstate_control,
> acpi_gbl_FADT.smi_command));
> +	return -EIO;
> +}
> +
> +int acpi_processor_notify_smm(struct module *calling_module)
> +{
> +	static int is_done = 0;
> +	int result;
>  
>  	if (!(acpi_processor_ppc_status & PPC_REGISTERED))
>  		return -EBUSY;
> @@ -492,26 +514,15 @@ int acpi_processor_notify_smm(struct mod
>  
>  	is_done = -EIO;
>  
> -	/* Can't write pstate_control to smi_command if either value
> is zero */
> -	if ((!acpi_gbl_FADT.smi_command) ||
> (!acpi_gbl_FADT.pstate_control)) {
> +	result = acpi_processor_pstate_control();
> +	if (!result) {
>  		ACPI_DEBUG_PRINT((ACPI_DB_INFO, "No SMI port or
> pstate_control\n"));
>  		module_put(calling_module);
>  		return 0;
>  	}
> -
> -	ACPI_DEBUG_PRINT((ACPI_DB_INFO,
> -			  "Writing pstate_control [0x%x] to
> smi_command [0x%x]\n",
> -			  acpi_gbl_FADT.pstate_control,
> acpi_gbl_FADT.smi_command));
> -
> -	status = acpi_os_write_port(acpi_gbl_FADT.smi_command,
> -				    (u32)
> acpi_gbl_FADT.pstate_control, 8);
> -	if (ACPI_FAILURE(status)) {
> -		ACPI_EXCEPTION((AE_INFO, status,
> -				"Failed to write pstate_control
> [0x%x] to "
> -				"smi_command [0x%x]",
> acpi_gbl_FADT.pstate_control,
> -				acpi_gbl_FADT.smi_command));
> +	if (result < 0) {
>  		module_put(calling_module);
> -		return status;
> +		return result;
>  	}
>  
>  	/* Success. If there's no _PPC, we need to fear nothing, so
> Index: linux-pm/include/acpi/processor.h
> ===================================================================
> --- linux-pm.orig/include/acpi/processor.h
> +++ linux-pm/include/acpi/processor.h
> @@ -249,6 +249,7 @@ extern int acpi_processor_register_perfo
>  					       *performance,
> unsigned int cpu);
>  extern void acpi_processor_unregister_performance(unsigned int cpu);
>  
> +int acpi_processor_pstate_control(void);
>  /* note: this locks both the calling module and the processor module
>           if a _PPC object exists, rmmod is disallowed then */
>  int acpi_processor_notify_smm(struct module *calling_module);
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -2034,9 +2034,15 @@ static bool __init intel_pstate_platform
>  
>  	return false;
>  }
> +
> +static void intel_pstate_request_control(void)
> +{
> +	acpi_processor_pstate_control();
> +}
>  #else /* CONFIG_ACPI not enabled */
>  static inline bool intel_pstate_platform_pwr_mgmt_exists(void) {
> return false; }
>  static inline bool intel_pstate_has_acpi_ppc(void) { return false; }
> +static inline void intel_pstate_request_control(void) {}
>  #endif /* CONFIG_ACPI */
>  
>  static const struct x86_cpu_id hwp_support_ids[] __initconst = {
> @@ -2088,6 +2094,8 @@ hwp_cpu_matched:
>  	if (!hwp_active && hwp_only)
>  		goto out;
>  
> +	intel_pstate_request_control();
> +
>  	rc = cpufreq_register_driver(intel_pstate_driver);
>  	if (rc)
>  		goto out;
> 
