From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Tue, 01 Sep 2015 02:08:03 +0000
Message-ID: <bug-103351-137361-Ociam3lKwP@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40695 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753606AbbIACIH (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 31 Aug 2015 22:08:07 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B0ADC20695
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2015 02:08:05 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 1C1522068E
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2015 02:08:04 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #5 from Ziyue Yang <yzylivezh@hotmail.com> ---
(In reply to Ziyue Yang from comment #3)

> 
> Same problem here with MSI GE62 2QE Apache Pro.
> I tried both debian8.1 and Ubuntu15.04 on the real machine and received same
> kernel panics. Updating kernels to 4.2 doesn't help.
> I also tried those two systems in VMware workstation under Windows 10 and
> ended up in BSODs saying "MACHINE_CHECK_EXCEPTIONS". 
> I then tried to use debian in VMware at runlevel=3. It seems to be stable. I
> don't know why. 
> 
> I'm going to try your way to get a stable system. Will reply if anything new
> discovered.

"processor.max_cstate=0 intel_idle.max_cstate=0 idle=poll" option did work for
me. MCEs
are caught in the kern.log but system didn't crash.

Since idle=poll actually produces much more heat, I tried to disable speedstep
and remove
the idle=poll option. Seems stable as well. Notice that this time there are no
more MCE records
in kern.log at all.

-- 
You are receiving this mail because:
You are the assignee for the bug.
