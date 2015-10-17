From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Sat, 17 Oct 2015 05:03:04 +0000
Message-ID: <bug-103351-137361-BtIqtrCvLw@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48630 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750727AbbJQFDM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sat, 17 Oct 2015 01:03:12 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id E558F2066F
	for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2015 05:03:10 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 0685D2065D
	for <linux-pm@vger.kernel.org>; Sat, 17 Oct 2015 05:03:08 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #83 from Adrienne Cohea <adriennecohea@gmail.com> ---
(In reply to Henrique de Moraes Holschuh from comment #80)
> Adrienne, it could be really helpful if you could tell us more about your
> system, since it has always had RTM disabled, even with microcode 0xd...
> could you tell us what system is it (make, model), and the output of "dmesg
> | grep microcode" and /proc/cpuinfo, please?

Hey, everyone, I'm sorry it took me so long! This issue is important to
everyone. So what follows will be kind of a big dump of information, but I
don't know what all will be meaningful to everyone. So I've got 1) General
information, 2) BIOS-reported information, and 3) dmesg | grep microcode 4) cat
/proc/cpuinfo.

1) General Information
OEM: CyberPowerPC
Model Marketing Name: Fangbook III BX6

2) BIOS-Reported Information

BIOS Version: E16J2ICP.10E
EC Version 16J2ECP1 Ver5.06
CPU: Intel Core i7-5700HQ
Stepping: 40671
Microcode patch: d (Note, before boot...)

3) dmesg | grep microcode

-- on microcode 0xd --
[    0.432493] microcode: CPU0 sig=0x40671, pf=0x20, revision=0xd
[    0.432498] microcode: CPU1 sig=0x40671, pf=0x20, revision=0xd
[    0.432503] microcode: CPU2 sig=0x40671, pf=0x20, revision=0xd
[    0.432508] microcode: CPU3 sig=0x40671, pf=0x20, revision=0xd
[    0.432513] microcode: CPU4 sig=0x40671, pf=0x20, revision=0xd
[    0.432518] microcode: CPU5 sig=0x40671, pf=0x20, revision=0xd
[    0.432522] microcode: CPU6 sig=0x40671, pf=0x20, revision=0xd
[    0.432528] microcode: CPU7 sig=0x40671, pf=0x20, revision=0xd
[    0.432559] microcode: Microcode Update Driver: v2.00
<tigran@aivazian.fsnet.co.uk>, Peter Oruba

-- on microcode 0x12 --
[    0.000000] microcode: CPU0 microcode updated early to revision 0x12, date =
2015-06-19
[    0.076100] microcode: CPU1 microcode updated early to revision 0x12, date =
2015-06-19
[    0.083977] microcode: CPU2 microcode updated early to revision 0x12, date =
2015-06-19
[    0.091894] microcode: CPU3 microcode updated early to revision 0x12, date =
2015-06-19
[    0.434008] microcode: CPU0 sig=0x40671, pf=0x20, revision=0x12
[    0.434014] microcode: CPU1 sig=0x40671, pf=0x20, revision=0x12
[    0.434019] microcode: CPU2 sig=0x40671, pf=0x20, revision=0x12
[    0.434023] microcode: CPU3 sig=0x40671, pf=0x20, revision=0x12
[    0.434028] microcode: CPU4 sig=0x40671, pf=0x20, revision=0x12
[    0.434033] microcode: CPU5 sig=0x40671, pf=0x20, revision=0x12
[    0.434037] microcode: CPU6 sig=0x40671, pf=0x20, revision=0x12
[    0.434043] microcode: CPU7 sig=0x40671, pf=0x20, revision=0x12
[    0.434075] microcode: Microcode Update Driver: v2.00
<tigran@aivazian.fsnet.co.uk>, Peter Oruba

4) cat /proc/cpuinfo (showing CPU 0 only)

-- on microcode 0xd --
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 71
model name    : Intel(R) Core(TM) i7-5700HQ CPU @ 2.70GHz
stepping    : 1
microcode    : 0xd
cpu MHz        : 2113.171
cache size    : 6144 KB
physical id    : 0
siblings    : 8
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
nonstop_tsc a
perfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 fma
cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes
xsave avx f16c rdrand lahf_lm abm 3dnowprefetch ida arat epb pln pts dtherm
intel_pt
tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2
erms invpcid rdseed adx smap xsaveopt
bugs        :
bogomips    : 5389.86
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

-- on microcode 0x12 --
processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 71
model name    : Intel(R) Core(TM) i7-5700HQ CPU @ 2.70GHz
stepping    : 1
microcode    : 0x12
cpu MHz        : 2701.054
cache size    : 6144 KB
physical id    : 0
siblings    : 8
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
nonstop_tsc a
perfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 fma
cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes
xsave avx f16c rdrand lahf_lm abm 3dnowprefetch ida arat epb pln pts dtherm
intel_pt
tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2 smep bmi2
erms invpcid rdseed adx smap xsaveopt
bugs        :
bogomips    : 5390.35
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

When I "diffed" the /proc/cpuinfo outputs I saved off, only differences were in
microcode of course, bogomips, and cpu MHz. The following commands have always
returned no hits for me, even on the 0xd microcode that came stock:

grep flags /proc/cpuinfo | grep tsx
grep flags /proc/cpuinfo | grep rtm
grep flags /proc/cpuinfo | grep hle

If you need other information like the bridge, let me know. Thanks everyone so
much for explaining the problem and providing a workaround. 0x12 works
brilliantly for me.

-- 
You are receiving this mail because:
You are the assignee for the bug.
