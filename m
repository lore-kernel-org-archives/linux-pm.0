From: =?UTF-8?Q?J=C3=B6rg_Otte?= <jrg.otte@gmail.com>
Subject: Re: 4.14.0-rc7: cpufreq interface in sysfs removed ?
Date: Thu, 2 Nov 2017 11:24:14 +0100
Message-ID: <CADDKRnAOUsSY4MdkWvgcOGKrvJt3GgFVvbmyhs7opSk8inUUdw@mail.gmail.com>
References: <CADDKRnDjXzSU=toFVH6pYOS9co4rp-hQ8rv6U9zBnChj_bLAvQ@mail.gmail.com>
 <CAJZ5v0gJa0-YRHVhKWE5GeY1D7W0FSPjxSx8UHqCK=wTir3PEw@mail.gmail.com> <CADDKRnAONVofxdoYBOmbuV7gVXwgM8YBTrtG_zX0A_OKvR+hzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-io0-f174.google.com ([209.85.223.174]:45297 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755215AbdKBKYP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 2 Nov 2017 06:24:15 -0400
In-Reply-To: <CADDKRnAONVofxdoYBOmbuV7gVXwgM8YBTrtG_zX0A_OKvR+hzw@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>

2017-11-02 9:37 GMT+01:00 J=C3=B6rg Otte <jrg.otte@gmail.com>:
> 2017-11-01 21:24 GMT+01:00 Rafael J. Wysocki <rafael@kernel.org>:
>> On Wed, Nov 1, 2017 at 6:06 PM, J=C3=B6rg Otte <jrg.otte@gmail.com> wrot=
e:
>>> In 4.14.0-rc7-00009-g287683d cpufreq directory under
>>> /sys/devices/system/cpu/cpufreq
>>> is empty. Also link /sys/devices/system/cpu/cpu0/cpufreq is missing.
>>>
>>> Is this change intentional?
>>
>> Sure not.
>>
>> What's the last good kernel you tested before this one?
> Unfortunately I had a disk crash and I was offline in last weeks.
> This is the first kernel with everything new installed on new disk.
> So I don't remember exactly last good kernel. For sure it was  4.14.0-rc1=
.
>
> Maybe I made a mistake with the kernel configuration ?
>
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=3Dy
> CONFIG_CPU_FREQ_GOV_ATTR_SET=3Dy
> CONFIG_CPU_FREQ_GOV_COMMON=3Dy
> CONFIG_CPU_FREQ_STAT=3Dy
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_ONDEMAND is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_CONSERVATIVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
> CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
> # CONFIG_CPU_FREQ_GOV_USERSPACE is not set
> CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy
> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy
>
> #
> # CPU frequency scaling drivers
> #
> CONFIG_X86_INTEL_PSTATE=3Dy
> # CONFIG_X86_PCC_CPUFREQ is not set
> # CONFIG_X86_ACPI_CPUFREQ is not set
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> # CONFIG_X86_P4_CLOCKMOD is not set
>
>
> Just discovered:
> If intel_pstate is active everythin looks fine.
> If intel_pstate is disabled (intel_pstate=3Ddisable) the directories are
> empty again.
>
> Processor are:
> jojo@fichte:~$ cat /proc/cpuinfo
> processor       : 0 .. 3
> vendor_id       : GenuineIntel
> cpu family      : 6
> model           : 60
> model name      : Intel(R) Core(TM) i5-4200M CPU @ 2.50GHz
> stepping        : 3
> microcode       : 0x22
> cpu MHz         : 2494.433
> cache size      : 3072 KB
> physical id     : 0
> siblings        : 4
> core id         : 0
> cpu cores       : 2
> apicid          : 0
> initial apicid  : 0
> fpu             : yes
> fpu_exception   : yes
> cpuid level     : 13
> wp              : yes
> flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge
> mca cmov pat pse36 clflush dts acpi mmx fxsr
> sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm constant_tsc
> arch_perfmon pebs bts rep_good nopl xtopology nons
> top_tsc cpuid aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est
> tm2 ssse3 sdbg fma cx16 xtpr pdcm pcid sse4_1
> sse4_2 movbe popcnt tsc_deadline_timer aes xsave avx f16c rdrand
> lahf_lm abm cpuid_fault epb tpr_shadow vnmi flexpr
> iority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid
> xsaveopt dtherm ida arat pln pts
> bugs            :
> bogomips        : 4988.86
> clflush size    : 64
> cache_alignment : 64
> address sizes   : 39 bits physical, 48 bits virtual
> power management:
>

>> # CONFIG_X86_ACPI_CPUFREQ is not set

OK, that's was it! My bad. Sorry for the noise.

Thanks,
J=C3=B6rg
