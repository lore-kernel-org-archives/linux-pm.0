From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Tue, 29 Sep 2015 18:43:14 +0000
Message-ID: <bug-103351-137361-7l8Tbxyvq5@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:48793 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S964820AbbI2SnT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 29 Sep 2015 14:43:19 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id C96F4206C7
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2015 18:43:17 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id C58FA206EF
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2015 18:43:16 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #21 from Adrienne Cohea <adriennecohea@gmail.com> ---
(In reply to sac from comment #17)
> Where is Intel on this one? They have a huge QA department and noone tests a
> new processor architecture for *nix? I replaced several 5675C (complete
> marathon & minidump described on https://www.virtualbox.org/ticket/14641 ),
> the whole line is affected and I feel a little uncomfortable that every
> program can trigger MCEs on my machine.
> 
> So even if we find a workaround here for the Kernel, it would be interesting
> what's the long-term solution. Do we have the next FDIV like bug that we see
> in the news tomorrow or can Intel fix this with a Microcode update? I assume
> we need a new stepping (doubt that the MB vendors can work around, too).
> However I was not able to find any place where I can adress & report this to
> Intel as well :(
> 
> How can we debug this? All workarounds mentioned don't work / were falsified
> ("processor.max_cstate=0 intel_idle.max_cstate=0 idle=poll", OC-Fixed-Mode
> from Phoronix not available on all MBs).

Please do not claim things like the workarounds are falsified. It's fine to say
that they didn't work for *you*, but it is *absolutely* not true that the
workaround doesn't work in *general*, and it's unhelpful to kernel maintainers
to make positive assertions about other users' experiences that aren't true.

I have a Core i7-5700HQ with my CyberPowerPC Fangbook, and I was getting MCEs
starting pretty much ever since I first booted from the Arch Linux Live USB,
under various mysterious circumstances. As I mentioned earlier, I have 100%
ability to reproduce the lockup: basically compile any larger project. The
error is the same every time: MCA Internal Timer Error.

I used the kernel parameters you are saying are "falsified", and I have not
experienced any MCEs at all, since then, and I have placed the system under
considerable load and various different use cases.

I don't know how it's possible to get much more scientific than that. The
parameters in the original bug report do in fact work, at least for some users.

-- 
You are receiving this mail because:
You are the assignee for the bug.
