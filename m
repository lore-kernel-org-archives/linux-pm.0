From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Fri, 16 Oct 2015 11:51:28 +0000
Message-ID: <bug-103351-137361-r61earQC3e@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46793 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753801AbbJPLve (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Oct 2015 07:51:34 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id A159120A7E
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 11:51:32 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 86C2A20A77
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 11:51:31 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

Jinserk Baik <jinserk.baik@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |jinserk.baik@gmail.com

--- Comment #74 from Jinserk Baik <jinserk.baik@gmail.com> ---
Hello, nice to know this thread.

My system is i5-5675C, with ASUS H97I-PLUS. I'm using Debian strech (testing),
applied to the experimental microcode 0x13. Here is my status:

---
$ dmesg | grep microcode
[    0.000000] microcode: CPU0 microcode updated early to revision 0x13, date =
2015-08-03
[    0.174403] microcode: CPU1 microcode updated early to revision 0x13, date =
2015-08-03
[    0.200376] microcode: CPU2 microcode updated early to revision 0x13, date =
2015-08-03
[    0.226294] microcode: CPU3 microcode updated early to revision 0x13, date =
2015-08-03
[    1.377455] microcode: CPU0 sig=0x40671, pf=0x2, revision=0x13
[    1.377467] microcode: CPU1 sig=0x40671, pf=0x2, revision=0x13
[    1.377485] microcode: CPU2 sig=0x40671, pf=0x2, revision=0x13
[    1.377503] microcode: CPU3 sig=0x40671, pf=0x2, revision=0x13
[    1.377591] microcode: Microcode Update Driver: v2.00
<tigran@aivazian.fsnet.co.uk>, Peter Oruba
---
$ cat proc/cpuinfo
....
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2
ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch arat epb
pln pts dtherm intel_pt tpr_shadow vnmi flexpriority ept vpid fsgsbase
tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm rdseed adx smap xsaveopt
...
---

It seems to be hle and rtm enabled.

-- 
You are receiving this mail because:
You are the assignee for the bug.
