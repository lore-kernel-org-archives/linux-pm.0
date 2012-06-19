From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [linux-pm] acpi_idle and max_cpus
Date: Tue, 19 Jun 2012 12:33:24 +0530
Message-ID: <4FE0243C.4040600@linux.vnet.ibm.com>
References: <4FDB549F.1020002@linaro.org> <4FDE3B96.8030306@linaro.org> <4FDF1E3A.6010200@linux.vnet.ibm.com> <4FDF24FE.1010108@linaro.org> <4FE02233.2060809@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4FE02233.2060809@linux.vnet.ibm.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 06/19/2012 12:24 PM, Deepthi Dharwar wrote:

> On 06/18/2012 06:24 PM, Daniel Lezcano wrote:
> 
>> On 06/18/2012 02:25 PM, Deepthi Dharwar wrote:
>>> Hi Daniel,
>>>
>>> On 06/18/2012 01:48 AM, Daniel Lezcano wrote:
>>>
>>>> On 06/15/2012 05:28 PM, Daniel Lezcano wrote:
>>>>>
>>>>> Hi all,
>>>>>
>>>>> I have a dual core Intel T9500.
>>>>>
>>>>> I boot the cpu with the acpi_idle driver and intel_idle enabled in the
>>>>> config.
>>>>>
>>>>> The kernel is booted with maxcpus=1.
>>>>>
>>>>> After the system has boot, I put cpu1 online via sysfs.
>>>>>
>>>>> But I don't see any 'cpuidle' directory in the cpu's sysfs entry:
>>>>>
>>>>> /sys/devices/system/cpu/cpu1/cpuidle (?)
>>>>>
>>>>> When I look at the code I see the notifier is present for hotplug in
>>>>> processor_driver.c and the cpuidle intel init routine should be called
>>>>> there.
>>>>>
>>>
>>>
>>> Yes, we have a hotplug notifier.
>>> Commit 99b72508  by Thomas Renninger fixed this issue.
>>>
>>> Please let me know which kernel version you are running and what is idle
>>> driver registered ?
>>
>> The kernel version is 3.5.0-rc1
>> The registered driver is acpi_idle (with intel_idle if I am not wrong).
>>
>> Thomas's patch is in this version.
>>
>> Maybe I am wrong but I think the patch is not correct because:
>>
>> static int __cpuinit acpi_processor_add(struct acpi_device *device)
>> {
>>
>>  ...
>>
>> #ifdef CONFIG_SMP
>> 	if (pr->id >= setup_max_cpus && pr->id != 0)
>> 		return 0;
>> #endif
>>
>>  ...
>>
>> 	per_cpu(processors, pr->id) = pr;
>>
>> ...
>> }
>>
>> With max_cpus=1 we exit before setting up 'pr'.
>>
>> So the condition in:
>>
>> static int acpi_cpu_soft_notify(...)
>> {
>>
>> 	unsigned int cpu = (unsigned long)hcpu;
>> 	struct acpi_processor *pr = per_cpu(processors, cpu);
>>
>> 	if (action == CPU_ONLINE && pr) {
>>
>> ...
>> }
>>
>> Is always false because pr == NULL
>>
>> I did the change but I don't still see the 'cpuidle' directory
>> appearing, I suspect also pr->flags.need_hotplug_init is not correctly
>> initialized but I did not investigate more.
>>
> 
> 
> Well looks like variable maxcpus holds the key here.
> 


Whose equivalent is setup_max_cpus inside the kernel, as Daniel mentioned.

> When I am booting the system, say with 2 out of 4 available cpus,
> set via maxcpus variable with intel_idle or acpi_idle and onlining the
> other 2 cpus later via sysfs, I dont see cpufreq or cpuidle dir in the
> sysfs path.
> 
> # cd /sys/devices/system/cpu/cpu2
> xxx:/sys/devices/system/cpu/cpu2# ls
> 	crash_notes  node0  online
> xxx:/sys/devices/system/cpu/cpu2# echo 1 > online
> xxx:/sys/devices/system/cpu/cpu2# ls
> cache  crash_notes  node0  online  thermal_throttle  topology
> 
> So looks like its designed that way for now.


I don't think so. Looks more like a bug than a design ;-)

> So if maxcpus=X, X<Y where Y is no of available cpus.
> Enabling the Y-X cpus later after the boot via sysfs is not enabling
> cpuidle and cpufreq .
> 
> The question is, do we want to modify this behavior ?
> 


Yes we do, and that's Daniel's pain point as well. I don't think there is
any good reason why the cpuidle directory must _not_ be exported for cpus
that are onlined later.

Regards,
Srivatsa S. Bhat

