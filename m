From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 15 Oct 2015 14:07:04 +0000
Message-ID: <bug-103351-137361-n2cX3OrKAp@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:53653 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753223AbbJOOHP (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 Oct 2015 10:07:15 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id C80362062F
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 14:07:10 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 088D02082D
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 14:07:09 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #69 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---
(In reply to Adrienne Cohea from comment #68)
> I wasn't showing rtm or hle in my flags for /proc/cpuinfo on the microcode
> 0xd (with all of my MCE system halts) or in microcode (0x12) early applied.

Adrienne, can you post the output of:
/proc/cpuinfo
cat /sys/devices/system/cpu/cpu0/microcode/processor_flags    (requires root)?

I'd also appreciate the information above from people that had RTM/HLE enabled
and got it disabled by microcode 0x13 or by microcode 0x12...

> Is it possible the microcode do something else other than just disable
> TSX-NI? (Though, without rtm or hle showing in /proc/cpuinfo, that shouldn't
> have been my problem anyway?)

Yes, it is possible.  We know microcode 0x12 address issues that resulted in
the hangs and MCEs, which appear to be errata BDD86/BDM101.  We don't know for
sure which other errata it works around, and how.

And you're correct that, since your system never advertised HLE or RTM in the
first place, Intel TSX should never be a problem for you.

> All I know is that microcode 0x12 is working just fine.

Indeed we don't really know what microcode 0x13 fixes that microcode 0x12
didn't already fix.

It looked like it was Intel TSX-NI (RTM), but now it looks like it is either
something else, or that there are extra requirements we don't know about to get
Intel TSX-NI disabled.

-- 
You are receiving this mail because:
You are the assignee for the bug.
