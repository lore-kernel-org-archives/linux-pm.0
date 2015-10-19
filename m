From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Mon, 19 Oct 2015 10:16:23 +0000
Message-ID: <bug-103351-137361-UfhUnPaQ31@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50009 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753377AbbJSKQ1 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 19 Oct 2015 06:16:27 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 79AF3206F3
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2015 10:16:26 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 8CD8C20788
	for <linux-pm@vger.kernel.org>; Mon, 19 Oct 2015 10:16:25 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #85 from Alexey Dyachenko <adotfive@gmail.com> ---
(In reply to Henrique de Moraes Holschuh from comment #75)
> (In reply to Alexey Dyachenko from comment #73)
> > microcode updated early
> > pf=0x2
> > cpuinfo http://pastebin.com/92EjQxsM
> 
> HLE and RTM still enabled.  However, this is microcode 0x12, which we didn't
> expect to turn HLE and RTM off anyway from previous reports...
> 
> Alexey, maybe you could try microcode 0x13 which Benjan has added to his
> experimental branch?  It should not be any more dangerous than microcode
> 0x12, as you're using early updates...

I did not know there was an 0x13 microcode for my CPU. Well, I tried it and
cpuinfo diff shows no difference at all, only current MHz and microcode version
are different, obviously.

On a releated note, I have been experiencing random instant reboots while
running 0x12, it may be related to some other errata triggering or maybe other
hardware is faulty, anyway, nothing can be captured in logs. I'll see how 0x13
fares.

-- 
You are receiving this mail because:
You are the assignee for the bug.
