From: Sedat Dilek <sedat.dilek@gmail.com>
Subject: Re: [cpufreq-4.7] New schedutil governor in combination with intel_pstate/x86
Date: Thu, 19 May 2016 13:04:11 +0200
Message-ID: <CA+icZUVotMFEXSJ1BNY72zQfB-L-PJbyR_31LK8Obje7YjNJsA@mail.gmail.com>
References: <CA+icZUV0Mxu+fvrmpJmnDjLmxpSd83hDM5od0_1kw4gEm5aaEw@mail.gmail.com>
	<573B4C2A.4010205@intel.com>
	<CA+icZUVXffgzNBAMHUdzHzX3pSDm8j=Uq3CAK8zVqsdT0UunNw@mail.gmail.com>
	<573BA6C6.901@intel.com>
Reply-To: sedat.dilek@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-vk0-f65.google.com ([209.85.213.65]:33994 "EHLO
	mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753713AbcESLEM (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 07:04:12 -0400
Received: by mail-vk0-f65.google.com with SMTP id v68so11248555vka.1
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2016 04:04:12 -0700 (PDT)
In-Reply-To: <573BA6C6.901@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, linux-pm@vger.kernel.org

On 5/18/16, Rafael J. Wysocki <rafael.j.wysocki@intel.com> wrote:
> On 5/18/2016 1:16 AM, Sedat Dilek wrote:
>> On 5/17/16, Rafael J. Wysocki <rafael.j.wysocki@intel.com> wrote:
>>> On 5/17/2016 5:30 PM, Sedat Dilek wrote:
>>>> Hi,
>>> Hi,
>>>
>>> You have a broken address of linux-pm (it leads to nowhere).
>>>
>> Grrr, yeah you are right.
>>
>>>> I wonder if the Kconfig logic is correct when using
>>>> CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y in combination with
>>>> intel_pstate driver for X86 architecture
>>>>
>>>> The available scaling-governors for intel_pstate are: performance
>>>> powersave.
>>>>
>>>> Only acpi-cpufreq can use the new schedutil governor.
>>> The right way to say that would be that intel_pstate doesn't work with
>>> cpufreq governors.
>>>
>>> scalling_governor is just used by intel_pstate as an interface for
>>> choosing the mode it works in and it always uses its own built-in
>>> "governor".  And BTW, intel_pstate "powersave" is not the same as the
>>> cpufreq's "powersave" even.
>>>
>>>> Shouldn't it be prevented from selecting schedutil governor as default
>>>> when CONFIG_X86_INTEL_PSTATE=y is set?
>>> That should apply to "ondemand" too and it doesn't, so no.
>>>
>>> "schedutil" is just a regular cpufreq governor and it doesn't care about
>>> intel_pstate.
>>>
>>>> It makes no real sense to me.
>>>>
>>>> Ubuntu has in it's kernels CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y.
>>>>
>>>> What are the alternatives?
>>>> Set CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y.
>>> You can choose every cpufreq governor as the default.  There are 6 of
>>> then now in the tree.
>>>
>>>> BTW, I cannot change my scaling-driver...
>>>> ...intel_pstate -> acpi-cpufreq...
>>>>
>>>> root# for p in policy0 policy1 policy2 policy3 ; do LC_ALL=C echo -n
>>>> acpi-cpufreq > /sys/devices/system/cpu/cpufreq/${p}/scaling_driver ;
>>>> done
>>>>
>>>> Attached is also a modified /etc/init.d/ondemand script from my
>>>> Ubuntu/precise AMD64 to use and fallback to schedutil governor.
>>> No, you can't change the scaling driver this way.
>>>
>>> It actually is not possible to change from intel_pstate to anything else
>>> now.  To run without intel_pstate, you need to add
>>> "intel_pstate=disable" to the kernel command line.
>>>
>> OK, I will try intel_pstate=disable in my k-c-l.
>>
>> Is there no way to switch between acpi-cpufreq and intel_pstate on the
>> fly?
>
> No, there's no way to do that ATM.
>
>> Did not look in the Kconfig sections...
>> Can I built both as modules?
>> Then unload and load the other?
>
> No, intel_pstate can't be built as a module.
>

It's really a pity that I cannot switch on the fly between
cpufreq/schedutil vs. intel_pstate/x86
Hmm, I have to read your replies carefully and this topic is still
confusing for me.

I tried in the meantime "intel_pstate=disable" in my kernel-command-line.

$ dmesg | egrep -i 'intel_pstate|cpufreq|cpuidle|cpu[0-3]'
[    0.000000] Command line:
BOOT_IMAGE=/boot/vmlinuz-4.6.0-4-iniza-small
root=UUID=001AADA61AAD9964 loop=/ubuntu/disks/root.disk ro
intel_pstate=disable
[    0.000000] ACPI: SSDT 0x00000000DAFEB000 000804 (v01 PmRef
Cpu0Ist  00003000 INTL 20061109)
[    0.000000] Kernel command line:
BOOT_IMAGE=/boot/vmlinuz-4.6.0-4-iniza-small
root=UUID=001AADA61AAD9964 loop=/ubuntu/disks/root.disk ro
intel_pstate=disable
[    0.003982] CPU0: Thermal monitoring enabled (TM1)
[    0.075695] smpboot: CPU0: Intel(R) Core(TM) i5-2467M CPU @ 1.60GHz
(family: 0x6, model: 0x2a, stepping: 0x7)
[    0.342317] cpuidle: using governor ladder
[    0.358253] cpuidle: using governor menu
[    0.422578] ACPI: SSDT 0xFFFF8800D58F9000 000688 (v01 PmRef
Cpu0Cst  00003001 INTL 20061109)
[    0.855129] microcode: CPU0 sig=0x206a7, pf=0x10, revision=0x28
[    0.855157] microcode: CPU1 sig=0x206a7, pf=0x10, revision=0x28
[    0.855190] microcode: CPU2 sig=0x206a7, pf=0x10, revision=0x28
[    0.855227] microcode: CPU3 sig=0x206a7, pf=0x10, revision=0x28
[   85.914640] cpufreq: CPU0: Fast frequency switching not enabled
[   85.914645] cpufreq: Registered transition notifiers:
[   85.914702] cpufreq: cpufreq_stat_notifier_trans+0x0/0xc0
[   85.914948] cpufreq: CPU1: Fast frequency switching not enabled
[   85.914950] cpufreq: Registered transition notifiers:
[   85.914954] cpufreq: cpufreq_stat_notifier_trans+0x0/0xc0
[   85.915093] cpufreq: CPU2: Fast frequency switching not enabled
[   85.915095] cpufreq: Registered transition notifiers:
[   85.915099] cpufreq: cpufreq_stat_notifier_trans+0x0/0xc0
[   85.915188] cpufreq: CPU3: Fast frequency switching not enabled
[   85.915190] cpufreq: Registered transition notifiers:
[   85.915193] cpufreq: cpufreq_stat_notifier_trans+0x0/0xc0

Some sysfs-kungfu with acpi-cpufreq/schedutil ...

# LC_ALL=C ls -lR /sys/devices/system/cpu/cpufreq/policy0/
/sys/devices/system/cpu/cpufreq/policy0/:
total 0
-r--r--r-- 1 root root 4096 May 19 12:54 affected_cpus
-r--r--r-- 1 root root 4096 May 19 12:54 bios_limit
-r-------- 1 root root 4096 May 19 12:54 cpuinfo_cur_freq
-r--r--r-- 1 root root 4096 May 19 12:54 cpuinfo_max_freq
-r--r--r-- 1 root root 4096 May 19 12:54 cpuinfo_min_freq
-r--r--r-- 1 root root 4096 May 19 12:54 cpuinfo_transition_latency
-r--r--r-- 1 root root 4096 May 19 12:54 freqdomain_cpus
-r--r--r-- 1 root root 4096 May 19 12:54 related_cpus
-r--r--r-- 1 root root 4096 May 19 12:54 scaling_available_frequencies
-r--r--r-- 1 root root 4096 May 19 12:54 scaling_available_governors
-r--r--r-- 1 root root 4096 May 19 12:54 scaling_cur_freq
-r--r--r-- 1 root root 4096 May 19 12:54 scaling_driver
-rw-r--r-- 1 root root 4096 May 19 11:46 scaling_governor
-rw-r--r-- 1 root root 4096 May 19 12:54 scaling_max_freq
-rw-r--r-- 1 root root 4096 May 19 12:54 scaling_min_freq
-rw-r--r-- 1 root root 4096 May 19 12:54 scaling_setspeed
drwxr-xr-x 2 root root    0 May 19 12:54 stats

/sys/devices/system/cpu/cpufreq/policy0/stats:
total 0
-r--r--r-- 1 root root 4096 May 19 13:00 time_in_state
-r--r--r-- 1 root root 4096 May 19 13:00 total_trans
-r--r--r-- 1 root root 4096 May 19 13:00 trans_table

# for p in policy0 policy1 policy2 policy3 ; do LC_ALL=C cat
/sys/devices/system/cpu/cpufreq/${p}/scaling_driver ; done
acpi-cpufreq
acpi-cpufreq
acpi-cpufreq
acpi-cpufreq

# for p in policy0 policy1 policy2 policy3 ; do LC_ALL=C cat
/sys/devices/system/cpu/cpufreq/${p}/scaling_governor ; done
schedutil
schedutil
schedutil
schedutil

# for p in policy0 policy1 policy2 policy3 ; do LC_ALL=C cat
/sys/devices/system/cpu/cpufreq/${p}/scaling_available_governors ;
done
conservative ondemand userspace powersave schedutil performance
conservative ondemand userspace powersave schedutil performance
conservative ondemand userspace powersave schedutil performance
conservative ondemand userspace powersave schedutil performance

# for p in policy0 policy1 policy2 policy3 ; do LC_ALL=C cat
/sys/devices/system/cpu/cpufreq/${p}/scaling_available_frequencies ;
done
1601000 1600000 1500000 1400000 1300000 1200000 1100000 1000000 900000 800000
1601000 1600000 1500000 1400000 1300000 1200000 1100000 1000000 900000 800000
1601000 1600000 1500000 1400000 1300000 1200000 1100000 1000000 900000 800000
1601000 1600000 1500000 1400000 1300000 1200000 1100000 1000000 900000 800000

# cat /sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us
10000

Just did not found it...
How do I enable "Fast frequency switching" on my cpu-cores?

- Sedat -
