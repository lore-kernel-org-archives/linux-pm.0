From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: [PATCH v3] cpufreq: intel_pstate: skip the driver if ACPI has
 power mgmt option
Date: Thu, 31 Oct 2013 15:37:16 -0700
Message-ID: <5272DB9C.8080408@gmail.com>
References: <1383233045.2462.7.camel@adrian-F6S> <2937960.e8vxuRXoUT@vostro.rjw.lan> <5272D85C.3030306@gmail.com> <24720758.HRzPDnyMM4@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:42225 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751766Ab3JaWhT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 31 Oct 2013 18:37:19 -0400
Received: by mail-pd0-f178.google.com with SMTP id x10so3021863pdj.37
        for <linux-pm@vger.kernel.org>; Thu, 31 Oct 2013 15:37:18 -0700 (PDT)
In-Reply-To: <24720758.HRzPDnyMM4@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Adrian Huang <adrian.huang@hp.com>
Cc: viresh.kumar@linaro.org, linux-pm@vger.kernel.org, linda.knippers@hp.com, adrianhuang0701@gmail.com

On 10/31/2013 03:47 PM, Rafael J. Wysocki wrote:
> On Thursday, October 31, 2013 03:23:24 PM Dirk Brandewie wrote:
>> On 10/31/2013 03:29 PM, Rafael J. Wysocki wrote:
>>> On Thursday, October 31, 2013 11:24:05 PM Adrian Huang wrote:
>>>> Do not load the Intel pstate driver if the platform firmware
>>>> (ACPI BIOS) supports the power management alternatives.
>>>> The ACPI BIOS indicates that the OS control mode can be used
>>>> if the _PSS (Performance Supported States) is defined in ACPI
>>>> table. For the OS control mode, the Intel pstate driver will be
>>>> loaded.
>>>>
>>>> Signed-off-by: Adrian Huang <adrian.huang@hp.com>
>>>
>>> Do I assume correctly that this has been tested on the affected hardware?
>>>
>>> Dirk, any objections?
>>
>> As long as you are comfortable with the ACPI related logic for matching
>> the entry in the hw_vendor_info vendor_info[] I have no objections.
>
> Well, is there any other way to address that?
>

I wasn't saying I was uncomfortable with the code just I am not expert
in ACPI.  From what I can tell it is doing the correct thing.

>> One question though can this be disabled via the HP BIOS if the
>> customer does not want to use the firmware power management?
>
> Good question.  Adrian?
>
>
>>>> ---
>>>> Changes from v2:
>>>>    - Remove unnecessary assignments and parentheses (Thanks to Rafael)
>>>>
>>>> Changes from v1:
>>>>    - Minimize indentation levels (Thanks to Rafael)
>>>>    - Re-define some local variables (Thanks to by Rafael)
>>>>    - Return -ENODEV if platform FW has power management modes (Thanks to by Dirk)
>>>>
>>>>    drivers/cpufreq/intel_pstate.c | 70 ++++++++++++++++++++++++++++++++++++++++++
>>>>    1 file changed, 70 insertions(+)
>>>>
>>>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>>>> index eb3fdc7..9ec1d6c 100644
>>>> --- a/drivers/cpufreq/intel_pstate.c
>>>> +++ b/drivers/cpufreq/intel_pstate.c
>>>> @@ -26,6 +26,8 @@
>>>>    #include <linux/fs.h>
>>>>    #include <linux/debugfs.h>
>>>>    #include <trace/events/power.h>
>>>> +#include <linux/acpi.h>
>>>> +#include <acpi/processor.h>
>>>>
>>>>    #include <asm/div64.h>
>>>>    #include <asm/msr.h>
>>>> @@ -129,6 +131,18 @@ static struct perf_limits limits = {
>>>>    	.max_sysfs_pct = 100,
>>>>    };
>>>>
>>>> +struct hw_vendor_info {
>>>> +	u16  valid;
>>>> +	char oem_id[ACPI_OEM_ID_SIZE];
>>>> +	char oem_table_id[ACPI_OEM_TABLE_ID_SIZE];
>>>> +};
>>>> +
>>>> +/* Hardware vendor-specific info that has its own power management modes */
>>>> +static struct hw_vendor_info vendor_info[] = {
>>>> +	{1, "HP    ", "ProLiant"},
>>>> +	{0, "", ""},
>>>> +};
>>>> +
>>>>    static inline void pid_reset(struct _pid *pid, int setpoint, int busy,
>>>>    			int deadband, int integral) {
>>>>    	pid->setpoint = setpoint;
>>>> @@ -698,6 +712,55 @@ static int intel_pstate_msrs_not_valid(void)
>>>>
>>>>    	return 0;
>>>>    }
>>>> +
>>>> +static bool intel_pstate_no_acpi_pss(void)
>>>> +{
>>>> +	int i;
>>>> +
>>>> +	for_each_possible_cpu(i) {
>>>> +		acpi_status status;
>>>> +		union acpi_object *pss;
>>>> +		struct acpi_buffer buffer = { ACPI_ALLOCATE_BUFFER, NULL };
>>>> +		struct acpi_processor *pr = per_cpu(processors, i);
>>>> +
>>>> +		if (!pr)
>>>> +			continue;
>>>> +
>>>> +		status = acpi_evaluate_object(pr->handle, "_PSS",
>>>> +					      NULL, &buffer);
>>>> +		if (ACPI_FAILURE(status))
>>>> +			continue;
>>>> +
>>>> +		pss = buffer.pointer;
>>>> +		if (pss && pss->type == ACPI_TYPE_PACKAGE) {
>>>> +			kfree(pss);
>>>> +			return false;
>>>> +		}
>>>> +
>>>> +		kfree(pss);
>>>> +	}
>>>> +
>>>> +	return true;
>>>> +}
>>>> +
>>>> +static bool intel_pstate_platform_pwr_mgmt_exists(void)
>>>> +{
>>>> +	struct acpi_table_header hdr;
>>>> +	struct hw_vendor_info *v_info;
>>>> +
>>>> +	if (ACPI_FAILURE(acpi_get_table_header(ACPI_SIG_FADT, 0, &hdr)))
>>>> +		return false;
>>>> +
>>>> +	for (v_info = vendor_info; v_info->valid; v_info++) {
>>>> +		if (!strncmp(hdr.oem_id, v_info->oem_id, ACPI_OEM_ID_SIZE)
>>>> +		    && !strncmp(hdr.oem_table_id, v_info->oem_table_id, ACPI_OEM_TABLE_ID_SIZE)
>>>> +		    && intel_pstate_no_acpi_pss())
>>>> +			return true;
>>>> +	}
>>>> +
>>>> +	return false;
>>>> +}
>>>> +
>>>>    static int __init intel_pstate_init(void)
>>>>    {
>>>>    	int cpu, rc = 0;
>>>> @@ -706,6 +769,13 @@ static int __init intel_pstate_init(void)
>>>>    	if (no_load)
>>>>    		return -ENODEV;
>>>>
>>>> +	/*
>>>> +	 * The Intel pstate driver will be ignored if the platform
>>>> +	 * firmware has its own power management modes.
>>>> +	 */
>>>> +	if (!acpi_disabled && intel_pstate_platform_pwr_mgmt_exists())
>>>> +		return -ENODEV;
>>>> +
>>>>    	id = x86_match_cpu(intel_pstate_cpu_ids);
>>>>    	if (!id)
>>>>    		return -ENODEV;
>>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html

