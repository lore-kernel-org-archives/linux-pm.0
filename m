From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Fri, 16 Oct 2015 15:43:16 +0000
Message-ID: <bug-103351-137361-ljblnFDHtx@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41182 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753369AbbJPPnW (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Oct 2015 11:43:22 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 23EC920A8A
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 15:43:21 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 521FD20A83
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 15:43:19 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

Dimman <dimmuxx@yahoo.se> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |dimmuxx@yahoo.se

--- Comment #76 from Dimman <dimmuxx@yahoo.se> ---
My stats:

[    0.000000] DMI: ASUS All Series/Z97-PRO(Wi-Fi ac)/USB 3.1, BIOS 2401
04/27/2015

[    0.000000] microcode: CPU0 microcode updated early to revision 0x13, date =
2015-08-03
[    0.081596] microcode: CPU1 microcode updated early to revision 0x13, date =
2015-08-03
[    0.099552] microcode: CPU2 microcode updated early to revision 0x13, date =
2015-08-03
[    0.117352] microcode: CPU3 microcode updated early to revision 0x13, date =
2015-08-03
[    0.500798] microcode: CPU0 sig=0x40671, pf=0x2, revision=0x13
[    0.500802] microcode: CPU1 sig=0x40671, pf=0x2, revision=0x13
[    0.500807] microcode: CPU2 sig=0x40671, pf=0x2, revision=0x13
[    0.500811] microcode: CPU3 sig=0x40671, pf=0x2, revision=0x13
[    0.500816] microcode: CPU4 sig=0x40671, pf=0x2, revision=0x13
[    0.500820] microcode: CPU5 sig=0x40671, pf=0x2, revision=0x13
[    0.500824] microcode: CPU6 sig=0x40671, pf=0x2, revision=0x13
[    0.500829] microcode: CPU7 sig=0x40671, pf=0x2, revision=0x13
[    0.500856] microcode: Microcode Update Driver: v2.00
<tigran@aivazian.fsnet.co.uk>, Peter Oruba

processor    : 7
vendor_id    : GenuineIntel
cpu family    : 6
model        : 71
model name    : Intel(R) Core(TM) i7-5775C CPU @ 3.30GHz
stepping    : 1
microcode    : 0x13
cpu MHz        : 3263.132
cache size    : 6144 KB
physical id    : 0
siblings    : 8
core id        : 3
cpu cores    : 4
apicid        : 7
initial apicid    : 7
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
epb pln pts dtherm intel_pt tpr_shadow vnmi flexpriority ept vpid fsgsbase
tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm rdseed adx smap xsaveopt
bugs        :
bogomips    : 6595.67
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

So HLE and RTM remains for me in 0x13. I ripped the microcode myself from a msi
bios file. (E16J1IMS.110.zip)

-- 
You are receiving this mail because:
You are the assignee for the bug.
