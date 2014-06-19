From: Dirk Brandewie <dirk.brandewie@gmail.com>
Subject: Re: Kernel Fails on Acer Aspire E1-510P
Date: Thu, 19 Jun 2014 09:18:42 -0700
Message-ID: <53A30D62.30301@intel.com>
References: <1403120393.5670.0@smtp.gmail.com> <53A20530.2000203@intel.com> <1403133410.17996.3@smtp.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030201050405050404080908"
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:51813 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757704AbaFSQSq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 19 Jun 2014 12:18:46 -0400
In-Reply-To: <1403133410.17996.3@smtp.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Erich Eickmeyer <erich@ericheickmeyer.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
Cc: dirk.j.brandewie@intel.com, stable <stable@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>

This is a multi-part message in MIME format.
--------------030201050405050404080908
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/18/2014 04:16 PM, Erich Eickmeyer wrote:
> Done. Thanks!
>
> Erich
>
> On Wed, Jun 18, 2014 at 2:31 PM, Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> wrote:
>> On 6/18/2014 9:32 PM, Erich Eickmeyer wrote:
>>> Dear Mr. Brandewie, et al,
>>>
>>> I have noticed a kernel bug that causes it to fail to boot on my machine, an
>>> Acer Aspire E1-510P. The following is a transcription of the kernel panic:
>>>
>>
>> Can you please add this information to bug 77951 at bugzilla.kernel.org
>> which is used to track problems with the commit you mention below?
>>
Patch attached to
https://bugzilla.kernel.org/show_bug.cgi?id=77951

The patch fixes the issue on the N2820 in my test system.

