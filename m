From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [cpufreq-4.7] New schedutil governor in combination with intel_pstate/x86
Date: Thu, 19 May 2016 13:54:45 +0200
Message-ID: <CAJZ5v0htU2WyqwNBcfSG1+AH9iB4LDd_tH1GN604rCyrahwbyw@mail.gmail.com>
References: <CA+icZUV0Mxu+fvrmpJmnDjLmxpSd83hDM5od0_1kw4gEm5aaEw@mail.gmail.com>
	<573B4C2A.4010205@intel.com>
	<CA+icZUVXffgzNBAMHUdzHzX3pSDm8j=Uq3CAK8zVqsdT0UunNw@mail.gmail.com>
	<573BA6C6.901@intel.com>
	<CA+icZUVotMFEXSJ1BNY72zQfB-L-PJbyR_31LK8Obje7YjNJsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36386 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754277AbcESLyr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 May 2016 07:54:47 -0400
Received: by mail-wm0-f65.google.com with SMTP id w143so20271463wmw.3
        for <linux-pm@vger.kernel.org>; Thu, 19 May 2016 04:54:46 -0700 (PDT)
In-Reply-To: <CA+icZUVotMFEXSJ1BNY72zQfB-L-PJbyR_31LK8Obje7YjNJsA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sedat.dilek@gmail.com
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Thu, May 19, 2016 at 1:04 PM, Sedat Dilek <sedat.dilek@gmail.com> wrote:
> On 5/18/16, Rafael J. Wysocki <rafael.j.wysocki@intel.com> wrote:
>> On 5/18/2016 1:16 AM, Sedat Dilek wrote:
>>> On 5/17/16, Rafael J. Wysocki <rafael.j.wysocki@intel.com> wrote:
>>>> On 5/17/2016 5:30 PM, Sedat Dilek wrote:
>>>>> Hi,
>>>> Hi,
>>>>
>>>> You have a broken address of linux-pm (it leads to nowhere).
>>>>
>>> Grrr, yeah you are right.
>>>
>>>>> I wonder if the Kconfig logic is correct when using
>>>>> CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL=y in combination with
>>>>> intel_pstate driver for X86 architecture
>>>>>
>>>>> The available scaling-governors for intel_pstate are: performance
>>>>> powersave.
>>>>>
>>>>> Only acpi-cpufreq can use the new schedutil governor.
>>>> The right way to say that would be that intel_pstate doesn't work with
>>>> cpufreq governors.
>>>>
>>>> scalling_governor is just used by intel_pstate as an interface for
>>>> choosing the mode it works in and it always uses its own built-in
>>>> "governor".  And BTW, intel_pstate "powersave" is not the same as the
>>>> cpufreq's "powersave" even.
>>>>
>>>>> Shouldn't it be prevented from selecting schedutil governor as default
>>>>> when CONFIG_X86_INTEL_PSTATE=y is set?
>>>> That should apply to "ondemand" too and it doesn't, so no.
>>>>
>>>> "schedutil" is just a regular cpufreq governor and it doesn't care about
>>>> intel_pstate.
>>>>
>>>>> It makes no real sense to me.
>>>>>
>>>>> Ubuntu has in it's kernels CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=y.
>>>>>
>>>>> What are the alternatives?
>>>>> Set CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE=y.
>>>> You can choose every cpufreq governor as the default.  There are 6 of
>>>> then now in the tree.
>>>>
>>>>> BTW, I cannot change my scaling-driver...
>>>>> ...intel_pstate -> acpi-cpufreq...
>>>>>
>>>>> root# for p in policy0 policy1 policy2 policy3 ; do LC_ALL=C echo -n
>>>>> acpi-cpufreq > /sys/devices/system/cpu/cpufreq/${p}/scaling_driver ;
>>>>> done
>>>>>
>>>>> Attached is also a modified /etc/init.d/ondemand script from my
>>>>> Ubuntu/precise AMD64 to use and fallback to schedutil governor.
>>>> No, you can't change the scaling driver this way.
>>>>
>>>> It actually is not possible to change from intel_pstate to anything else
>>>> now.  To run without intel_pstate, you need to add
>>>> "intel_pstate=disable" to the kernel command line.
>>>>
>>> OK, I will try intel_pstate=disable in my k-c-l.
>>>
>>> Is there no way to switch between acpi-cpufreq and intel_pstate on the
>>> fly?
>>
>> No, there's no way to do that ATM.
>>
>>> Did not look in the Kconfig sections...
>>> Can I built both as modules?
>>> Then unload and load the other?
>>
>> No, intel_pstate can't be built as a module.
>>
>
> It's really a pity that I cannot switch on the fly between
> cpufreq/schedutil vs. intel_pstate/x86
> Hmm, I have to read your replies carefully and this topic is still
> confusing for me.
>
> I tried in the meantime "intel_pstate=disable" in my kernel-command-line.
>
> $ dmesg | egrep -i 'intel_pstate|cpufreq|cpuidle|cpu[0-3]'
> [    0.000000] Command line:
> BOOT_IMAGE=/boot/vmlinuz-4.6.0-4-iniza-small
> root=UUID=001AADA61AAD9964 loop=/ubuntu/disks/root.disk ro
> intel_pstate=disable
> [    0.000000] ACPI: SSDT 0x00000000DAFEB000 000804 (v01 PmRef
> Cpu0Ist  00003000 INTL 20061109)
> [    0.000000] Kernel command line:
> BOOT_IMAGE=/boot/vmlinuz-4.6.0-4-iniza-small
> root=UUID=001AADA61AAD9964 loop=/ubuntu/disks/root.disk ro
> intel_pstate=disable
> [    0.003982] CPU0: Thermal monitoring enabled (TM1)
> [    0.075695] smpboot: CPU0: Intel(R) Core(TM) i5-2467M CPU @ 1.60GHz
> (family: 0x6, model: 0x2a, stepping: 0x7)
> [    0.342317] cpuidle: using governor ladder
> [    0.358253] cpuidle: using governor menu
> [    0.422578] ACPI: SSDT 0xFFFF8800D58F9000 000688 (v01 PmRef
> Cpu0Cst  00003001 INTL 20061109)
> [    0.855129] microcode: CPU0 sig=0x206a7, pf=0x10, revision=0x28
> [    0.855157] microcode: CPU1 sig=0x206a7, pf=0x10, revision=0x28
> [    0.855190] microcode: CPU2 sig=0x206a7, pf=0x10, revision=0x28
> [    0.855227] microcode: CPU3 sig=0x206a7, pf=0x10, revision=0x28
> [   85.914640] cpufreq: CPU0: Fast frequency switching not enabled
> [   85.914645] cpufreq: Registered transition notifiers:
> [   85.914702] cpufreq: cpufreq_stat_notifier_trans+0x0/0xc0
> [   85.914948] cpufreq: CPU1: Fast frequency switching not enabled
> [   85.914950] cpufreq: Registered transition notifiers:
> [   85.914954] cpufreq: cpufreq_stat_notifier_trans+0x0/0xc0
> [   85.915093] cpufreq: CPU2: Fast frequency switching not enabled
> [   85.915095] cpufreq: Registered transition notifiers:
> [   85.915099] cpufreq: cpufreq_stat_notifier_trans+0x0/0xc0
> [   85.915188] cpufreq: CPU3: Fast frequency switching not enabled
> [   85.915190] cpufreq: Registered transition notifiers:
> [   85.915193] cpufreq: cpufreq_stat_notifier_trans+0x0/0xc0
>
> Some sysfs-kungfu with acpi-cpufreq/schedutil ...
>
> # LC_ALL=C ls -lR /sys/devices/system/cpu/cpufreq/policy0/
> /sys/devices/system/cpu/cpufreq/policy0/:
> total 0
> -r--r--r-- 1 root root 4096 May 19 12:54 affected_cpus
> -r--r--r-- 1 root root 4096 May 19 12:54 bios_limit
> -r-------- 1 root root 4096 May 19 12:54 cpuinfo_cur_freq
> -r--r--r-- 1 root root 4096 May 19 12:54 cpuinfo_max_freq
> -r--r--r-- 1 root root 4096 May 19 12:54 cpuinfo_min_freq
> -r--r--r-- 1 root root 4096 May 19 12:54 cpuinfo_transition_latency
> -r--r--r-- 1 root root 4096 May 19 12:54 freqdomain_cpus
> -r--r--r-- 1 root root 4096 May 19 12:54 related_cpus
> -r--r--r-- 1 root root 4096 May 19 12:54 scaling_available_frequencies
> -r--r--r-- 1 root root 4096 May 19 12:54 scaling_available_governors
> -r--r--r-- 1 root root 4096 May 19 12:54 scaling_cur_freq
> -r--r--r-- 1 root root 4096 May 19 12:54 scaling_driver
> -rw-r--r-- 1 root root 4096 May 19 11:46 scaling_governor
> -rw-r--r-- 1 root root 4096 May 19 12:54 scaling_max_freq
> -rw-r--r-- 1 root root 4096 May 19 12:54 scaling_min_freq
> -rw-r--r-- 1 root root 4096 May 19 12:54 scaling_setspeed
> drwxr-xr-x 2 root root    0 May 19 12:54 stats
>
> /sys/devices/system/cpu/cpufreq/policy0/stats:
> total 0
> -r--r--r-- 1 root root 4096 May 19 13:00 time_in_state
> -r--r--r-- 1 root root 4096 May 19 13:00 total_trans
> -r--r--r-- 1 root root 4096 May 19 13:00 trans_table
>
> # for p in policy0 policy1 policy2 policy3 ; do LC_ALL=C cat
> /sys/devices/system/cpu/cpufreq/${p}/scaling_driver ; done
> acpi-cpufreq
> acpi-cpufreq
> acpi-cpufreq
> acpi-cpufreq
>
> # for p in policy0 policy1 policy2 policy3 ; do LC_ALL=C cat
> /sys/devices/system/cpu/cpufreq/${p}/scaling_governor ; done
> schedutil
> schedutil
> schedutil
> schedutil
>
> # for p in policy0 policy1 policy2 policy3 ; do LC_ALL=C cat
> /sys/devices/system/cpu/cpufreq/${p}/scaling_available_governors ;
> done
> conservative ondemand userspace powersave schedutil performance
> conservative ondemand userspace powersave schedutil performance
> conservative ondemand userspace powersave schedutil performance
> conservative ondemand userspace powersave schedutil performance
>
> # for p in policy0 policy1 policy2 policy3 ; do LC_ALL=C cat
> /sys/devices/system/cpu/cpufreq/${p}/scaling_available_frequencies ;
> done
> 1601000 1600000 1500000 1400000 1300000 1200000 1100000 1000000 900000 800000
> 1601000 1600000 1500000 1400000 1300000 1200000 1100000 1000000 900000 800000
> 1601000 1600000 1500000 1400000 1300000 1200000 1100000 1000000 900000 800000
> 1601000 1600000 1500000 1400000 1300000 1200000 1100000 1000000 900000 800000
>
> # cat /sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us
> 10000
>
> Just did not found it...
> How do I enable "Fast frequency switching" on my cpu-cores?

It should be enabled automatically by schedutil if acpi-cpufreq is in
use, but the cpufreq_stat module had registered a transition notifier
before and that prevented the fast switching from being enabled.

Is schedutil the default governor in your Kconfig?  If you set that,
it should start before cpufreq_stat is loaded.

The other way to work around it is to unload acpi-cpufreq and
cpufreq_stat and then load the driver again.

I have a plan to rework cpufreq_stat so it doesn't use the notifier,
but that'll take some time to complete.
