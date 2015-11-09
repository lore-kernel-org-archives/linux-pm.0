From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Mon, 09 Nov 2015 19:05:29 +0000
Message-ID: <bug-103351-137361-aUl5UDtGld@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:58717 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751353AbbKITFj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 9 Nov 2015 14:05:39 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id D3FBA205FF
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2015 19:05:37 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 9C17D20802
	for <linux-pm@vger.kernel.org>; Mon,  9 Nov 2015 19:05:32 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #99 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---
Intel has issued a new public microcode update datafile, which should address
the broadwell MCE errata.

I will update and upload the Debian "intel-microcode" package in Debian
unstable tonight, Canonical will either use that for Ubuntu, or update
directly.  Eventually, these updates will be backported to our stable branches.

The new Intel microcode update package modifies these microcodes (compared to
the update package from 2015-01-21):

+ sig 0x000306a9, pf mask 0x12, 2015-02-26, rev 0x001c, size 12288
+ sig 0x000306c3, pf mask 0x32, 2015-08-13, rev 0x001e, size 21504
+ sig 0x000306d4, pf mask 0xc0, 2015-09-11, rev 0x0022, size 16384
+ sig 0x000306f2, pf mask 0x6f, 2015-08-10, rev 0x0036, size 30720
+ sig 0x000306f4, pf mask 0x80, 2015-07-17, rev 0x0009, size 14336
+ sig 0x00040651, pf mask 0x72, 2015-08-13, rev 0x001d, size 20480
+ sig 0x00040671, pf mask 0x22, 2015-08-03, rev 0x0013, size 11264

If anyone has any sort of problems with these microcode updates, it would be
really helpful if you report it to the distro's bugtracker (or even here,
although really, this is way off-topic for the kernel bugzilla :-p).

BTW: it looks like Skylake users need to get up-to-date BIOSes from their
vendors: they're still not covered by the public microcode update
distribution...

-- 
You are receiving this mail because:
You are the assignee for the bug.
