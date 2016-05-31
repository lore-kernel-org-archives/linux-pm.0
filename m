From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Subject: Re: [PATCH v4 09/10] cpuidle/powernv: Add support for POWER ISA v3
 idle states
Date: Tue, 31 May 2016 19:20:04 +0530
Message-ID: <201605311351.u4VDn6W2015318@mx0a-001b2d01.pphosted.com>
References: <1464095714-48772-1-git-send-email-shreyas@linux.vnet.ibm.com> <1464095714-48772-10-git-send-email-shreyas@linux.vnet.ibm.com> <574C4DA4.4050100@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:24734 "EHLO
	mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753034AbcEaNvP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 31 May 2016 09:51:15 -0400
Received: from pps.filterd (m0075771.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id u4VDn6W2015318
	for <linux-pm@vger.kernel.org>; Tue, 31 May 2016 09:51:15 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2395tstqa8-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 31 May 2016 09:51:14 -0400
Received: from localhost
	by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shreyas@linux.vnet.ibm.com>;
	Tue, 31 May 2016 23:51:11 +1000
In-Reply-To: <574C4DA4.4050100@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org, linux-kernel@vger.kernel.org, mikey@neuling.org, ego@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>

Hi Daniel,

On 05/30/2016 07:56 PM, Daniel Lezcano wrote:
> On 05/24/2016 03:15 PM, Shreyas B. Prabhu wrote:
>> POWER ISA v3 defines a new idle processor core mechanism. In summary,
>>   a) new instruction named stop is added.
>>   b) new per thread SPR named PSSCR is added which controls the behavior
>>     of stop instruction.
>>
>> Supported idle states and value to be written to PSSCR register to enter
>> any idle state is exposed via ibm,cpu-idle-state-names and
>> ibm,cpu-idle-state-psscr respectively. To enter an idle state,
>> platform provided power_stop() needs to be invoked with the appropriate
>> PSSCR value.
>>
>> This patch adds support for this new mechanism in cpuidle powernv driver.
>>
>> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
>> Cc: linux-pm@vger.kernel.org
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Paul Mackerras <paulus@ozlabs.org>
>> Cc: linuxppc-dev@lists.ozlabs.org
>> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
>> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
>> ---
>>   - No changes since v1
>>
>>   drivers/cpuidle/cpuidle-powernv.c | 57
>> ++++++++++++++++++++++++++++++++++++++-
>>   1 file changed, 56 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/cpuidle/cpuidle-powernv.c
>> b/drivers/cpuidle/cpuidle-powernv.c
>> index e12dc30..efe5221 100644
>> --- a/drivers/cpuidle/cpuidle-powernv.c
>> +++ b/drivers/cpuidle/cpuidle-powernv.c
>> @@ -21,6 +21,7 @@
>>   #include <asm/runlatch.h>
>>
>>   #define MAX_POWERNV_IDLE_STATES    8
>> +#define MAX_IDLE_STATE_NAME_LEN    10
> 
> Why not reuse cpuidle constants even if they are slightly different ?
> 
> #define CPUIDLE_STATE_MAX       10
> #define CPUIDLE_NAME_LEN        16
> 

I'll reuse the them.

