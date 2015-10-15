From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 15 Oct 2015 17:04:05 +0000
Message-ID: <bug-103351-137361-1DdHYG34DZ@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43882 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752486AbbJOREM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 Oct 2015 13:04:12 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 8690720795
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 17:04:11 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 3A01B2082D
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 17:04:10 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #70 from saunders.52@wright.edu ---
(In reply to Henrique de Moraes Holschuh from comment #69)
> Adrienne, can you post the output of:
> /proc/cpuinfo
> cat /sys/devices/system/cpu/cpu0/microcode/processor_flags    (requires
> root)?
> 
> I'd also appreciate the information above from people that had RTM/HLE
> enabled and got it disabled by microcode 0x13 or by microcode 0x12...

I have an MSI laptop (PX60-2QD w/ i7 5700hq) with BIOS provided microcode 13.

The entire output of the processor flags file for me is "0x20".

/proc/cpuinfo is
https://www.dropbox.com/s/dfjs8xbypx20vqm/msi-px60-2qd-microcode13-cpuinfo.txt?dl=0
flags list: "fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat
pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp
lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 fma
cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes
xsave avx f16c rdrand lahf_lm abm 3dnowprefetch ida arat epb pln pts dtherm
intel_pt tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 avx2
smep bmi2 erms invpcid rdseed adx smap xsaveopt"

-- 
You are receiving this mail because:
You are the assignee for the bug.
