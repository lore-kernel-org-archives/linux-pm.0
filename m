From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Tue, 03 Nov 2015 13:46:44 +0000
Message-ID: <bug-103351-137361-oJDgxDABTT@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58224 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754504AbbKCNqv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 3 Nov 2015 08:46:51 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id F353A20741
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2015 13:46:48 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 70A0220708
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2015 13:46:47 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #96 from yjcoshc@gmail.com ---
I am using i5-5700HQ with MSI GE62 2QD laptop. I have updated the new BIOS from
MSI official website. It seems hle and rtm is disabled successfully and
everything works well now.

Run dmesg |grep GE62 shows:
[    0.000000] DMI: Micro-Star International Co., Ltd. GE62 2QD/MS-16J2, BIOS
E16J2IMS.114 09/23/2015

microcode:
microcode: CPU0 sig=0x40671, pf=0x20, revision=0x13

/proc/cpuinfo:
processor       : 7
vendor_id       : GenuineIntel
cpu family      : 6
model           : 71
model name      : Intel(R) Core(TM) i7-5700HQ CPU @ 2.70GHz
stepping        : 1
microcode       : 0x13
cpu MHz         : 2700.105
cache size      : 6144 KB
physical id     : 0
siblings        : 8
core id         : 3
cpu cores       : 4
apicid          : 7
initial apicid  : 7
fpu             : yes
fpu_exception   : yes
cpuid level     : 20
wp              : yes
flags           : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2
ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch ida arat
epb pln pts dtherm intel_pt tpr_shadow vnmi flexpriority ept vpid fsgsbase
tsc_adjust bmi1 avx2 smep bmi2 erms invpcid rdseed adx smap xsaveopt
bugs            :
bogomips        : 5387.54
clflush size    : 64
cache_alignment : 64
address sizes   : 39 bits physical, 48 bits virtual

-- 
You are receiving this mail because:
You are the assignee for the bug.