>>   struct cpuidle_driver powernv_idle_driver = {
>>       .name             = "powernv_idle",
>> @@ -29,9 +30,11 @@ struct cpuidle_driver powernv_idle_driver = {
>>
>>   static int max_idle_state;
>>   static struct cpuidle_state *cpuidle_state_table;
>> +
>> +static u64 stop_psscr_table[MAX_POWERNV_IDLE_STATES];
>> +
>>   static u64 snooze_timeout;
>>   static bool snooze_timeout_en;
>> -
>>   static int snooze_loop(struct cpuidle_device *dev,
>>               struct cpuidle_driver *drv,
>>               int index)
>> @@ -139,6 +142,15 @@ static struct notifier_block
>> setup_hotplug_notifier = {
>>       .notifier_call = powernv_cpuidle_add_cpu_notifier,
>>   };
>>
>> +static int stop_loop(struct cpuidle_device *dev,
>> +            struct cpuidle_driver *drv,
>> +            int index)
>> +{
>> +    ppc64_runlatch_off();
>> +    power_stop(stop_psscr_table[index]);
>> +    ppc64_runlatch_on();
>> +    return index;
>> +}
>>   /*
>>    * powernv_cpuidle_driver_init()
>>    */
>> @@ -169,6 +181,8 @@ static int powernv_add_idle_states(void)
>>       int nr_idle_states = 1; /* Snooze */
>>       int dt_idle_states;
>>       u32 *latency_ns, *residency_ns, *flags;
>> +    u64 *psscr_val = NULL;
>> +    const char *names[MAX_POWERNV_IDLE_STATES];
>>       int i, rc;
>>
>>       /* Currently we have snooze statically defined */
>> @@ -201,6 +215,23 @@ static int powernv_add_idle_states(void)
>>           goto out_free_latency;
>>       }
>>
>> +    rc = of_property_read_string_array(power_mgt,
>> +        "ibm,cpu-idle-state-names", names, dt_idle_states);
>> +    if (rc < -1) {
> 
> Why < -1 ?
>

Oversight. I'll fix this.

>> +        pr_warn("cpuidle-powernv: missing ibm,cpu-idle-states-names
>> in DT\n");
>> +        goto out_free_latency;
>> +    }
>> +
>> +    if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> 
> Isn't weird to mix cpu feature and DT bindings check ?
> 

Hmm. I'll add a compatible node in DT to avoid mixing cpu_has_feature
check and DT bindings.

>> +        psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val),
>> +                    GFP_KERNEL);
>> +        rc = of_property_read_u64_array(power_mgt,
>> +            "ibm,cpu-idle-state-psscr", psscr_val, dt_idle_states);
> 
> [cc'ed Lorenzo and Rob ]
> 
> I don't see the documentation for the binding. Wouldn't make sense to
> add the value per idle state instead of an index based array ?
> 
Existing hardware (POWER7 and POWER8) has been using following dt nodes
which are arrays-
ibm,cpu-idle-state-names
ibm,cpu-idle-state-latencies-ns
ibm,cpu-idle-state-flags
ibm,cpu-idle-state-residency-ns
I extended this design and added ibm,cpu-idle-state-psscr to convey the
extra information needed for POWER ISA v3.

Down the line it'll probably make better sense to expose these values
per idle state rather than arrays of individual properties. But I'd like
to hold off on making that design change yet and wait for more design
inputs from the platform side.

>> +        if (rc < -1) {
>> +            pr_warn("cpuidle-powernv: missing
>> ibm,cpu-idle-states-psscr in DT\n");
>> +            goto out_free_psscr;
>> +        }
>> +    }
>>       residency_ns = kzalloc(sizeof(*residency_ns) * dt_idle_states,
>> GFP_KERNEL);
>>       rc = of_property_read_u32_array(power_mgt,
>>           "ibm,cpu-idle-state-residency-ns", residency_ns,
>> dt_idle_states);
>> @@ -218,6 +249,16 @@ static int powernv_add_idle_states(void)
>>               powernv_states[nr_idle_states].flags = 0;
>>               powernv_states[nr_idle_states].target_residency = 100;
>>               powernv_states[nr_idle_states].enter = &nap_loop;
>> +        } else if ((flags[i] & OPAL_PM_STOP_INST_FAST) &&
>> +                !(flags[i] & OPAL_PM_TIMEBASE_STOP)) {
>> +            strncpy(powernv_states[nr_idle_states].name,
>> +                (char *)names[i], MAX_IDLE_STATE_NAME_LEN);
> 
> Why cast names[] to (char *) while strncpy is waiting for const char *,
> the initial type of names[] ?
>
Oversight. Embarrassing one at that. I'll fix it.

>> +            strncpy(powernv_states[nr_idle_states].desc,
>> +                (char *)names[i], MAX_IDLE_STATE_NAME_LEN);
>> +            powernv_states[nr_idle_states].flags = 0;
> 
> No target_residency specified ?
> 

target_residency and latency are already specified in the existing code
outside this if-else block. There is no change in interpreting those nodes.

>> +
>> +            powernv_states[nr_idle_states].enter = &stop_loop;
> 
> s/&stop_loop/stop_loop/

I'll make the change.

Thanks a lot for the review.

-Shreyas