--Dirk
>> Rafael
>>
>>
>>>> Disabling lock debugging due to kernel taint
>>>> mce: [Hardware Error]: CPU2: Machine Check Exception: 4 Bank 0:
>>>> b200000430000423
>>>> mce: [Hardware Error]: TSC 365f6dc39e
>>>> mce: [Hardware Error]: PROCESSOR 0:30673 TIME 1402862769 SOCKET 0 APIC 4
>>>> microcode 31a
>>>> mce: [Hardware Error]: Run the above through 'mcelog --ascii'
>>>> mce: [Hardware Error]: CPU3: Machine Check Exception: 4 Bank 0:
>>>> b200000430000423
>>>> mce: [Hardware Error]: TSC 365f6fa2e4
>>>> mce: [Hardware Error]: PROCESSOR 0:30673 TIME 1402862769 SOCKET 0 APIC 6
>>>> microcode 31a
>>>> mce: [Hardware Error]: Run the above through 'mcelog --ascii'
>>>> mce: [Hardware Error]: CPU1: Machine Check Exception: 4 Bank 0:
>>>> b200000010000000
>>>> mce: [Hardware Error]: TSC 365f73e988
>>>> mce: [Hardware Error]: PROCESSOR 0:30673 TIME 1402862769 SOCKET 0 APIC 2
>>>> microcode 31a
>>>> mce: [Hardware Error]: Run the above through 'mcelog --ascii'
>>>> mce: [Hardware Error]: CPU0: Machine Check Exception: 4 Bank 0:
>>>> b200000010000000
>>>> mce: [Hardware Error]: TSC 365f730e28
>>>> mce: [Hardware Error]: PROCESSOR 0:30673 TIME 142862769 SOCKET 0 APIC 0
>>>> microcode 31a
>>>> mce: [Hardware Error]: Run the above through 'mcelog --ascii'
>>>> mce: [Hardware Error]: Machine Check: Processor context corrupt
>>>> Kernel panic - not syncing: Fatal Machine check
>>>> Kernel Offset: 0x0 from 0xffffffff81000000 (relocation range:
>>>> 0xffffffff80000000-0xfffffffff9fffffff)
>>>> Rebooting in 90 seconds..
>>>>
>>>
>>> Kernel bisection points to this commit:
>>>
>>>> dd4c4afb005de0415ea06e3586b017e193c1539e is the first bad commit
>>>> commit dd4c4afb005de0415ea06e3586b017e193c1539e
>>>> Author: Dirk Brandewie <dirk.j.brandewie@intel.com>
>>>> Date: Thu May 8 12:57:23 2014 -0700
>>>>
>>>>     intel_pstate: Set turbo VID for BayTrail
>>>>         commit 21855ff5bcbdd075e1c99772827a84912ab083dd upstream.
>>>>         A documentation update exposed that there is a separate set of VID
>>>>     values that must be used in the turbo/boost P state range. Add
>>>>     enumerating and setting the correct VID for P states in the turbo
>>>>     range.
>>>>         Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
>>>>     Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>>>     Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
>>>>
>>>> :040000 040000 1a207dc8f511b005b02f023f0a4eaf74ee606181
>>>> a503e06ccecb12d7bdf1d8e2d87395d35a4c4ef0 M    drivers
>>>
>>> Bisect log follows:
>>>
>>>> git bisect start
>>>> # good: [7261684765e4411dff5ec5ffbad52f5009a2941b] Linux 3.14.4
>>>> git bisect good 7261684765e4411dff5ec5ffbad52f5009a2941b
>>>> # bad: [a1bc295d7a4be9425bbeecc005d0cd013eb46cea] Linux 3.14.6
>>>> git bisect bad a1bc295d7a4be9425bbeecc005d0cd013eb46cea
>>>> # good: [0b86a50c92e0118117224d57a9b4aa79d33d98b0] hwmon: (emc1403) fix
>>>> inverted store_hyst()
>>>> git bisect good 0b86a50c92e0118117224d57a9b4aa79d33d98b0
>>>> # good: [512a588518fefae5dab75b89b734cfb64e53177b] Input: atkbd - fix
>>>> keyboard not working on some LG laptops
>>>> git bisect good 512a588518fefae5dab75b89b734cfb64e53177b
>>>> # good: [4cf3d5e62ea1868a963f6430eb7e40e46ac7295b] dm crypt: fix cpu hotplug
>>>> crash by removing per-cpu structure
>>>> git bisect good 4cf3d5e62ea1868a963f6430eb7e40e46ac7295b
>>>> # bad: [dd4c4afb005de0415ea06e3586b017e193c1539e] intel_pstate: Set turbo
>>>> VID for BayTrail
>>>> git bisect bad dd4c4afb005de0415ea06e3586b017e193c1539e
>>>> # good: [da33adbd92be1217c55adf3f164b35ff2238fd32] ACPI: Revert "ACPI /
>>>> Battery: Remove battery's proc directory"
>>>> git bisect good da33adbd92be1217c55adf3f164b35ff2238fd32
>>>> # good: [fcbe7574986518eb6896c18804dc77d8dfd879ea] ACPI / TPM: Fix resume
>>>> regression on Chromebooks
>>>> git bisect good fcbe7574986518eb6896c18804dc77d8dfd879ea
>>>> # good: [6a8702825dc2c66c7233c0b5d9b05a4cddec9eca] i2c: rcar: bail out on
>>>> zero length transfers
>>>> git bisect good 6a8702825dc2c66c7233c0b5d9b05a4cddec9eca
>>>> # good: [35493cad041359561d13dfd4c3c0df33cdd5ea4c] i2c: s3c2410: resume race
>>>> fix
>>>> git bisect good 35493cad041359561d13dfd4c3c0df33cdd5ea4c
>>>> # first bad commit: [dd4c4afb005de0415ea06e3586b017e193c1539e] intel_pstate:
>>>> Set turbo VID for BayTrail
>>>
>>> /proc/cpuinfo:
>>>
>>>> processor    : 0
>>>> vendor_id    : GenuineIntel
>>>> cpu family    : 6
>>>> model        : 55
>>>> model name    : Intel(R) Pentium(R) CPU N3520 @ 2.16GHz
>>>> stepping    : 3
>>>> microcode    : 0x320
>>>> cpu MHz        : 498.000
>>>> cache size    : 1024 KB
>>>> physical id    : 0
>>>> siblings    : 4
>>>> core id        : 0
>>>> cpu cores    : 4
>>>> apicid        : 0
>>>> initial apicid    : 0
>>>> fpu        : yes
>>>> fpu_exception    : yes
>>>> cpuid level    : 11
>>>> wp        : yes
>>>> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
>>>> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp
>>>> lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
>>>> aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr
>>>> pdcm sse4_1 sse4_2 movbe popcnt tsc_deadline_timer rdrand lahf_lm
>>>> 3dnowprefetch ida arat epb dtherm tpr_shadow vnmi flexpriority ept vpid
>>>> tsc_adjust smep erms
>>>> bogomips    : 4333.50
>>>> clflush size    : 64
>>>> cache_alignment    : 64
>>>> address sizes    : 36 bits physical, 48 bits virtual
>>>> power management:
>>>>
>>>> processor    : 1
>>>> vendor_id    : GenuineIntel
>>>> cpu family    : 6
>>>> model        : 55
>>>> model name    : Intel(R) Pentium(R) CPU N3520 @ 2.16GHz
>>>> stepping    : 3
>>>> microcode    : 0x320
>>>> cpu MHz        : 1826.000
>>>> cache size    : 1024 KB
>>>> physical id    : 0
>>>> siblings    : 4
>>>> core id        : 1
>>>> cpu cores    : 4
>>>> apicid        : 2
>>>> initial apicid    : 2
>>>> fpu        : yes
>>>> fpu_exception    : yes
>>>> cpuid level    : 11
>>>> wp        : yes
>>>> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
>>>> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp
>>>> lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
>>>> aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr
>>>> pdcm sse4_1 sse4_2 movbe popcnt tsc_deadline_timer rdrand lahf_lm
>>>> 3dnowprefetch ida arat epb dtherm tpr_shadow vnmi flexpriority ept vpid
>>>> tsc_adjust smep erms
>>>> bogomips    : 4333.50
>>>> clflush size    : 64
>>>> cache_alignment    : 64
>>>> address sizes    : 36 bits physical, 48 bits virtual
>>>> power management:
>>>>
>>>> processor    : 2
>>>> vendor_id    : GenuineIntel
>>>> cpu family    : 6
>>>> model        : 55
>>>> model name    : Intel(R) Pentium(R) CPU N3520 @ 2.16GHz
>>>> stepping    : 3
>>>> microcode    : 0x320
>>>> cpu MHz        : 498.000
>>>> cache size    : 1024 KB
>>>> physical id    : 0
>>>> siblings    : 4
>>>> core id        : 2
>>>> cpu cores    : 4
>>>> apicid        : 4
>>>> initial apicid    : 4
>>>> fpu        : yes
>>>> fpu_exception    : yes
>>>> cpuid level    : 11
>>>> wp        : yes
>>>> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
>>>> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp
>>>> lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
>>>> aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr
>>>> pdcm sse4_1 sse4_2 movbe popcnt tsc_deadline_timer rdrand lahf_lm
>>>> 3dnowprefetch ida arat epb dtherm tpr_shadow vnmi flexpriority ept vpid
>>>> tsc_adjust smep erms
>>>> bogomips    : 4333.50
>>>> clflush size    : 64
>>>> cache_alignment    : 64
>>>> address sizes    : 36 bits physical, 48 bits virtual
>>>> power management:
>>>>
>>>> processor    : 3
>>>> vendor_id    : GenuineIntel
>>>> cpu family    : 6
>>>> model        : 55
>>>> model name    : Intel(R) Pentium(R) CPU N3520 @ 2.16GHz
>>>> stepping    : 3
>>>> microcode    : 0x320
>>>> cpu MHz        : 1992.000
>>>> cache size    : 1024 KB
>>>> physical id    : 0
>>>> siblings    : 4
>>>> core id        : 3
>>>> cpu cores    : 4
>>>> apicid        : 6
>>>> initial apicid    : 6
>>>> fpu        : yes
>>>> fpu_exception    : yes
>>>> cpuid level    : 11
>>>> wp        : yes
>>>> flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
>>>> pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx rdtscp
>>>> lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
>>>> aperfmperf pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 cx16 xtpr
>>>> pdcm sse4_1 sse4_2 movbe popcnt tsc_deadline_timer rdrand lahf_lm
>>>> 3dnowprefetch ida arat epb dtherm tpr_shadow vnmi flexpriority ept vpid
>>>> tsc_adjust smep erms
>>>> bogomips    : 4333.50
>>>> clflush size    : 64
>>>> cache_alignment    : 64
>>>> address sizes    : 36 bits physical, 48 bits virtual
>>>> power management:
>>>
>>> Let me know if you need any more information.
>>>
>>> Thanks,
>>> Erich Eickmeyer
>>>
>>>
>>>
>>> -- To unsubscribe from this list: send the line "unsubscribe stable" in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


