From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] cpufreq: intel_pstate: skip the driver if ACPI has power mgmt option
Date: Sat, 26 Oct 2013 00:15:08 +0200
Message-ID: <2169245.5j9Xk20sM5@vostro.rjw.lan>
References: <1382333227-28231-1-git-send-email-adrian.huang@hp.com> <5265503B.7000804@gmail.com> <1382620988.6298.2.camel@adrian-F6S>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:65182 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751963Ab3JYWDG (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 25 Oct 2013 18:03:06 -0400
In-Reply-To: <1382620988.6298.2.camel@adrian-F6S>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: adrian <adrian.huang@hp.com>
Cc: Dirk Brandewie <dirk.brandewie@gmail.com>, viresh.kumar@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linda.knippers@hp.com

On Thursday, October 24, 2013 09:23:08 PM adrian wrote:
> Thanks, Dirk. The patch has been modified accordingly. 
> 
> Signed-off-by: Adrian Huang <adrian.huang@hp.com>
> ---
>  drivers/cpufreq/intel_pstate.c | 80 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 80 insertions(+)
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index badf620..8c00394 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -26,6 +26,8 @@
>  #include <linux/fs.h>
>  #include <linux/debugfs.h>
>  #include <trace/events/power.h>
> +#include <linux/acpi.h>
> +#include <acpi/processor.h>
>  
>  #include <asm/div64.h>
>  #include <asm/msr.h>
> @@ -129,6 +131,18 @@ static struct perf_limits limits = {
>  	.max_sysfs_pct = 100,
>  };
>  
> +struct hw_vendor_info {
> +	u16  valid;
> +	char oem_id[ACPI_OEM_ID_SIZE];
> +	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];
> +};
> +
> +/* Hardware vendor-specific info that has its own power management modes */
> +static struct hw_vendor_info vendor_info[] = {
> +	{1, "HP    ", "ProLiant"},
> +	{0, "", ""},
> +};
> +
>  static inline void pid_reset(struct _pid *pid, int setpoint, int busy,
>  			int deadband, int integral) {
>  	pid->setpoint = setpoint;
> @@ -700,6 +714,63 @@ static int intel_pstate_msrs_not_valid(void)
>  
>  	return 0;
>  }
> +
> +static bool intel_pstate_no_acpi_pss(void)
> +{
> +	struct acpi_processor *pr;
> +	union acpi_object *pss = NULL;
> +	int i;
> +
> +	for_each_possible_cpu(i) {

Can you possibly reduce the max indentation level of this function,
perhaps using the continue instruction?

Also please move the definition of pss to the block in which that
variable is used.

> +
> +		pr = per_cpu(processors, i);
> +
> +		if (pr) {
> +			struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER,
> +							NULL };
> +
> +			if (ACPI_SUCCESS(acpi_evaluate_object(pr->handle,
> +						"_PSS", NULL, &buffer))) {
> +
> +				pss = buffer.pointer;
> +
> +				if (pss && pss->type == ACPI_TYPE_PACKAGE) {
> +					kfree(buffer.pointer);
> +					return false;
> +				}
> +
> +				kfree(buffer.pointer);
> +			}
> +		}
> +	}
> +
> +	return true;
> +}
> +
> +static bool intel_pstate_platform_pwr_mgmt_exists(void)
> +{
> +	struct acpi_table_header hdr;
> +	struct hw_vendor_info *v_info;
> +
> +	if (acpi_get_table_header(ACPI_SIG_FADT, 0, &hdr) == AE_OK) {

I'd do

	if (ACPI_FAILURE(acpi_get_table_header(ACPI_SIG_FADT, 0, &hdr))
		return false;

and then the indentation level can be reduced.

> +		for (v_info = vendor_info; v_info->valid; v_info++) {
> +			/*
> +			 * Check if the hardware/platform is in the
> +			 * predefined vendor data.
> +			 */
> +			if (!strncmp(hdr.oem_id, v_info->oem_id,
> +				     ACPI_OEM_ID_SIZE) &&
> +			    !strncmp(hdr.oem_table_id, v_info->oem_table_id,
> +				     ACPI_OEM_TABLE_ID_SIZE)) {
> +				if (intel_pstate_no_acpi_pss())
> +					return true;

I think the above should be

	if (!strncmp(hdr.oem_id, v_info->oem_id, ACPI_OEM_ID_SIZE)
	    && !strncmp(hdr.oem_table_id, v_info->oem_table_id, ACPI_OEM_TABLE_ID_SIZE)
	    && intel_pstate_no_acpi_pss())
		return true;

(you don't need to break the lines longer than 80 characters if that makes
the code less readable).

> +			}
> +		}
> +	}
> +
> +	return false;
> +}
> +
>  static int __init intel_pstate_init(void)
>  {
>  	int cpu, rc = 0;
> @@ -708,6 +779,15 @@ static int __init intel_pstate_init(void)
>  	if (no_load)
>  		return -ENODEV;
>  
> +	if (!acpi_disabled) {
> +		/*
> +		 * Check if the platform has its own power management modes.
> +		 * If so, the pstate cpufreq driver will be ignored.
> +		 */
> +		if (intel_pstate_platform_pwr_mgmt_exists())
> +			return -ENODEV;
> +	}
> +
>  	id = x86_match_cpu(intel_pstate_cpu_ids);
>  	if (!id)
>  		return -ENODEV;

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
