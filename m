From: Al Stone <ahs3@redhat.com>
Subject: Re: [PATCH v4] Force cppc_cpufreq to report values in KHz to fix user
 space reporting
Date: Thu, 14 Jul 2016 10:15:39 -0600
Message-ID: <05e072ac-165d-ec06-5ec1-cdc18fca272c@redhat.com>
References: <1468343771-32176-1-git-send-email-ahs3@redhat.com>
 <20160714100320.GA768@arm.com>
Reply-To: ahs3@redhat.com
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20160714100320.GA768@arm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Alexey Klimov <alexey.klimov@arm.com>
Cc: viresh.kumar@linaro.org, ashwin.chaugule@linaro.org, rjw@rjwysocki.net, lenb@kernel.org, linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 07/14/2016 04:03 AM, Alexey Klimov wrote:
> Hi Al,
> 
> On Tue, Jul 12, 2016 at 11:16:11AM -0600, Al Stone wrote:
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
>> While the investigation for a long term fix proceeds (several options
>> are being explored, some of which may require spec changes or other
>> much more invasive fixes), this patch forces the values read by CPPC
>> to be read in KHz, regardless of what they actually represent.
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
>> firmware values being set correctly.  Hence, other approaches are
>> also being considered.
>>
>> This has been tested on three arm64 servers, with and without DMI, with
>> and without CPPC support.
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
>> ---
>>  drivers/acpi/cppc_acpi.c    | 106 +++++++++++++++++++++++++++++++++++++++++---
>>  drivers/cpufreq/Kconfig.arm |   2 +-
>>  2 files changed, 102 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/acpi/cppc_acpi.c b/drivers/acpi/cppc_acpi.c
>> index 8adac69..6e6df9c 100644
>> --- a/drivers/acpi/cppc_acpi.c
>> +++ b/drivers/acpi/cppc_acpi.c
>> @@ -40,8 +40,18 @@
>>  #include <linux/cpufreq.h>
>>  #include <linux/delay.h>
>>  #include <linux/ktime.h>
>> +#include <linux/dmi.h>
>> +
>> +#include <asm/unaligned.h>
>>  
>>  #include <acpi/cppc_acpi.h>
>> +
>> +/* Minimum struct length needed for the DMI processor entry we want */
>> +#define DMI_ENTRY_PROCESSOR_MIN_LENGTH	48
>> +
>> +/* Offest in the DMI processor structure for the max frequency */
>> +#define DMI_PROCESSOR_MAX_SPEED  0x14
>> +
>>  /*
>>   * Lock to provide mutually exclusive access to the PCC
>>   * channel. e.g. When the remote updates the shared region
>> @@ -709,6 +719,56 @@ static int cpc_write(struct cpc_reg *reg, u64 val)
>>  	return ret_val;
>>  }
>>  
>> +static u64 cppc_dmi_khz;
>> +
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
>> +
>> +static u64 cppc_get_dmi_khz(void)
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
>> +static u64 cppc_to_khz(u64 min_in, u64 max_in, u64 val)
>> +{
>> +	/*
>> +	 * The incoming val should be min <= val <= max.  Our
>> +	 * job is to convert that to KHz so it can be properly
>> +	 * reported to user space via cpufreq_policy.
>> +	 */
>> +	u64 curval = val;
>> +	u64 maxf = max_in;
>> +	u64 minf = min_in;
>> +
>> +	/* range check the input values */
>> +	curval = curval < minf ? minf : curval;
>> +	curval = curval > maxf ? maxf : curval;
>> +	minf = minf >= maxf ? maxf - 1 : minf;
> 
> In the pedantic world kernel should warn in dmesg about nominal value that is
> out of range. Or min being larger than max.
> Not really an issue but for debugging purposes..

Fair enough.  I had some pr_warns/pr_info in there before while
I was debugging but pulled them out; it seemed noisy at the time.

