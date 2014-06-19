From: Erich Eickmeyer <erich@ericheickmeyer.com>
Subject: Re: Kernel Fails on Acer Aspire E1-510P
Date: Thu, 19 Jun 2014 23:08:59 -0007
Message-ID: <1403219759.4867.1@smtp.gmail.com>
References: <1403120393.5670.0@smtp.gmail.com> <53A20530.2000203@intel.com>
	<1403133410.17996.3@smtp.gmail.com> <53A30D62.30301@intel.com>
	<1403201320.14789.0@smtp.gmail.com> <1403219700.4867.0@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f41.google.com ([209.85.220.41]:50123 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965528AbaFSXQE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Jun 2014 19:16:04 -0400
Received: by mail-pa0-f41.google.com with SMTP id fb1so2389101pad.14
        for <linux-pm@vger.kernel.org>; Thu, 19 Jun 2014 16:16:02 -0700 (PDT)
In-Reply-To: <1403219700.4867.0@smtp.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dirk Brandewie <dirk.brandewie@gmail.com>
Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, dirk.j.brandewie@intel.com, stable <stable@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

I can now confirm successful test of patch on my N3520 system.

Erich

> On Thu, Jun 19, 2014 at 11:08 AM, Erich Eickmeyer 
> <erich@ericheickmeyer.com> wrote:
>> I will test this on my N3520 system.
>> 
>> Erich
>> 
>> On Thu, Jun 19, 2014 at 9:18 AM, Dirk Brandewie 
>> <dirk.brandewie@gmail.com> wrote:
>>> On 06/18/2014 04:16 PM, Erich Eickmeyer wrote:
>>>> Done. Thanks!
>>>> 
>>>> Erich
>>>> 
>>>> On Wed, Jun 18, 2014 at 2:31 PM, Rafael J. Wysocki 
>>>> <rafael.j.wysocki@intel.com>
>>>> wrote:
>>>>> On 6/18/2014 9:32 PM, Erich Eickmeyer wrote:
>>>>>> Dear Mr. Brandewie, et al,
>>>>>> 
>>>>>> I have noticed a kernel bug that causes it to fail to boot on my 
>>>>>> machine, an
>>>>>> Acer Aspire E1-510P. The following is a transcription of the 
>>>>>> kernel panic:
>>>>>> 
>>>>> 
>>>>> Can you please add this information to bug 77951 at 
>>>>> bugzilla.kernel.org
>>>>> which is used to track problems with the commit you mention below?
>>>>> 
>>> Patch attached to
>>> https://bugzilla.kernel.org/show_bug.cgi?id=77951
>>> 
>>> The patch fixes the issue on the N2820 in my test system.
>>> 
>>> --Dirk
>>>>> Rafael
>>>>> 
>>>>> 
>>>>>>> Disabling lock debugging due to kernel taint
>>>>>>> mce: [Hardware Error]: CPU2: Machine Check Exception: 4 Bank 0:
>>>>>>> b200000430000423
>>>>>>> mce: [Hardware Error]: TSC 365f6dc39e
>>>>>>> mce: [Hardware Error]: PROCESSOR 0:30673 TIME 1402862769 SOCKET 
>>>>>>> 0 APIC 4
>>>>>>> microcode 31a
>>>>>>> mce: [Hardware Error]: Run the above through 'mcelog --ascii'
>>>>>>> mce: [Hardware Error]: CPU3: Machine Check Exception: 4 Bank 0:
>>>>>>> b200000430000423
>>>>>>> mce: [Hardware Error]: TSC 365f6fa2e4
>>>>>>> mce: [Hardware Error]: PROCESSOR 0:30673 TIME 1402862769 SOCKET 
>>>>>>> 0 APIC 6
>>>>>>> microcode 31a
>>>>>>> mce: [Hardware Error]: Run the above through 'mcelog --ascii'
>>>>>>> mce: [Hardware Error]: CPU1: Machine Check Exception: 4 Bank 0:
>>>>>>> b200000010000000
>>>>>>> mce: [Hardware Error]: TSC 365f73e988
>>>>>>> mce: [Hardware Error]: PROCESSOR 0:30673 TIME 1402862769 SOCKET 
>>>>>>> 0 APIC 2
>>>>>>> microcode 31a
>>>>>>> mce: [Hardware Error]: Run the above through 'mcelog --ascii'
>>>>>>> mce: [Hardware Error]: CPU0: Machine Check Exception: 4 Bank 0:
>>>>>>> b200000010000000
>>>>>>> mce: [Hardware Error]: TSC 365f730e28
>>>>>>> mce: [Hardware Error]: PROCESSOR 0:30673 TIME 142862769 SOCKET 
>>>>>>> 0 APIC 0
>>>>>>> microcode 31a
>>>>>>> mce: [Hardware Error]: Run the above through 'mcelog --ascii'
>>>>>>> mce: [Hardware Error]: Machine Check: Processor context corrupt
>>>>>>> Kernel panic - not syncing: Fatal Machine check
>>>>>>> Kernel Offset: 0x0 from 0xffffffff81000000 (relocation range:
>>>>>>> 0xffffffff80000000-0xfffffffff9fffffff)
>>>>>>> Rebooting in 90 seconds..
>>>>>>> 
>>>>>> 
>>>>>> Kernel bisection points to this commit:
>>>>>> 
>>>>>>> dd4c4afb005de0415ea06e3586b017e193c1539e is the first bad commit
>>>>>>> commit dd4c4afb005de0415ea06e3586b017e193c1539e
>>>>>>> Author: Dirk Brandewie <dirk.j.brandewie@intel.com>
>>>>>>> Date: Thu May 8 12:57:23 2014 -0700
>>>>>>> 
>>>>>>>     intel_pstate: Set turbo VID for BayTrail
>>>>>>>         commit 21855ff5bcbdd075e1c99772827a84912ab083dd 
>>>>>>> upstream.
>>>>>>>         A documentation update exposed that there is a separate 
>>>>>>> set of VID
>>>>>>>     values that must be used in the turbo/boost P state range. 
>>>>>>> Add
>>>>>>>     enumerating and setting the correct VID for P states in the 
>>>>>>> turbo
>>>>>>>     range.
>>>>>>>         Signed-off-by: Dirk Brandewie 
>>>>>>> <dirk.j.brandewie@intel.com>
>>>>>>>     Signed-off-by: Rafael J. Wysocki 
>>>>>>> <rafael.j.wysocki@intel.com>
>>>>>>>     Signed-off-by: Greg Kroah-Hartman 
>>>>>>> <gregkh@linuxfoundation.org>
>>>>>>> 
>>>>>>> :040000 040000 1a207dc8f511b005b02f023f0a4eaf74ee606181
>>>>>>> a503e06ccecb12d7bdf1d8e2d87395d35a4c4ef0 M    drivers
>>>>>> 
>>>>>> Bisect log follows:
>>>>>> 
>>>>>>> git bisect start
>>>>>>> # good: [7261684765e4411dff5ec5ffbad52f5009a2941b] Linux 3.14.4
>>>>>>> git bisect good 7261684765e4411dff5ec5ffbad52f5009a2941b
>>>>>>> # bad: [a1bc295d7a4be9425bbeecc005d0cd013eb46cea] Linux 3.14.6
>>>>>>> git bisect bad a1bc295d7a4be9425bbeecc005d0cd013eb46cea
>>>>>>> # good: [0b86a50c92e0118117224d57a9b4aa79d33d98b0] hwmon: 
>>>>>>> (emc1403) fix
>>>>>>> inverted store_hyst()
>>>>>>> git bisect good 0b86a50c92e0118117224d57a9b4aa79d33d98b0
>>>>>>> # good: [512a588518fefae5dab75b89b734cfb64e53177b] Input: atkbd 
>>>>>>> - fix
>>>>>>> keyboard not working on some LG laptops
>>>>>>> git bisect good 512a588518fefae5dab75b89b734cfb64e53177b
>>>>>>> # good: [4cf3d5e62ea1868a963f6430eb7e40e46ac7295b] dm crypt: 
>>>>>>> fix cpu hotplug
>>>>>>> crash by removing per-cpu structure
>>>>>>> git bisect good 4cf3d5e62ea1868a963f6430eb7e40e46ac7295b
>>>>>>> # bad: [dd4c4afb005de0415ea06e3586b017e193c1539e] intel_pstate: 
>>>>>>> Set turbo
>>>>>>> VID for BayTrail
>>>>>>> git bisect bad dd4c4afb005de0415ea06e3586b017e193c1539e
>>>>>>> # good: [da33adbd92be1217c55adf3f164b35ff2238fd32] ACPI: Revert 
>>>>>>> "ACPI /
>>>>>>> Battery: Remove battery's proc directory"
>>>>>>> git bisect good da33adbd92be1217c55adf3f164b35ff2238fd32
>>>>>>> # good: [fcbe7574986518eb6896c18804dc77d8dfd879ea] ACPI / TPM: 
>>>>>>> Fix resume
>>>>>>> regression on Chromebooks
>>>>>>> git bisect good fcbe7574986518eb6896c18804dc77d8dfd879ea
>>>>>>> # good: [6a8702825dc2c66c7233c0b5d9b05a4cddec9eca] i2c: rcar: 
>>>>>>> bail out on
>>>>>>> zero length transfers
>>>>>>> git bisect good 6a8702825dc2c66c7233c0b5d9b05a4cddec9eca
>>>>>>> # good: [35493cad041359561d13dfd4c3c0df33cdd5ea4c] i2c: 
>>>>>>> s3c2410: resume race
>>>>>>> fix
>>>>>>> git bisect good 35493cad041359561d13dfd4c3c0df33cdd5ea4c
>>>>>>> # first bad commit: [dd4c4afb005de0415ea06e3586b017e193c1539e] 
>>>>>>> intel_pstate:
>>>>>>> Set turbo VID for BayTrail
>>>>>> 
>>>>>> /proc/cpuinfo:
>>>>>> 
>>>>>>> processor    : 0
>>>>>>> vendor_id    : GenuineIntel
>>>>>>> cpu family    : 6
>>>>>>> model        : 55
>>>>>>> model name    : Intel(R) Pentium(R) CPU N3520 @ 2.16GHz
>>>>>>> stepping    : 3
>>>>>>> microcode    : 0x320
>>>>>>> cpu MHz        : 498.000
>>>>>>> cache size    : 1024 KB
>>>>>>> physical id    : 0
>>>>>>> siblings    : 4
>>>>>>> core id        : 0
>>>>>>> cpu cores    : 4
>>>>>>> apicid        : 0
>>>>>>> initial apicid    : 0
>>>>>>> fpu        : yes
>>>>>>> fpu_exception    : yes
>>>>>>> cpuid level    : 11
>>>>>>> wp        : yes
>>>>>>> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr 
>>>>>>> pge mca cmov
>>>>>>> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe 
>>>>>>> syscall nx rdtscp
>>>>>>> lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
>>>>>>> nonstop_tsc
>>>>>>> aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 
>>>>>>> ssse3 cx16 xtpr
>>>>>>> pdcm sse4_1 sse4_2 movbe popcnt tsc_deadline_timer rdrand 
>>>>>>> lahf_lm
>>>>>>> 3dnowprefetch ida arat epb dtherm tpr_shadow vnmi flexpriority 
>>>>>>> ept vpid
>>>>>>> tsc_adjust smep erms
>>>>>>> bogomips    : 4333.50
>>>>>>> clflush size    : 64
>>>>>>> cache_alignment    : 64
>>>>>>> address sizes    : 36 bits physical, 48 bits virtual
>>>>>>> power management:
>>>>>>> 
>>>>>>> processor    : 1
>>>>>>> vendor_id    : GenuineIntel
>>>>>>> cpu family    : 6
>>>>>>> model        : 55
>>>>>>> model name    : Intel(R) Pentium(R) CPU N3520 @ 2.16GHz
>>>>>>> stepping    : 3
>>>>>>> microcode    : 0x320
>>>>>>> cpu MHz        : 1826.000
>>>>>>> cache size    : 1024 KB
>>>>>>> physical id    : 0
>>>>>>> siblings    : 4
>>>>>>> core id        : 1
>>>>>>> cpu cores    : 4
>>>>>>> apicid        : 2
>>>>>>> initial apicid    : 2
>>>>>>> fpu        : yes
>>>>>>> fpu_exception    : yes
>>>>>>> cpuid level    : 11
>>>>>>> wp        : yes
>>>>>>> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr 
>>>>>>> pge mca cmov
>>>>>>> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe 
>>>>>>> syscall nx rdtscp
>>>>>>> lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
>>>>>>> nonstop_tsc
>>>>>>> aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 
>>>>>>> ssse3 cx16 xtpr
>>>>>>> pdcm sse4_1 sse4_2 movbe popcnt tsc_deadline_timer rdrand 
>>>>>>> lahf_lm
>>>>>>> 3dnowprefetch ida arat epb dtherm tpr_shadow vnmi flexpriority 
>>>>>>> ept vpid
>>>>>>> tsc_adjust smep erms
>>>>>>> bogomips    : 4333.50
>>>>>>> clflush size    : 64
>>>>>>> cache_alignment    : 64
>>>>>>> address sizes    : 36 bits physical, 48 bits virtual
>>>>>>> power management:
>>>>>>> 
>>>>>>> processor    : 2
>>>>>>> vendor_id    : GenuineIntel
>>>>>>> cpu family    : 6
>>>>>>> model        : 55
>>>>>>> model name    : Intel(R) Pentium(R) CPU N3520 @ 2.16GHz
>>>>>>> stepping    : 3
>>>>>>> microcode    : 0x320
>>>>>>> cpu MHz        : 498.000
>>>>>>> cache size    : 1024 KB
>>>>>>> physical id    : 0
>>>>>>> siblings    : 4
>>>>>>> core id        : 2
>>>>>>> cpu cores    : 4
>>>>>>> apicid        : 4
>>>>>>> initial apicid    : 4
>>>>>>> fpu        : yes
>>>>>>> fpu_exception    : yes
>>>>>>> cpuid level    : 11
>>>>>>> wp        : yes
>>>>>>> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr 
>>>>>>> pge mca cmov
>>>>>>> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe 
>>>>>>> syscall nx rdtscp
>>>>>>> lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
>>>>>>> nonstop_tsc
>>>>>>> aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 
>>>>>>> ssse3 cx16 xtpr
>>>>>>> pdcm sse4_1 sse4_2 movbe popcnt tsc_deadline_timer rdrand 
>>>>>>> lahf_lm
>>>>>>> 3dnowprefetch ida arat epb dtherm tpr_shadow vnmi flexpriority 
>>>>>>> ept vpid
>>>>>>> tsc_adjust smep erms
>>>>>>> bogomips    : 4333.50
>>>>>>> clflush size    : 64
>>>>>>> cache_alignment    : 64
>>>>>>> address sizes    : 36 bits physical, 48 bits virtual
>>>>>>> power management:
>>>>>>> 
>>>>>>> processor    : 3
>>>>>>> vendor_id    : GenuineIntel
>>>>>>> cpu family    : 6
>>>>>>> model        : 55
>>>>>>> model name    : Intel(R) Pentium(R) CPU N3520 @ 2.16GHz
>>>>>>> stepping    : 3
>>>>>>> microcode    : 0x320
>>>>>>> cpu MHz        : 1992.000
>>>>>>> cache size    : 1024 KB
>>>>>>> physical id    : 0
>>>>>>> siblings    : 4
>>>>>>> core id        : 3
>>>>>>> cpu cores    : 4
>>>>>>> apicid        : 6
>>>>>>> initial apicid    : 6
>>>>>>> fpu        : yes
>>>>>>> fpu_exception    : yes
>>>>>>> cpuid level    : 11
>>>>>>> wp        : yes
>>>>>>> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr 
>>>>>>> pge mca cmov
>>>>>>> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe 
>>>>>>> syscall nx rdtscp
>>>>>>> lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology 
>>>>>>> nonstop_tsc
>>>>>>> aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 
>>>>>>> ssse3 cx16 xtpr
>>>>>>> pdcm sse4_1 sse4_2 movbe popcnt tsc_deadline_timer rdrand 
>>>>>>> lahf_lm
>>>>>>> 3dnowprefetch ida arat epb dtherm tpr_shadow vnmi flexpriority 
>>>>>>> ept vpid
>>>>>>> tsc_adjust smep erms
>>>>>>> bogomips    : 4333.50
>>>>>>> clflush size    : 64
>>>>>>> cache_alignment    : 64
>>>>>>> address sizes    : 36 bits physical, 48 bits virtual
>>>>>>> power management:
>>>>>> 
>>>>>> Let me know if you need any more information.
>>>>>> 
>>>>>> Thanks,
>>>>>> Erich Eickmeyer
>>>>>> 
>>>>>> 
>>>>>> 
>>>>>> -- To unsubscribe from this list: send the line "unsubscribe 
>>>>>> stable" in
>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>> More majordomo info at  
>>>>>> http://vger.kernel.org/majordomo-info.html
>>>> 

