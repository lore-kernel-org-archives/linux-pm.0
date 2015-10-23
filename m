From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Fri, 23 Oct 2015 12:31:13 +0000
Message-ID: <bug-103351-137361-AK2Tf5xqyI@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52129 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751013AbbJWMbT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 23 Oct 2015 08:31:19 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 95334205DD
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2015 12:31:18 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 58602209C1
	for <linux-pm@vger.kernel.org>; Fri, 23 Oct 2015 12:31:16 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

Carlos Alberto Lopez Perez <clopez@igalia.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |clopez@igalia.com

--- Comment #93 from Carlos Alberto Lopez Perez <clopez@igalia.com> ---
Hi,

I have an i7-5775C on an Asus Z97-P motherboard. I applied the 0x13 microcode:

# dmesg|grep -i microc
[    0.000000] microcode: CPU0 microcode updated early to revision 0x13, date =
2015-08-03
[    0.074647] microcode: CPU1 microcode updated early to revision 0x13, date =
2015-08-03
[    0.092415] microcode: CPU2 microcode updated early to revision 0x13, date =
2015-08-03
[    0.110143] microcode: CPU3 microcode updated early to revision 0x13, date =
2015-08-03
[    0.557526] microcode: CPU0 sig=0x40671, pf=0x2, revision=0x13
[    0.557531] microcode: CPU1 sig=0x40671, pf=0x2, revision=0x13
[    0.557534] microcode: CPU2 sig=0x40671, pf=0x2, revision=0x13
[    0.557538] microcode: CPU3 sig=0x40671, pf=0x2, revision=0x13
[    0.557543] microcode: CPU4 sig=0x40671, pf=0x2, revision=0x13
[    0.557547] microcode: CPU5 sig=0x40671, pf=0x2, revision=0x13
[    0.557552] microcode: CPU6 sig=0x40671, pf=0x2, revision=0x13
[    0.557557] microcode: CPU7 sig=0x40671, pf=0x2, revision=0x13
[    0.557585] microcode: Microcode Update Driver: v2.00
<tigran@aivazian.fsnet.co.uk>, Peter Oruba


TSX is still there :(

# grep ^flags /proc/cpuinfo|head -1
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2
ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch ida arat
epb pln pts dtherm intel_pt tpr_shadow vnmi flexpriority ept vpid fsgsbase
tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm rdseed adx smap xsaveopt

# cpuid | egrep '(HLE|RTM)'|head -2
      HLE hardware lock elision                = true
      RTM: restricted transactional memory     = true

-- 
You are receiving this mail because:
You are the assignee for the bug.
