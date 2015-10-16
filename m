From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Fri, 16 Oct 2015 21:09:35 +0000
Message-ID: <bug-103351-137361-u7ZHe0fRno@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35352 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932400AbbJPVJk (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Oct 2015 17:09:40 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 11D5B209BA
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 21:09:39 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id D00CC209A4
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 21:09:37 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #82 from Fredrik Atmer <fredrik+kernel@atmer.se> ---
Finally back home again. I see others have beaten me to it. 

$ dmesg | grep microcode
[    0.000000] CPU0 microcode updated early to revision 0x13, date = 2015-08-03
[    0.080692] CPU1 microcode updated early to revision 0x13, date = 2015-08-03
[    0.098581] CPU2 microcode updated early to revision 0x13, date = 2015-08-03
[    0.116531] CPU3 microcode updated early to revision 0x13, date = 2015-08-03
[    0.492240] microcode: CPU0 sig=0x40671, pf=0x2, revision=0x13
[    0.492245] microcode: CPU1 sig=0x40671, pf=0x2, revision=0x13
[    0.492249] microcode: CPU2 sig=0x40671, pf=0x2, revision=0x13
[    0.492253] microcode: CPU3 sig=0x40671, pf=0x2, revision=0x13
[    0.492282] microcode: Microcode Update Driver: v2.00
<tigran@aivazian.fsnet.co.uk>, Peter Oruba

$ cat /proc/cpuinfo
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 71
model name    : Intel(R) Core(TM) i5-5675C CPU @ 3.10GHz
stepping    : 1
microcode    : 0x13
cpu MHz        : 3044.296
cache size    : 4096 KB
physical id    : 0
siblings    : 4
core id        : 0
cpu cores    : 4
apicid        : 0
initial apicid    : 0
fpu        : yes
fpu_exception    : yes
cpuid level    : 20
wp        : yes
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2
ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch ida arat
epb pln pts dtherm tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust
bmi1 hle avx2 smep bmi2 erms invpcid rtm rdseed adx smap xsaveopt
bugs        :
bogomips    : 6186.17
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

-- 
You are receiving this mail because:
You are the assignee for the bug.
