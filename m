From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Tue, 03 Nov 2015 12:51:26 +0000
Message-ID: <bug-103351-137361-amRs772NrG@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:55206 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751201AbbKCMve (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 3 Nov 2015 07:51:34 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B1365206F1
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2015 12:51:33 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 3DDA020735
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2015 12:51:30 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #95 from Jinserk Baik <jinserk.baik@gmail.com> ---
I'm using i5-5675C with ASUS H97I-PLUS mobo. I've found ASUS update new BIOS
for this mobo, ver 2605, on their official site. I've update this new BIOS, and
found that microcode is not early updated any more according to the dmesg as
follows:

$ dmesg |grep microcode
[    1.414138] microcode: CPU0 sig=0x40671, pf=0x2, revision=0x13
[    1.414151] microcode: CPU1 sig=0x40671, pf=0x2, revision=0x13
[    1.414166] microcode: CPU2 sig=0x40671, pf=0x2, revision=0x13
[    1.414184] microcode: CPU3 sig=0x40671, pf=0x2, revision=0x13
[    1.414269] microcode: Microcode Update Driver: v2.00
<tigran@aivazian.fsnet.co.uk>, Peter Oruba


but still hle and rtm is enabled in /proc/cpuinfo:
flags        : fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov
pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb
rdtscp lm constant_tsc arch_perfmon pebs bts rep_good nopl xtopology
nonstop_tsc aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2
ssse3 fma cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt
tsc_deadline_timer aes xsave avx f16c rdrand lahf_lm abm 3dnowprefetch arat epb
pln pts dtherm intel_pt tpr_shadow vnmi flexpriority ept vpid fsgsbase
tsc_adjust bmi1 hle avx2 smep bmi2 erms invpcid rtm rdseed adx smap xsaveopt

-- 
You are receiving this mail because:
You are the assignee for the bug.
