From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 07 Oct 2015 16:37:44 +0000
Message-ID: <bug-103351-137361-jItOgyur9t@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:42987 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755145AbbJGQhx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Oct 2015 12:37:53 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 2A7CC205EE
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2015 16:37:52 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id 1D27E20741
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2015 16:37:47 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #41 from kernel@benjam.info <kernel@benjam.info> ---
I can confirm on my system that with an "early" microcode update:

[    0.000000] microcode: CPU0 microcode updated early to revision 0x12, date =
2015-06-19
[    0.077976] microcode: CPU1 microcode updated early to revision 0x12, date =
2015-06-19
[    0.095826] microcode: CPU2 microcode updated early to revision 0x12, date =
2015-06-19
[    0.113756] microcode: CPU3 microcode updated early to revision 0x12, date =
2015-06-19
[    0.586568] microcode: CPU0 sig=0x40671, pf=0x2, revision=0x12
[    0.586573] microcode: CPU1 sig=0x40671, pf=0x2, revision=0x12
[    0.586577] microcode: CPU2 sig=0x40671, pf=0x2, revision=0x12
[    0.586582] microcode: CPU3 sig=0x40671, pf=0x2, revision=0x12
[    0.586611] microcode: Microcode Update Driver: v2.00
<tigran@aivazian.fsnet.co.uk>, Peter Oruba

HLE and RTM are still enabled.

I've attached /proc/cpuinfo for my machine. (Sorry for sending two emails, I'm
still trying to grasp bugzilla)

-- 
You are receiving this mail because:
You are the assignee for the bug.