>> +	return ((curval - minf) * cppc_dmi_khz) / (maxf - minf);
>> +}
>> +
>>  /**
>>   * cppc_get_perf_caps - Get a CPUs performance capabilities.
>>   * @cpunum: CPU from which to get capabilities info.
>> @@ -748,17 +808,53 @@ int cppc_get_perf_caps(int cpunum, struct cppc_perf_caps *perf_caps)
>>  		}
>>  	}
>>  
>> -	cpc_read(&highest_reg->cpc_entry.reg, &high);
>> -	perf_caps->highest_perf = high;
>> +	/*
>> +	 * Since these values in perf_caps will be used in setting
>> +	 * up the cpufreq policy, they must always be stored in units
>> +	 * of KHz.  If they are not, user space tools will become very
>> +	 * confused since they assume these are in KHz when reading
>> +	 * sysfs.
>> +	 *
>> +	 * NB: there may be better approaches to this problem that, as
>> +	 * of this writing, are still being explored.  Ideally, this is
>> +	 * a short term solution since correlating CPPC abstract values
>> +	 * with CPU frequency may or may not reflect actual performance.
>> +	 *
>> +	 * The reason longer term solutions are being explored is because
>> +	 * this solution requires we make the following assumptions:
>> +	 *
>> +	 *    (1) It relies on SMBIOS3 being used, *and* that the Max
>> +	 *        Frequency value for a processor is set to a non-zero value.
>> +	 *
>> +	 *    (2) It assumes that all processors run at the same speed, or
>> +	 *        that the CPPC values have all been scaled to reflect any
>> +	 *        relative differences.  This code retrieves the largest CPU
>> +	 *        Max Frequency from a type 4 DMI record that it can find.
>> +	 *        This may not be an issue, however, as a sampling of DMI
>> +	 *        data on x86 and arm64 indicates there is often only one
>> +	 *        such record regardless.
>> +	 *
>> +	 *    (3) It assumes that performance and frequency both scale
>> +	 *        linearly.
>> +	 *
>> +	 * None of these are particularly horrible assumptions.  But, they
>> +	 * are assumptions and ultimately we'd like to be able to report
>> +	 * performance without quite so many of them.
>> +	 *
>> +	 */
>> +	cppc_dmi_khz = cppc_get_dmi_khz();
>>  
>> +	cpc_read(&highest_reg->cpc_entry.reg, &high);
>>  	cpc_read(&lowest_reg->cpc_entry.reg, &low);
>> -	perf_caps->lowest_perf = low;
>> +
>> +	perf_caps->highest_perf = cppc_to_khz(low, high, high);
>> +	perf_caps->lowest_perf = cppc_to_khz(low, high, low);
> 
> Just to check. Do I understand correctly that cpufreq subsystem is populated
> with this converted values (policy->min and max), then cpufreq sends request to
> set new target_freq in converted units to CPPC that in its turn is not aware
> about convertation or do i miss something?
> There should be convertation back to abstract scale for cppc to correctly
> understand and handle request to set new desired performance, shouldn't it?

I'll go check again to be sure I didn't miss something, but my understanding
is that the CPPC abstract scale that was provided in the ACPI tables would be
translated to a different range modulo the frequency, with the relationships
between min, max and nominal intact, and that the new range would be used for
the abstract scale instead.  So as far as CPPC and cpufreq are concerned, they
would just use the new range for everything -- they just operate on whatever
range is provided, and are more concerned about the relationships between min,
max and nominal than their actual values.

Maybe that info -- the scale as translated -- needs to be reflected in /sys or
dmesg, too... or perhaps it ultimately makes more sense to change the userspace
tools; I'm operating under the "never break userspace" rule, in this case.

>>  
>>  	cpc_read(&ref_perf->cpc_entry.reg, &ref);
>> -	perf_caps->reference_perf = ref;
>> +	perf_caps->reference_perf = cppc_to_khz(low, high, ref);
>>  
>>  	cpc_read(&nom_perf->cpc_entry.reg, &nom);
>> -	perf_caps->nominal_perf = nom;
>> +	perf_caps->nominal_perf = cppc_to_khz(low, high, nom);
>>  
>>  	if (!ref)
>>  		perf_caps->reference_perf = perf_caps->nominal_perf;
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
>> index 14b1f93..b4aae52 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -253,7 +253,7 @@ config ARM_PXA2xx_CPUFREQ
>>  
>>  config ACPI_CPPC_CPUFREQ
>>  	tristate "CPUFreq driver based on the ACPI CPPC spec"
>> -	depends on ACPI
>> +	depends on ACPI && DMI
>>  	select ACPI_CPPC_LIB
>>  	default n
>>  	help
>> --
> 
> 
> Best regards,
> Alexey
> 


-- 
ciao,
al
-----------------------------------
Al Stone
Software Engineer
Red Hat, Inc.
ahs3@redhat.com
-----------------------------------
