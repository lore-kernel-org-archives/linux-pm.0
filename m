From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 07 Oct 2015 16:54:16 +0000
Message-ID: <bug-103351-137361-ACyHLgb8t0@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:43934 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755148AbbJGQyU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 12:54:20 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 40F942073B
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2015 16:54:19 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 6B51A20769
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2015 16:54:18 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #42 from Jonas Platte <linux@jonasplatte.de> ---
Henrique: Yes, I can confirm that the kernel log shows the microcode update:

[jonas@jp-desktop ~]$ dmesg | grep early
[    0.000000] microcode: CPU0 microcode updated early to revision 0x12, date =
2015-06-19
[    0.073758] microcode: CPU1 microcode updated early to revision 0x12, date =
2015-06-19
[    0.084952] microcode: CPU2 microcode updated early to revision 0x12, date =
2015-06-19
[    0.096162] microcode: CPU3 microcode updated early to revision 0x12, date =
2015-06-19

I don't know why you contacted me personally to test your glibc patch, but I
don't think I can do that either way as I never experienced glibc SIGILL or
SIGSEGV crashes, only kernel panics.

-- 
You are receiving this mail because:
You are the assignee for the bug.