--------------030201050405050404080908
Content-Type: text/x-diff;
 name="0001-intel_pstate-Fix-setting-VID.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="0001-intel_pstate-Fix-setting-VID.patch"

>From 21188368c19d7191e83b7a6bf9fbee697fdcf026 Mon Sep 17 00:00:00 2001
From: Dirk Brandewie <dirk.j.brandewie@intel.com>
Date: Thu, 19 Jun 2014 07:38:34 -0700
Subject: [PATCH] intel_pstate: Fix setting VID

Commit 21855ff5 intel_pstate: Set turbo VID for BayTrail introduced
setting the turbo VID which is required to prevent a machine check on
some Baytrail SKUs under heavy graphics based workloads.  The
docmumentation update that brought the requirement to light also
changed the bit mask used for enumerating P state and VID values from
0x7f to 0x3f.

This change returns the mask value to 0x7f.

Tested with the Intel NUC DN2820FYK,
BIOS version FYBYT10H.86A.0034.2014.0513.1413 with v3.16-rc1 and
v3.14.8 kernel versions.

Signed-off-by: Dirk Brandewie <dirk.j.brandewie@intel.com>
---
 drivers/cpufreq/intel_pstate.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
index 4e7f492..fe01cff 100644
--- a/drivers/cpufreq/intel_pstate.c
+++ b/drivers/cpufreq/intel_pstate.c
@@ -360,21 +360,21 @@ static int byt_get_min_pstate(void)
 {
 	u64 value;
 	rdmsrl(BYT_RATIOS, value);
-	return (value >> 8) & 0x3F;
+	return (value >> 8) & 0x7F;
 }
 
 static int byt_get_max_pstate(void)
 {
 	u64 value;
 	rdmsrl(BYT_RATIOS, value);
-	return (value >> 16) & 0x3F;
+	return (value >> 16) & 0x7F;
 }
 
 static int byt_get_turbo_pstate(void)
 {
 	u64 value;
 	rdmsrl(BYT_TURBO_RATIOS, value);
-	return value & 0x3F;
+	return value & 0x7F;
 }
 
 static void byt_set_pstate(struct cpudata *cpudata, int pstate)
@@ -408,8 +408,8 @@ static void byt_get_vid(struct cpudata *cpudata)
 
 
 	rdmsrl(BYT_VIDS, value);
-	cpudata->vid.min = int_tofp((value >> 8) & 0x3f);
-	cpudata->vid.max = int_tofp((value >> 16) & 0x3f);
+	cpudata->vid.min = int_tofp((value >> 8) & 0x7f);
+	cpudata->vid.max = int_tofp((value >> 16) & 0x7f);
 	cpudata->vid.ratio = div_fp(
 		cpudata->vid.max - cpudata->vid.min,
 		int_tofp(cpudata->pstate.max_pstate -
-- 
1.9.0


--------------030201050405050404080908--
