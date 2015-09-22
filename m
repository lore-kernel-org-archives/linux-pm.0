From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Tue, 22 Sep 2015 10:48:08 +0000
Message-ID: <bug-103351-137361-cRhMAOQEqf@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54793 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757838AbbIVKsL (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 22 Sep 2015 06:48:11 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 9136520763
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2015 10:48:10 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id A1A1A20762
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2015 10:48:09 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

Alexey Dyachenko <adotfive@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |adotfive@gmail.com

--- Comment #12 from Alexey Dyachenko <adotfive@gmail.com> ---
i5-5675C is affected as well (with GA-Z97-HD3 rev2.0 F9; Arch Linux). I have
disabled Turbo Boost, as BIOS doesn't have setting for SpeedStep, C1E,C3,C6/C7
were also disabled, however the issue still occurs.

"processor.max_cstate=0 intel_idle.max_cstate=0 idle=poll" does not help.

Speaking of instructions these CPUs are indeed affected by HLE bug

Program received signal SIGSEGV, Segmentation fault.
0x00007ffff6b877e0 in __lll_unlock_elision () from /usr/lib/libpthread.so.0

Thinking its some instruction that causes MCE, I recompiled glibc without
elision lock and with -march=ivybridge and installed linux-ck-ivybridge,
however machine still hangs under load (like compiling glibc).

-- 
You are receiving this mail because:
You are the assignee for the bug.
