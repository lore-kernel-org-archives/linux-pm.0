From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 14 Oct 2015 21:31:01 +0000
Message-ID: <bug-103351-137361-5HQrbD0A3q@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51425 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932785AbbJNVbJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Oct 2015 17:31:09 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 95AC020528
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2015 21:31:08 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id CEEE420660
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2015 21:31:03 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #63 from Fredrik Atmer <fredrik+kernel@atmer.se> ---
I just tried the experimental branch and it works for me. I'm at 0x13 =)

Although the --persist-debian still doesn't persist. I'm back at 0xd after a
reboot. This is my output from install.sh. I don't know if update-initramfs
looks in the wrong place or what?


*** Initial microcode version information:
microcode    : 0x13
microcode    : 0x13
microcode    : 0x13
microcode    : 0x13

*** Applying microcode updates
*** Setting up persistence
FYI: You can safely ignore warnings about files already existing.
/usr/sbin/iucode-tool: 06-47-01: cannot write to, or create file: File exists
*** Running update-initramfs
update-initramfs: Generating /boot/initrd.img-3.19.0-30-generic

*** Current microcode version information:
microcode    : 0x13
microcode    : 0x13
microcode    : 0x13
microcode    : 0x13

No errors encountered.
If the microcode version did not change, no update has been applied.

-- 
You are receiving this mail because:
You are the assignee for the bug.
