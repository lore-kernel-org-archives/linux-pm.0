From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Tue, 29 Sep 2015 16:49:15 +0000
Message-ID: <bug-103351-137361-bHommLRZwo@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:41407 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935305AbbI2QtU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 29 Sep 2015 12:49:20 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 2BC96206F9
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2015 16:49:19 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 4656A20751
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2015 16:49:17 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

sac <sdfjk40sdnmxyl@mailinator.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |sdfjk40sdnmxyl@mailinator.c
                   |                            |om

--- Comment #17 from sac <sdfjk40sdnmxyl@mailinator.com> ---
Where is Intel on this one? They have a huge QA department and noone tests a
new processor architecture for *nix? I replaced several 5675C (complete
marathon & minidump described on https://www.virtualbox.org/ticket/14641 ), the
whole line is affected and I feel a little uncomfortable that every program can
trigger MCEs on my machine.

So even if we find a workaround here for the Kernel, it would be interesting
what's the long-term solution. Do we have the next FDIV like bug that we see in
the news tomorrow or can Intel fix this with a Microcode update? I assume we
need a new stepping (doubt that the MB vendors can work around, too). However I
was not able to find any place where I can adress & report this to Intel as
well :(

How can we debug this? All workarounds mentioned don't work / were falsified
("processor.max_cstate=0 intel_idle.max_cstate=0 idle=poll", OC-Fixed-Mode from
Phoronix not available on all MBs).

-- 
You are receiving this mail because:
You are the assignee for the bug.
