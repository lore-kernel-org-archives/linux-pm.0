From: preeti <preeti@linux.vnet.ibm.com>
Subject: Re: Cpuidle drivers,Suspend : Fix suspend/resume hang with intel_idle
 driver
Date: Fri, 29 Jun 2012 10:56:56 +0530
Message-ID: <4FED3CA0.3050909@linux.vnet.ibm.com>
References: <4FEC20D2.2070501@linux.vnet.ibm.com> <201206281153.25310.rjw@sisk.pl> <4FEC84A4.1000605@linux.vnet.ibm.com> <201206282111.03992.rjw@sisk.pl> <4FED2AF2.4080900@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4FED2AF2.4080900@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Dave Hansen <dave@linux.vnet.ibm.com>, Linux PM mailing list <linux-pm@vger.kernel.org>, linux-pm@lists.linux-foundation.org, linux-acpi@vger.kernel.org, "Srivatsa.S.Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

On 06/29/2012 09:41 AM, preeti wrote:
> On 06/29/2012 12:41 AM, Rafael J. Wysocki wrote:
>> On Thursday, June 28, 2012, preeti wrote:
>>> On 06/28/2012 03:23 PM, Rafael J. Wysocki wrote:
>>>> On Thursday, June 28, 2012, preeti wrote:
>>>>>
>>>>> From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
>> [...]
>>> cpuidle is an architecture independent part of the kernel  code.Since 
>>> this patch aims at x86 architecture in specific,I considered it
>>> inappropriate.
>>>
>>> In addition to this,suspend happens on x86 only if ACPI is configured.
>>
>> But that is not required for intel_idle, so if it hangs with intel_idle,
>> then it is not dependent on ACPI after all.
> True intel_idle does not need ACPI to be configured,but that also means
> that the kernel will not provide you the means to suspend.There is no
> question of resume hang here at all as you cannot suspend in the first
> place.
> 
> The issue is when ACPI is configured,and intel_idle is chosen to be the
> cpuidle driver.In this situation when the user suspends,cpus can enter
> deep sleep states as intel_idle driver does not prevent then from doing so.
> This is when resume hangs.
>>
>>> Therefore it seemed right to put the callback in ACPI specific code
>>> which deals with ACPI sleep support.
>>
>> I wonder if we can address this issue correctly.  That is, in a non-racy
>> way and in a better place.
>>
>> First, I really don't think it is necessary to "suspend" cpuidle (be it
>> ACPI or any other) when device drivers' suspend routines are being
>> executed (which also is racy, because the cpuidle "suspend" may be running
>> concurrently with cpuidle on another CPU) or earlier.  We really may want
>> to disable the deeper C-states when we're about to execute
>> suspend_ops->prepare_late(), or hibernation_ops->prepare(), i.e. after
>> we've run dpm_suspend_end() successfully.
> 
> The commit "ACPI:disable lower idle C-states across suspend/resume"
> states that device_suspend() calls ACPI suspend functions which cause
> side effects on the lower idle C-states.This means we need to disable
> entry into deeper C-states even before dpm_suspend_start(),but how much
> before?
> 
> The commit answers this too.It says removing the functionality of
> entering deep C-states before suspend removed the side effects.Besides,
> the commit title says'across suspend/resume'.So I think to address the
> resume hang effectively,it is desirable to disable entry into deeper
> C-states during suspend_prepare operations.

To clarify this further,since we take action upon PM_SUSPEND_PREPARE
notification,which is called before suspend begins,we avoid race
condition between suspend operations and disabling entry into deeper
c-states altogether.

>>
>> So, it seems, it might be a good idea to place a cpuidle driver suspend
>> (and/or hibernation) hook at the end of dpm_suspend_end() and make ACPI
>> and intel_idle drivers implement that hook.
>>
> Dont you think this patch is meant to fix a very ACPI specific problem?
> Which is why I think the call backs or any hook meant to fix this should
> go into ACPI specific code.
> Else it will seem irrelevant to all other architectures that implement
> suspend.
>> That would be much more deterministic than your patch I think.
>>
>> Thanks,
>> Rafael
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> 
> Regards
> Preeti
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pm" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


