From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Sat, 26 Sep 2015 03:03:32 +0000
Message-ID: <bug-103351-137361-SlVQuSgyk6@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35952 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932119AbbIZDDg (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 25 Sep 2015 23:03:36 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id B6D9020921
	for <linux-pm@vger.kernel.org>; Sat, 26 Sep 2015 03:03:35 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 0628A2092A
	for <linux-pm@vger.kernel.org>; Sat, 26 Sep 2015 03:03:33 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

Adrienne Cohea <adriennecohea@gmail.com> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |adriennecohea@gmail.com

--- Comment #13 from Adrienne Cohea <adriennecohea@gmail.com> ---
This sounds a lot like what I am experiencing. I am on 4.1.6-1-ARCH #1 SMP
PREEMPT.

I have 100% ability to reproduce the lock up by trying to compile metasploit.
Everything I see in the systemd journal for the mcelog unit is of the form

Processor context corrupt
MCA: Internal Timer error
STATUS be00000000800400 MCGSTATUS 0

The CPU number on which the error occurs is generally 0 but not always.

I see a lot of MCGCAP lines that are the same across MCEs:

MCGCAP 1000c09 APICID 0 SOCKETID 0

APICID 0 (12 of 14 times)
APICID 2 (once)
APICID 4 (once)

Using "processor.max_cstate=0 intel_idle.max_cstate=0 idle=poll" worked for me
so far (but I only have a couple hours of up time; however, I'm now able to
compile stuff without the MCEs that have been happening with extreme regularity
during compiles).

I have not changed any settings in the BIOS, so SpeedStep is still on.

-- 
You are receiving this mail because:
You are the assignee for the bug.
