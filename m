From: Stephen Boyd <sboyd@codeaurora.org>
Subject: Re: [PATCH v7 4/7] qcom: pm: Add cpu low power mode functions
Date: Wed, 01 Oct 2014 17:10:12 -0700
Message-ID: <542C97E4.9000801@codeaurora.org>
References: <1411779495-39724-1-git-send-email-lina.iyer@linaro.org> <1411779495-39724-5-git-send-email-lina.iyer@linaro.org> <5429ED1D.5060809@codeaurora.org> <20140930160310.GC528@ilina-mac.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <20140930160310.GC528@ilina-mac.local>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Lina Iyer <lina.iyer@linaro.org>
Cc: daniel.lezcano@linaro.org, khilman@linaro.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org
List-Id: linux-pm@vger.kernel.org

On 09/30/14 09:03, Lina Iyer wrote:
> On Mon, Sep 29 2014 at 17:37 -0600, Stephen Boyd wrote:
>> On 09/26/14 17:58, Lina Iyer wrote:
>>> Based on work by many authors, available at codeaurora.org
>>>
>>
>>> Signed-off-by: Lina Iyer <lina.iyer@linaro.org>
>>> [lina: simplify the driver for an initial submission, add commit text
>>> description of idle states]
>>
>> Maintainer tags don't really make sense unless there is another author.
>>
> Hmm.. Since this patch is a derivative work, I wanted to clarify, what
> changed seems important. The work was done by many authors. Adding
> signed-off from everybody who could have contributed to the patch
> downstream is confusing.
> I would be okay removing it.
>

Kevin's suggestion is good.

>> +
> [...]
>>> +static int qcom_pm_collapse(unsigned long int unused)
>>> +{
>>> +    int ret;
>>> +    u32 flag;
>>> +
>>> +    ret = set_up_boot_address(cpu_resume, raw_smp_processor_id());
>>
>> Preemption better be off here, so why are we using
>> raw_smp_processor_id()?
>>
> True, so raw_ returns without premeption disable, no?
>
>

No. raw_ just means "I know what I'm doing, go away preemption checks"
which usually is not the right thing if you actually care about the CPU
this code is running on staying the same after you call the function.

>>> +        return ret;
>>> +    }
>>> +
>>> +    flag = SCM_L2_ON & SCM_FLUSH_FLAG_MASK;
>>> +    scm_call_atomic1(SCM_SVC_BOOT, SCM_CMD_TERMINATE_PC, flag);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +/**
>>> + * qcom_cpu_pm_enter_sleep(): Enter a low power mode on current cpu
>>> + *
>>> + * @mode - sleep mode to enter
>>> + *
>>> + * The code should be called with interrupts disabled and on the
>>> core on
>>> + * which the low power mode is to be executed.
>>> + *
>>> + */
>>> +static int qcom_cpu_pm_enter_sleep(enum pm_sleep_mode mode)
>>> +{
>>> +    int ret;
>>> +
>>> +    switch (mode) {
>>> +    case PM_SLEEP_MODE_SPC:
>>> +        qcom_spm_set_low_power_mode(SPM_MODE_POWER_COLLAPSE);
>>
>> Isn't it a one-to-one between PM_SLEEP_MODE_SPC and
>> SPM_MODE_POWER_COLLAPSE? The enum to enum map seems overly complicated.
>>
> Not really. SPM modes, differ when the idle state has to notify RPM. It
> does not have 2 enums for those modes, but uses an overloaded enum with
> an additional flag.
>

I imagine that the RPM notification will go into power domains? From the
cpuidle perspective we're putting the CPU into wfi, retention, gdhs,
power collapse and those correspond exactly to a flat mapping of the cpu
idle indices. Those idle states will tell the power domain "I have this
much time to sleep" and the power domain path will determine if we can
go notify the RPM or not based on the time and the state of the other
CPUs. At least this is my understanding of what Daniel was saying about
how power domains could be used to overcome the "hierarchical" idle states.

>>> +
>>> +static int __init qcom_pm_device_init(void)
>>> +{
>>> +    platform_device_register(&qcom_cpuidle_device);
>>> +
>>> +    return 0;
>>> +}
>>> +device_initcall(qcom_pm_device_init);
>>
>> modules?
>>
> Why? An earlier initialization helps with power saving

If that was true the bootloader should do it. The goal is to move away
from initcall ordering and use probe defer for these things.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
