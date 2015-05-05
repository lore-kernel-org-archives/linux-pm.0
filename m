From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v3 1/6] cpufreq: poowernv: Handle throttling due to Pmax
 capping at chip level
Date: Tue, 05 May 2015 11:36:33 +0530
Message-ID: <55485DE9.4070609@linux.vnet.ibm.com>
References: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <1430729652-14813-2-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <55483E4B.4080405@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-6
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp05.in.ibm.com ([122.248.162.5]:57965 "EHLO
	e28smtp05.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752573AbbEEGHC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2015 02:07:02 -0400
Received: from /spool/local
	by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Tue, 5 May 2015 11:36:59 +0530
In-Reply-To: <55483E4B.4080405@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org

Hi Preeti,

On 05/05/2015 09:21 AM, Preeti U Murthy wrote:
> Hi Shilpa,
> 
> On 05/04/2015 02:24 PM, Shilpasri G Bhat wrote:
>> The On-Chip-Controller(OCC) can throttle cpu frequency by reducing the
>> max allowed frequency for that chip if the chip exceeds its power or
>> temperature limits. As Pmax capping is a chip level condition report
>> this throttling behavior at chip level and also do not set the global
>> 'throttled' on Pmax capping instead set the per-chip throttled
>> variable. Report unthrottling if Pmax is restored after throttling.
>>
>> This patch adds a structure to store chip id and throttled state of
>> the chip.
>>
>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>> ---
>>  drivers/cpufreq/powernv-cpufreq.c | 59 ++++++++++++++++++++++++++++++++++++---
>>  1 file changed, 55 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>> index ebef0d8..d0c18c9 100644
>> --- a/drivers/cpufreq/powernv-cpufreq.c
>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>> @@ -27,6 +27,7 @@
>>  #include <linux/smp.h>
>>  #include <linux/of.h>
>>  #include <linux/reboot.h>
>> +#include <linux/slab.h>
>>
>>  #include <asm/cputhreads.h>
>>  #include <asm/firmware.h>
>> @@ -42,6 +43,13 @@
>>  static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
>>  static bool rebooting, throttled;
>>
>> +static struct chip {
>> +	unsigned int id;
>> +	bool throttled;
>> +} *chips;
>> +
>> +static int nr_chips;
>> +
>>  /*
>>   * Note: The set of pstates consists of contiguous integers, the
>>   * smallest of which is indicated by powernv_pstate_info.min, the
>> @@ -301,22 +309,33 @@ static inline unsigned int get_nominal_index(void)
>>  static void powernv_cpufreq_throttle_check(unsigned int cpu)
>>  {
>>  	unsigned long pmsr;
>> -	int pmsr_pmax, pmsr_lp;
>> +	int pmsr_pmax, pmsr_lp, i;
>>
>>  	pmsr = get_pmspr(SPRN_PMSR);
>>
>> +	for (i = 0; i < nr_chips; i++)
>> +		if (chips[i].id == cpu_to_chip_id(cpu))
>> +			break;
>> +
>>  	/* Check for Pmax Capping */
>>  	pmsr_pmax = (s8)PMSR_MAX(pmsr);
>>  	if (pmsr_pmax != powernv_pstate_info.max) {
>> -		throttled = true;
>> -		pr_info("CPU %d Pmax is reduced to %d\n", cpu, pmsr_pmax);
>> -		pr_info("Max allowed Pstate is capped\n");
>> +		if (chips[i].throttled)
>> +			goto next;
>> +		chips[i].throttled = true;
>> +		pr_info("CPU %d on Chip %u has Pmax reduced to %d\n", cpu,
>> +			chips[i].id, pmsr_pmax);
>> +	} else if (chips[i].throttled) {
>> +		chips[i].throttled = false;
> 
> Is this check on pmax sufficient to indicate that the chip is unthrottled ?

Unthrottling due to Pmax uncapping here is specific to a chip. So it is
sufficient to decide throttling/unthrottling when OCC is active for that chip.

> 
>> +		pr_info("CPU %d on Chip %u has Pmax restored to %d\n", cpu,
>> +			chips[i].id, pmsr_pmax);
>>  	}
>>
>>  	/*
>>  	 * Check for Psafe by reading LocalPstate
>>  	 * or check if Psafe_mode_active is set in PMSR.
>>  	 */
>> +next:
>>  	pmsr_lp = (s8)PMSR_LP(pmsr);
>>  	if ((pmsr_lp < powernv_pstate_info.min) ||
>>  				(pmsr & PMSR_PSAFE_ENABLE)) {
>> @@ -414,6 +433,33 @@ static struct cpufreq_driver powernv_cpufreq_driver = {
>>  	.attr		= powernv_cpu_freq_attr,
> 
> What about the situation where although occ is active, this particular
> chip has been throttled and we end up repeatedly reporting "pstate set
> to safe" and "frequency control disabled from OS" ? Should we not have a
> check on (chips[i].throttled) before reporting an anomaly for these two
> scenarios as well just like you have for pmsr_pmax ?

We will not have "Psafe" and "frequency control disabled" repeatedly printed
because of global variable 'throttled', which is set to true on passing any of
these two conditions.

It is quite unlikely behavior to have only one chip in "Psafe" or "frequency
control disabled" state. These two conditions are most likely to happen during
an OCC reset cycle which will occur across all chips.

Thanks and Regards,
Shilpa

