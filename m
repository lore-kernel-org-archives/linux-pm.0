From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH v5] Force cppc_cpufreq to report values in KHz to fix user
 space reporting
Date: Thu, 11 Aug 2016 12:15:56 -0600
Message-ID: <872a4dd4-a752-507b-e720-ec2e6003bd8c@redhat.com>
References: <1469049004-19069-1-git-send-email-ahs3@redhat.com>
 <20160801203156.GV4605@ubuntu>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160801203156.GV4605@ubuntu>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, ashwinch@google.com
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Prashanth Prakash <pprakash@codeaurora.org>
List-Id: linux-pm@vger.kernel.org

On 08/01/2016 02:31 PM, Viresh Kumar wrote:
> [+ Ashwin's new email id..]
> 
> On 20-07-16, 15:10, Al Stone wrote:
>> When CPPC is being used by ACPI on arm64, user space tools such as
>> cpupower report CPU frequency values from sysfs that are incorrect.
>>
>> What the driver was doing was reporting the values given by ACPI tables
>> in whatever scale was used to provide them.  However, the ACPI spec
>> defines the CPPC values as unitless abstract numbers.  Internal kernel
>> structures such as struct perf_cap, in contrast, expect these values
>> to be in KHz.  When these struct values get reported via sysfs, the
>> user space tools also assume they are in KHz, causing them to report
>> incorrect values (for example, reporting a CPU frequency of 1MHz when
>> it should be 1.8GHz).
>>
>> The downside is that this approach has some assumptions:
>>
>>    (1) It relies on SMBIOS3 being used, *and* that the Max Frequency
>>    value for a processor is set to a non-zero value.
>>
>>    (2) It assumes that all processors run at the same speed, or that
>>    the CPPC values have all been scaled to reflect relative speed.
>>    This patch retrieves the largest CPU Max Frequency from a type 4 DMI
>>    record that it can find.  This may not be an issue, however, as a
>>    sampling of DMI data on x86 and arm64 indicates there is often only
>>    one such record regardless.  Since CPPC is relatively new, it is
>>    unclear if the ACPI ASL will always be written to reflect any sort
>>    of relative performance of processors of differing speeds.
>>
>>    (3) It assumes that performance and frequency both scale linearly.
>>
>> For arm64 servers, this may be sufficient, but it does rely on
>> firmware values being set correctly.  Hence, other approaches will
>> be considered in the future.
>>
>> This has been tested on three arm64 servers, with and without DMI, with
>> and without CPPC support.
>>
>> Changes for v5:
>>     -- Move code to cpufreq/cppc_cpufreq.c from acpi/cppc_acpi.c to keep
>>        frequency-related code together, and keep the CPPC abstract scale
>>        in ACPI (Prashanth Prakash)
>>     -- Fix the scaling to remove the incorrect assumption that frequency
>>        was always a range from zero to max; as a practical matter, it is
>>        not (Prasanth Prakash); this also allowed us to remove an over-
>>        engineered function to do this math.
>>
>> Changes for v4:
>>     -- Replaced magic constants with #defines (Rafael Wysocki)
>>     -- Renamed cppc_unitless_to_khz() to cppc_to_khz() (Rafael Wysocki)
>>     -- Replaced hidden initialization with a clearer form (Rafael Wysocki)
>>     -- Instead of picking up the first Max Speed value from DMI, we will
>>        now get the largest Max Speed; still an approximation, but slightly
>>        less subject to error (Rafael Wysocki)
>>     -- Kconfig for cppc_cpufreq now depends on DMI, instead of selecting
>>        it, in order to make sure DMI is set up properly (Rafael Wysocki)
>>
>> Changes for v3:
>>     -- Added clarifying commentary re short-term vs long-term fix (Alexey
>>        Klimov)
>>     -- Added range checking code to ensure proper arithmetic occurs,
>>        especially no division by zero (Alexey Klimov)
>>
>> Changes for v2:
>>     -- Corrected thinko: needed to have DEPENDS on DMI in Kconfig.arm,
>>        not SELECT DMI (found by build daemon)
>>
>> Signed-off-by: Al Stone <ahs3@redhat.com>
>> Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
>> ---
>>  drivers/cpufreq/cppc_cpufreq.c | 53 ++++++++++++++++++++++++++++++++++++++----
>>  1 file changed, 49 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>> index 8882b8e..6debc18 100644
>> --- a/drivers/cpufreq/cppc_cpufreq.c
>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> @@ -19,10 +19,19 @@
>>  #include <linux/delay.h>
>>  #include <linux/cpu.h>
>>  #include <linux/cpufreq.h>
>> +#include <linux/dmi.h>
>>  #include <linux/vmalloc.h>
>>  
>> +#include <asm/unaligned.h>
>> +
>>  #include <acpi/cppc_acpi.h>
>>  
>> +/* Minimum struct length needed for the DMI processor entry we want */
>> +#define DMI_ENTRY_PROCESSOR_MIN_LENGTH	48
>> +
>> +/* Offest in the DMI processor structure for the max frequency */
>> +#define DMI_PROCESSOR_MAX_SPEED  0x14
>> +
>>  /*
>>   * These structs contain information parsed from per CPU
>>   * ACPI _CPC structures.
>> @@ -32,6 +41,39 @@
>>   */
>>  static struct cpudata **all_cpu_data;
>>  
>> +/* Capture the max KHz from DMI */
>> +static u64 cppc_dmi_max_khz;
>> +
>> +/* Callback function used to retrieve the max frequency from DMI */
>> +static void cppc_find_dmi_mhz(const struct dmi_header *dm, void *private)
>> +{
>> +	const u8 *dmi_data = (const u8 *)dm;
>> +	u16 *mhz = (u16 *)private;
>> +
>> +	if (dm->type == DMI_ENTRY_PROCESSOR &&
>> +	    dm->length >= DMI_ENTRY_PROCESSOR_MIN_LENGTH) {
>> +		u16 val = (u16)get_unaligned((const u16 *)
>> +				(dmi_data + DMI_PROCESSOR_MAX_SPEED));
>> +		*mhz = val > *mhz ? val : *mhz;
>> +	}
>> +}
>> +
>> +/* Look up the max frequency in DMI */
>> +static u64 cppc_get_dmi_max_khz(void)
>> +{
>> +	u16 mhz = 0;
>> +
>> +	dmi_walk(cppc_find_dmi_mhz, &mhz);
>> +
>> +	/*
>> +	 * Real stupid fallback value, just in case there is no
>> +	 * actual value set.
>> +	 */
>> +	mhz = mhz ? mhz : 1;
>> +
>> +	return (1000 * mhz);
>> +}
>> +
>>  static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>>  		unsigned int target_freq,
>>  		unsigned int relation)
>> @@ -42,7 +84,7 @@ static int cppc_cpufreq_set_target(struct cpufreq_policy *policy,
>>  
>>  	cpu = all_cpu_data[policy->cpu];
>>  
>> -	cpu->perf_ctrls.desired_perf = target_freq;
>> +	cpu->perf_ctrls.desired_perf = target_freq * policy->max / cppc_dmi_max_khz;
>>  	freqs.old = policy->cur;
>>  	freqs.new = target_freq;
>>  
>> @@ -94,8 +136,10 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>  		return ret;
>>  	}
>>  
>> -	policy->min = cpu->perf_caps.lowest_perf;
>> -	policy->max = cpu->perf_caps.highest_perf;
>> +	cppc_dmi_max_khz = cppc_get_dmi_max_khz();
>> +
>> +	policy->min = cpu->perf_caps.lowest_perf * cppc_dmi_max_khz / cpu->perf_caps.highest_perf;
>> +	policy->max = cppc_dmi_max_khz;
>>  	policy->cpuinfo.min_freq = policy->min;
>>  	policy->cpuinfo.max_freq = policy->max;
>>  	policy->shared_type = cpu->shared_type;
>> @@ -112,7 +156,8 @@ static int cppc_cpufreq_cpu_init(struct cpufreq_policy *policy)
>>  	cpu->cur_policy = policy;
>>  
>>  	/* Set policy->cur to max now. The governors will adjust later. */
>> -	policy->cur = cpu->perf_ctrls.desired_perf = cpu->perf_caps.highest_perf;
>> +	policy->cur = cppc_dmi_max_khz;
>> +	cpu->perf_ctrls.desired_perf = cpu->perf_caps.highest_perf;
>>  
>>  	ret = cppc_set_perf(cpu_num, &cpu->perf_ctrls);
>>  	if (ret)
>> -- 
>> 2.7.4
> 

Another gentle ping -- any comments?  Can this get pulled in now?

Thanks.

-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
