From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 14 Oct 2015 20:50:59 +0000
Message-ID: <bug-103351-137361-Zx5Ip0qu4D@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:47294 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753432AbbJNUvF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Oct 2015 16:51:05 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id C349720876
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2015 20:51:03 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 70E13209C6
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2015 20:51:02 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #59 from kernel@benjam.info <kernel@benjam.info> ---
Great news! I tried some other MSI UEFI updates, and managed to extract a
microcode update that brings my 5675C up to version 0x13! Since the update came
from a laptop UEFI update, and since the 5775C, 5675C, and 5700HQ all have the
same signature (https://bugzilla.kernel.org/show_bug.cgi?id=103351#c53), I'm
presuming that this means this one update should work for everyone.

To be safe, I've added the new update in a separate "experimental" branch. Once
people can independently confirm it works on all the different types of
processors, I'll merge it to master.

To use the update in the experimental branch, simply run:

---
$ git clone https://github.com/bgw/bdw-ucode-update-tool.git
$ cd bdw-ucode-update-tool
$ git checkout experimental
$ ./install.sh
---

I've installed this persistently on my machine, and verified that it applies at
early boot. My cpu flags with 0x13 are:

---
fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov pat pse36 clflush
dts acpi mmx fxsr sse sse2 ss ht tm pbe syscall nx pdpe1gb rdtscp lm
constant_tsc arch_perfmon pebs bts rep_good nopl xtopology nonstop_tsc
aperfmperf eagerfpu pni pclmulqdq dtes64 monitor ds_cpl vmx est tm2 ssse3 fma
cx16 xtpr pdcm pcid sse4_1 sse4_2 x2apic movbe popcnt tsc_deadline_timer aes
xsave avx f16c rdrand lahf_lm abm 3dnowprefetch ida arat pln pts dtherm
intel_pt tpr_shadow vnmi flexpriority ept vpid fsgsbase tsc_adjust bmi1 hle
avx2 smep bmi2 erms invpcid rtm rdseed adx smap xsaveopt
---

Which is exactly the same as it was with 0x12.

-- 
You are receiving this mail because:
You are the assignee for the bug.
