From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [cpufreq-4.7] New schedutil governor in combination with intel_pstate/x86
Date: Thu, 19 May 2016 15:41:39 +0200
Message-ID: <CA+icZUU3wJ7PFiYgr2DW_Q4vak13TNhzw8AySkFFkuTigZk16g@mail.gmail.com>
References: <CA+icZUV0Mxu+fvrmpJmnDjLmxpSd83hDM5od0_1kw4gEm5aaEw@mail.gmail.com>
	<573B4C2A.4010205@intel.com>
	<CA+icZUVXffgzNBAMHUdzHzX3pSDm8j=Uq3CAK8zVqsdT0UunNw@mail.gmail.com>
	<573BA6C6.901@intel.com>
	<CA+icZUVotMFEXSJ1BNY72zQfB-L-PJbyR_31LK8Obje7YjNJsA@mail.gmail.com>
	<CAJZ5v0htU2WyqwNBcfSG1+AH9iB4LDd_tH1GN604rCyrahwbyw@mail.gmail.com>
	<CA+icZUXV3mz9Yr05o5zHLOcXwYRWydtXZOuLnE10Zy3RwzOHUg@mail.gmail.com>
	<CAJZ5v0g1-KT5Jnh2BYOd66GkkvyTkUe0JNJ5_fxQa4wNvr9fAQ@mail.gmail.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f66.google.com ([209.85.213.66]:34384 "EHLO
	mail-vk0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754667AbcESNlk (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 09:41:40 -0400
Received: by mail-vk0-f66.google.com with SMTP id v68so11865432vka.1
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2016 06:41:40 -0700 (PDT)
In-Reply-To: <CAJZ5v0g1-KT5Jnh2BYOd66GkkvyTkUe0JNJ5_fxQa4wNvr9fAQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On 5/19/16, Rafael J. Wysocki <rafael@kernel.org> wrote:
> On Thu, May 19, 2016 at 2:10 PM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
>> On 5/19/16, Rafael J. Wysocki <rafael@kernel.org> wrote:
>>> On Thu, May 19, 2016 at 1:04 PM, Sedat Dilek <sedat.dilek@gmail.com>
>>> wrote:
>>>> On 5/18/16, Rafael J. Wysocki <rafael.j.wysocki@intel.com> wrote:
>>>>> On 5/18/2016 1:16 AM, Sedat Dilek wrote:
>>>>>> On 5/17/16, Rafael J. Wysocki <rafael.j.wysocki@intel.com> wrote:
>>>>>>> On 5/17/2016 5:30 PM, Sedat Dilek wrote:
>
> [cut]
>
>> [ Sorry, forgot to attach my linux-config and dmesg-output ]
>>
>> No, schedutil is not my default-governor.
>>
>>> The other way to work around it is to unload acpi-cpufreq and
>>> cpufreq_stat and then load the driver again.
>>>
>>
>> I have in my linux-config...
>>
>> #
>> # CPU Frequency scaling
>> #
>> CONFIG_CPU_FREQ=y
>> CONFIG_CPU_FREQ_GOV_ATTR_SET=y
>> CONFIG_CPU_FREQ_GOV_COMMON=y
>> CONFIG_CPU_FREQ_STAT=y
>> CONFIG_CPU_FREQ_STAT_DETAILS=y
>> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
>> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
>> CONFIG_CPU_FREQ_GOV_PERFORMANCE=y
>> CONFIG_CPU_FREQ_GOV_POWERSAVE=y
>> CONFIG_CPU_FREQ_GOV_USERSPACE=y
>> CONFIG_CPU_FREQ_GOV_ONDEMAND=y
>> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=y
>> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=y
>>
>> #
>> # CPU frequency scaling drivers
>> #
>> CONFIG_X86_INTEL_PSTATE=y
>> CONFIG_X86_PCC_CPUFREQ=y
>> CONFIG_X86_ACPI_CPUFREQ=y
>> CONFIG_X86_ACPI_CPUFREQ_CPB=y
>> CONFIG_X86_POWERNOW_K8=y
>> # CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
>> CONFIG_X86_SPEEDSTEP_CENTRINO=y
>> # CONFIG_X86_P4_CLOCKMOD is not set
>>
>> Which of the Kconfigs should be compiled as a module (if available as
>> tristate)?
>>
>> CONFIG_CPU_FREQ_STAT
>
> That needs to be a module.
>
> I guess that should be sufficient, because then you should be able to
> simply unload it, but do that before you switch the governor to
> schedutil.
>
>> CONFIG_X86_ACPI_CPUFREQ
>
> That can be a module too.
>
>> CONFIG_X86_ACPI_CPUFREQ_CPB
>
> You don't need this one on Intel hardware.
>

With these changes...

$ ./scripts/diffconfig /boot/config-4.6.0-4-iniza-small
/boot/config-4.6.0-5-iniza-small
 CPU_FREQ_STAT y -> m
 X86_ACPI_CPUFREQ y -> m
 X86_POWERNOW_K8 y -> m

...I still see "Fast frequency switching not enabled"...

$ sudo modprobe -r -v acpi_cpufreq
[sudo] password for wearefam:
rmmod acpi_cpufreq
$ sudo modprobe -r -v cpufreq_stats
rmmod cpufreq_stats

$ sudo modprobe -v cpufreq_stats
insmod /lib/modules/4.6.0-5-iniza-small/kernel/drivers/cpufreq/cpufreq_stats.ko
$ sudo modprobe -v acpi_cpufreq
insmod /lib/modules/4.6.0-5-iniza-small/kernel/drivers/cpufreq/acpi-cpufreq.ko

# for p in policy0 policy1 policy2 policy3 ; do LC_ALL=C cat
/sys/devices/system/cpu/cpufreq/${p}/scaling_governor ; done
performance
performance
performance
performance

# for p in policy0 policy1 policy2 policy3 ; do LC_ALL=C echo -n
schedutil > /sys/devices/system/cpu/cpufreq/${p}/scaling_governor ;
done

# for p in policy0 policy1 policy2 policy3 ; do LC_ALL=C cat
/sys/devices/system/cpu/cpufreq/${p}/scaling_governor ; done
schedutil
schedutil
schedutil
schedutil

$ dmesg | tail

[  756.114412] cpufreq: CPU0: Fast frequency switching not enabled
[  756.114416] cpufreq: Registered transition notifiers:
[  756.114424] cpufreq: cpufreq_stat_notifier_trans+0x0/0xc0 [cpufreq_stats]
[  756.114725] cpufreq: CPU1: Fast frequency switching not enabled
[  756.114727] cpufreq: Registered transition notifiers:
[  756.114731] cpufreq: cpufreq_stat_notifier_trans+0x0/0xc0 [cpufreq_stats]
[  756.114996] cpufreq: CPU2: Fast frequency switching not enabled
[  756.114998] cpufreq: Registered transition notifiers:
[  756.115002] cpufreq: cpufreq_stat_notifier_trans+0x0/0xc0 [cpufreq_stats]
[  756.115294] cpufreq: CPU3: Fast frequency switching not enabled
[  756.115296] cpufreq: Registered transition notifiers:
[  756.115299] cpufreq: cpufreq_stat_notifier_trans+0x0/0xc0 [cpufreq_stats]

Do I have to enable some CPU setting in the BIOS?

- Sedat -
