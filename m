From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 14 Oct 2015 21:14:49 +0000
Message-ID: <bug-103351-137361-kmNYMcrzku@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50123 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754162AbbJNVOy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Oct 2015 17:14:54 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 868AF209D4
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2015 21:14:53 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 92A3B209D9
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2015 21:14:51 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #61 from Fredrik Atmer <fredrik+kernel@atmer.se> ---
I thought I had posted this earlier, but here goes.

Don't go ruin my day again... Yes, rtm is in there. Everything I've run so far
seem to be working. Is there a stress test for threading or some suggested
program I can run for testing? I tried running some sysbench test, but I have
no idea what I am looking for. They all bogged down the system completely, but
everything returned to normal after they finished.

processor    : 0
vendor_id    : GenuineIntel
cpu family    : 6
model        : 71
model name    : Intel(R) Core(TM) i5-5675C CPU @ 3.10GHz
stepping    : 1
microcode    : 0x12
cpu MHz        : 1399.601
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
bogomips    : 6185.82
clflush size    : 64
cache_alignment    : 64
address sizes    : 39 bits physical, 48 bits virtual
power management:

-- 
You are receiving this mail because:
You are the assignee for the bug.
