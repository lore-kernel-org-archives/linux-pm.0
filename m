From: Linda Knippers <linda.knippers@hp.com>
Subject: Re: [PATCH v3] cpufreq: intel_pstate: skip the driver if ACPI has
 power mgmt option
Date: Wed, 06 Nov 2013 01:25:33 -0500
Message-ID: <5279E0DD.9060909@hp.com>
References: <1383233045.2462.7.camel@adrian-F6S> <24720758.HRzPDnyMM4@vostro.rjw.lan> <CAHKZfL2_ahVjaPCiMa14uHFNuwOKnPhAUr-Vn3QcqDHod_f8vg@mail.gmail.com> <2574312.RODqt35jkY@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from g4t0017.houston.hp.com ([15.201.24.20]:30367 "EHLO
	g4t0017.houston.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab3KFGZs (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 6 Nov 2013 01:25:48 -0500
In-Reply-To: <2574312.RODqt35jkY@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Huang Adrian <adrianhuang0701@gmail.com>, Dirk Brandewie <dirk.brandewie@gmail.com>, viresh.kumar@linaro.org, linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Friday, November 01, 2013 09:29:48 AM Huang Adrian wrote:
>> Yes. HP BIOS has several power management modes (firmware, OS-control and
>> so on). For the OS control mode in HP BIOS, the Intel p-state driver will
>> be loaded. When the customer chooses the firmware power management in HP
>> BIOS, the Intel p-state driver will be ignored.
>>
>> I put hw_vendor_info vendor_info in case other vendors (Dell, Lenovo...)
>> have their firmware power management. Vendors should make sure their
>> firmware power management works properly, and they can go for adding their
>> vendor info to the variable.
>>
>> And, I have verified the patch on HP ProLiant servers.  The patch worked
>> correctly.
> 
> OK.  I've added the above information to the patch changelog and fixed it up
> so that the driver builds for CONFIG_ACPI unset.  The result is below, please
> retest.

As Adrian has recently left HP, I retested the updated patch on an HP ProLiant
server and verified that it is behaving correctly.  When the BIOS is configured
for OS control for power management, the intel_pstate driver loads
as expected.  When the BIOS is configured to provide the power management, the
intel_pstate driver does not load and we get the pcc_cpufreq driver instead.

Since Adrian is no longer with HP, please add:

Signed-off-by: Linda Knippers <linda.knippers@hp.com>

Thanks,

-- ljk

> 
> Thanks,
> Rafael
> 
> 
> ---
> From: Adrian Huang <adrian.huang@hp.com>
> Subject: intel_pstate: skip the driver if ACPI has power mgmt option
> 
> Do not load the Intel pstate driver if the platform firmware
> (ACPI BIOS) supports the power management alternatives.
> The ACPI BIOS indicates that the OS control mode can be used
> if the _PSS (Performance Supported States) is defined in ACPI
> table. For the OS control mode, the Intel pstate driver will be
> loaded.
> 
> HP BIOS has several power management modes (firmware, OS-control and
> so on). For the OS control mode in HP BIOS, the Intel p-state driver
> will be loaded. When the customer chooses the firmware power
> management in HP BIOS, the Intel p-state driver will be ignored.
> 
> I put hw_vendor_info vendor_info in case other vendors (Dell, Lenovo...)
> have their firmware power management. Vendors should make sure their
> firmware power management works properly, and they can go for adding
> their vendor info to the variable.
> 
> I have verified the patch on HP ProLiant servers.  The patch worked
> correctly.
> 
> [rjw: Fixed up !CONFIG_ACPI build]
> Signed-off-by: Adrian Huang <adrian.huang@hp.com>
> ---
> 
>  drivers/cpufreq/intel_pstate.c |   74 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 74 insertions(+)
> 
> Index: linux-pm/drivers/cpufreq/intel_pstate.c
> ===================================================================
> --- linux-pm.orig/drivers/cpufreq/intel_pstate.c
> +++ linux-pm/drivers/cpufreq/intel_pstate.c
> @@ -25,6 +25,7 @@
>  #include <linux/types.h>
>  #include <linux/fs.h>
>  #include <linux/debugfs.h>
> +#include <linux/acpi.h>
>  #include <trace/events/power.h>
>  
>  #include <asm/div64.h>
> @@ -777,6 +778,72 @@ static void copy_cpu_funcs(struct pstate
>  	pstate_funcs.set       = funcs->set;
>  }
>  
> +#if IS_ENABLED(CONFIG_ACPI)
> +#include <acpi/processor.h>
> +
> +static bool intel_pstate_no_acpi_pss(void)
> +{
> +	int i;
> +
> +	for_each_possible_cpu(i) {
> +		acpi_status status;
> +		union acpi_object *pss;
> +		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
> +		struct acpi_processor *pr = per_cpu(processors, i);
> +
> +		if (!pr)
> +			continue;
> +
> +		status = acpi_evaluate_object(pr->handle, "_PSS", NULL, &buffer);
> +		if (ACPI_FAILURE(status))
> +			continue;
> +
> +		pss = buffer.pointer;
> +		if (pss && pss->type == ACPI_TYPE_PACKAGE) {
> +			kfree(pss);
> +			return false;
> +		}
> +
> +		kfree(pss);
> +	}
> +
> +	return true;
> +}
> +
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
> +static bool intel_pstate_platform_pwr_mgmt_exists(void)
> +{
> +	struct acpi_table_header hdr;
> +	struct hw_vendor_info *v_info;
> +
> +	if (acpi_disabled
> +	    || ACPI_FAILURE(acpi_get_table_header(ACPI_SIG_FADT, 0, &hdr)))
> +		return false;
> +
> +	for (v_info = vendor_info; v_info->valid; v_info++) {
> +		if (!strncmp(hdr.oem_id, v_info->oem_id, ACPI_OEM_ID_SIZE)
> +		    && !strncmp(hdr.oem_table_id, v_info->oem_table_id, ACPI_OEM_TABLE_ID_SIZE)
> +		    && intel_pstate_no_acpi_pss())
> +			return true;
> +	}
> +
> +	return false;
> +}
> +#else /* CONFIG_ACPI not enabled */
> +static inline bool intel_pstate_platform_pwr_mgmt_exists(void) { return false; }
> +#endif /* CONFIG_ACPI */
> +
>  static int __init intel_pstate_init(void)
>  {
>  	int cpu, rc = 0;
> @@ -790,6 +857,13 @@ static int __init intel_pstate_init(void
>  	if (!id)
>  		return -ENODEV;
>  
> +	/*
> +	 * The Intel pstate driver will be ignored if the platform
> +	 * firmware has its own power management modes.
> +	 */
> +	if (intel_pstate_platform_pwr_mgmt_exists())
> +		return -ENODEV;
> +
>  	cpu_info = (struct cpu_defaults *)id->driver_data;
>  
>  	copy_pid_params(&cpu_info->pid_policy);
> 

