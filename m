From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v2] cpufreq: intel_pstate: Set EPP/EPB to 0 in performance mode
Date: Wed, 23 Nov 2016 01:53:09 +0100
Message-ID: <CAJZ5v0h5Qx-_p2wfAqDjEt4jQ6h86mHCSfuRaewqumGgONGidQ@mail.gmail.com>
References: <1479858269-175501-1-git-send-email-srinivas.pandruvada@linux.intel.com>
 <CAJZ5v0i_PkFDYze-vwc=u2fY2HhjPL02ZG1xkTE2ksaQQVoecA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wj0-f193.google.com ([209.85.210.193]:36688 "EHLO
        mail-wj0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752790AbcKWBLX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 22 Nov 2016 20:11:23 -0500
Received: by mail-wj0-f193.google.com with SMTP id jb2so7722567wjb.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Nov 2016 17:10:48 -0800 (PST)
In-Reply-To: <CAJZ5v0i_PkFDYze-vwc=u2fY2HhjPL02ZG1xkTE2ksaQQVoecA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <lenb@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>

On Wed, Nov 23, 2016 at 1:42 AM, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Wed, Nov 23, 2016 at 12:44 AM, Srinivas Pandruvada
> <srinivas.pandruvada@linux.intel.com> wrote:
>> When user has selected performance policy, then set the EPP (Energy
>> Performance Preference) or EPB (Energy Performance Bias) to maximum
>> performance mode.
>> Also when user switch back to powersave, then restore EPP/EPB to last
>> EPP/EPB value before entering performance mode. If user has not changed
>> EPP/EPB manually then it will be power on default value.
>>
>> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
>> ---
>> v2:
>>         Save EPP/EPB when policy is switched to performance and restore
>>         on entering powersave policy, when EPP/EPB is still 0.
>>
>>  drivers/cpufreq/intel_pstate.c | 82 ++++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 82 insertions(+)
>>
>> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
>> index 72e8bbc..8e7ceef 100644
>> --- a/drivers/cpufreq/intel_pstate.c
>> +++ b/drivers/cpufreq/intel_pstate.c
>> @@ -243,6 +243,8 @@ struct perf_limits {
>>   *                     when per cpu controls are enforced
>>   * @acpi_perf_data:    Stores ACPI perf information read from _PSS
>>   * @valid_pss_table:   Set to true for valid ACPI _PSS entries found
>> + * @epp_saved:         Last saved HWP energy performance preference
>> + *                     or energy performance bias
>>   *
>>   * This structure stores per CPU instance data for all CPUs.
>>   */
>> @@ -270,6 +272,7 @@ struct cpudata {
>>         bool valid_pss_table;
>>  #endif
>>         unsigned int iowait_boost;
>> +       int epp_saved;
>>  };
>>
>>  static struct cpudata **all_cpu_data;
>> @@ -568,6 +571,48 @@ static inline void update_turbo_state(void)
>>                  cpu->pstate.max_pstate == cpu->pstate.turbo_pstate);
>>  }
>>
>> +static int intel_pstate_get_epb(struct cpudata *cpu_data)
>> +{
>> +       u64 epb;
>> +       int ret;
>> +
>> +       if (!static_cpu_has(X86_FEATURE_EPB))
>> +               return -ENXIO;
>> +
>> +       ret = rdmsrl_on_cpu(cpu_data->cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb);
>> +       if (ret)
>> +               return ret;
>> +
>> +       return (int)(epb & 0x0f);
>> +}
>> +
>> +static int intel_pstate_get_epp(struct cpudata *cpu_data, u64 hwp_req_data)
>> +{
>> +       int epp;
>> +
>> +       if (static_cpu_has(X86_FEATURE_HWP_EPP))
>> +               epp = (hwp_req_data >> 24) & 0xff;
>> +       else
>> +               /* When there is no EPP present, HWP uses EPB settings */
>> +               epp = intel_pstate_get_epb(cpu_data);
>> +
>> +       return epp;
>> +}
>> +
>> +static void intel_pstate_set_epb(int cpu, int pref)
>> +{
>> +       u64 epb;
>> +
>> +       if (!static_cpu_has(X86_FEATURE_EPB))
>> +               return;
>> +
>> +       if (rdmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, &epb))
>> +               return;
>> +
>> +       epb = (epb & ~0x0f) | pref;
>> +       wrmsrl_on_cpu(cpu, MSR_IA32_ENERGY_PERF_BIAS, epb);
>> +}
>> +
>>  static void intel_pstate_hwp_set(const struct cpumask *cpumask)
>>  {
>>         int min, hw_min, max, hw_max, cpu, range, adj_range;
>> @@ -576,6 +621,8 @@ static void intel_pstate_hwp_set(const struct cpumask *cpumask)
>>
>>         for_each_cpu(cpu, cpumask) {
>>                 int max_perf_pct, min_perf_pct;
>> +               struct cpudata *cpu_data = all_cpu_data[cpu];
>> +               int epp;
>>
>>                 if (per_cpu_limits)
>>                         perf_limits = all_cpu_data[cpu]->perf_limits;
>> @@ -604,6 +651,41 @@ static void intel_pstate_hwp_set(const struct cpumask *cpumask)
>>
>>                 value &= ~HWP_MAX_PERF(~0L);
>>                 value |= HWP_MAX_PERF(max);
>> +               if (cpu_data->policy == CPUFREQ_POLICY_PERFORMANCE) {
>> +                       epp = intel_pstate_get_epp(cpu_data, value);
>> +                       if (epp)
>> +                               cpu_data->epp_saved = epp;
>
> I guess 0 is a valid value to save too, isn't it?
>
>> +
>> +                       /* If EPP read was failed, then don't try to write */
>> +                       if (epp < 0)
>> +                               goto skip_epp;
>
> So I guess the above could be
>
>                        epp = intel_pstate_get_epp(cpu_data, value);
>                        /* If EPP read failed, then don't try to write */
>                        if (epp < 0)
>                                goto skip_epp;
>
>                       cpu_data->epp_saved = epp;
>
>> +
>> +                       epp = 0;
>> +               } else {
>> +                       /* skip setting EPP, when saved value is invalid */
>> +                       if (cpu_data->epp_saved < 0)
>> +                               goto skip_epp;
>> +

This can be avoided too I suppose if epp_saved is initialized with the
initial value of the EPP.

Thanks,
Rafael
