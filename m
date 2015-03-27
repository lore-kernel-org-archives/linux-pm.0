From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] cpufreq: powernv: Add checks to report cpu frequency
 throttling conditions
Date: Fri, 27 Mar 2015 12:02:26 +0530
Message-ID: <5514F97A.4000302@linux.vnet.ibm.com>
References: <1427395282-31875-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com> <CAKohpokXx+PfBo7vDVcfLS1R1+5j7MaDHxK6QG+vtaG9LgSS4w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpokXx+PfBo7vDVcfLS1R1+5j7MaDHxK6QG+vtaG9LgSS4w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Viresh,

On 03/27/2015 10:05 AM, Viresh Kumar wrote:
> Hi Shilpa,
> 
> On 27 March 2015 at 00:11, Shilpasri G Bhat
> <shilpa.bhat@linux.vnet.ibm.com> wrote:
>> Cpu frequency can be throttled due to failures of components like OCC,
>> power supply and fan. It can also be throttled due to temperature and
>> power limit. We can detect the throttling by checking 1)if max frequency
> 
> Add these points in separate lines please, with a space after ). Its not
> readable this way..

Will do.
> 
>> is reduced, 2)if the core is put to safe frequency 3)if the SPR based
>> frequency management is disabled.
> 
> All these three points refer to the state CPU has shifted to ? Sorry it wasn't
> clear to the outsiders :), perhaps some more detail on why CPU would have
> done that.

The power and thermal safety of the system is taken care by an
On-Chip-Controller (OCC) which is real-time subsystem embedded within the POWER8
processor. OCC continuously monitors the memory and core temperature, the total
system power, state of power supply and fan.

The cpu frequency can be throttled for the following reason:
1)If a processor crosses its power and temperature limit then OCC will lower its
Pmax to reduce the frequency and voltage.
2)If OCC crashes then the system is forced to Psafe frequency.
3)If OCC fails to recover then the kernel is not allowed to do any further
frequency changes and the chip will remain in Psafe.

The user can see a drop in performance when frequency is throttled and is
unaware of throttling. So we want to report such a condition so that user can
check the OCC status to reboot the system or check for power supply or fan failures.

> 
>> The current status of the core is read from Power Management Status
>> Register(PMSR) to check if any of the throttling condition is
>> occurred and the appropriate throttling message is reported.
> 
> So, what do we want to do on throttling? Just print a warning? Is that
> enough? What if CPU gets heated up to a point that it burns up ?

On over temperature safety measures are taken by OCC one of which being
throttling frequency. As the chip frequency and voltage is already lowered, not
sure what we can do apart from reporting. Maybe on detection of throttling
kernel can take corrective measure to migrate the tasks from that cpu or it can
force the cpu to idle.
> 
>> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
>> ---
>> Changes from V1: Removed unused value of PMCR register
>>
>>  drivers/cpufreq/powernv-cpufreq.c | 39 ++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 38 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
>> index 2dfd4fd..4837eed 100644
>> --- a/drivers/cpufreq/powernv-cpufreq.c
>> +++ b/drivers/cpufreq/powernv-cpufreq.c
>> @@ -36,7 +36,7 @@
>>  #define POWERNV_MAX_PSTATES    256
>>
>>  static struct cpufreq_frequency_table powernv_freqs[POWERNV_MAX_PSTATES+1];
>> -static bool rebooting;
>> +static bool rebooting, throttled;
>>
>>  /*
>>   * Note: The set of pstates consists of contiguous integers, the
>> @@ -294,6 +294,40 @@ static inline unsigned int get_nominal_index(void)
>>         return powernv_pstate_info.max - powernv_pstate_info.nominal;
>>  }
>>
>> +static void powernv_cpufreq_throttle_check(unsigned int cpu)
>> +{
>> +       unsigned long pmsr;
>> +       int pmsr_pmax, pmsr_lp;
>> +
>> +       pmsr = get_pmspr(SPRN_PMSR);
>> +
>> +       /* Check for Pmax Capping */
>> +       pmsr_pmax = (s8)((pmsr >> 32) & 0xFF);
> 
> u8 ?

Pstate is negative. I want to propagate the sign.
> 
>> +       if (pmsr_pmax != powernv_pstate_info.max) {
>> +               throttled = true;
>> +               pr_warn("Cpu %d Pmax is reduced to %d\n", cpu, pmsr_pmax);
>> +       }
>> +
>> +       /* Check for Psafe by reading LocalPstate
>> +        * or check if Psafe_mode_active- 34th bit is set in PMSR.
>> +        */
> 
> Proper multi-line comment format is:
> 
> /*
>  * ....
>  */
> 
> 
Will do.
>> +       pmsr_lp = (s8)((pmsr >> 48) & 0xFF);
>> +       if ((pmsr_lp < powernv_pstate_info.min) || ((pmsr >> 30) & 1)) {
>> +               throttled = true;
>> +               pr_warn("Cpu %d in Psafe %d PMSR[34]=%lx\n", cpu,
>> +                               pmsr_lp, ((pmsr >> 30) & 1));
>> +       }
>> +
>> +       /* Check if SPR_EM_DISABLED- 33rd bit is set in PMSR */
>> +       if ((pmsr >> 31) & 1) {
>> +               throttled = true;
>> +               pr_warn("Frequency management disabled cpu %d PMSR[33]=%lx\n",
>> +                               cpu, ((pmsr >> 31) & 1));
>> +       }
>> +       if (throttled)
>> +               pr_warn("Cpu Frequency is throttled\n");
>> +}
>> +
>>  /*
>>   * powernv_cpufreq_target_index: Sets the frequency corresponding to
>>   * the cpufreq table entry indexed by new_index on the cpus in the
>> @@ -307,6 +341,9 @@ static int powernv_cpufreq_target_index(struct cpufreq_policy *policy,
>>         if (unlikely(rebooting) && new_index != get_nominal_index())
>>                 return 0;
>>
>> +       if (!throttled)
>> +               powernv_cpufreq_throttle_check(smp_processor_id());
> 
> And CPU can't come out of throttling again ?

Yes we can come out of throttling if OCC recovers. We need a separate
notification from firmware when we try to recover. I will send a different patch
where driver registers to recovery notification and on successful recovery we
can reset 'throttled' to false.

> 
>> +
>>         freq_data.pstate_id = powernv_freqs[new_index].driver_data;
> 
