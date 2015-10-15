From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 15 Oct 2015 13:18:26 +0000
Message-ID: <bug-103351-137361-c7uXLjoGXl@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49153 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774AbbJONSc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 Oct 2015 09:18:32 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 831E520841
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 13:18:31 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 288462087F
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 13:18:29 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #66 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---
> I've installed this persistently on my machine, and verified that it applies
> at early boot. My cpu flags with 0x13 are:
> 
> ---
> fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36
> clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm
> constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
> aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3
> fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer
> aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch ida arat pln pts dtherm
> intel_pt tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle
> avx2 smep bmi2 erms invpcid rtm rdseed adx smap xsaveopt
> ---
> 
> Which is exactly the same as it was with 0x12.

Assuming the microcode was *really* applied by the early microcode loader
(please double-check):

This is really strange, since it was reported to remove the rtm and hle flags
on some processors, and the processor errata text is very specific that Intel
TSX is NOT supposed to be available (even when it is, in fact, reported to be
available by CPUID).  Argh.  Conflicting/incomplete information, and
conflicting runtime behavior.  Thank you, Intel!

Maybe this thing is related to a boot-locked MSR?  The microcode might change
the default on power-up, but still respect writes to such a MSR by the BIOS. 
That would mean you really want a BIOS update to get everything right.

So, it boils down to whether people with microcode 0x13 usually have RTM
enabled or not, and whether glibc with lock elision works fine on heavy
threaded workloads for those that do have RTM enabled on microcode 0x13...

-- 
You are receiving this mail because:
You are the assignee for the bug.
