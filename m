From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 08 Oct 2015 11:47:32 +0000
Message-ID: <bug-103351-137361-TOV549Xjxn@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40135 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756407AbbJHLrh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 8 Oct 2015 07:47:37 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 02B012061C
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2015 11:47:36 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 2959F20617
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2015 11:47:35 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #46 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---
Alexey,

Thank you very much for confirming that TSX-NI in Broadwell-H is still broken
*and active* on microcode 0x12, dated 2015-06-19.

I highly recommend that you deploy early microcode updates on your system. 
When you use the late microcode update mode, you are still at risk of hitting
errata that would be fixed by the microcode update.

Also, when you don't do an "early" update, the kernel won't know about any
"processor feature" flags change caused by the microcode update (yes, this is a
known bug): it will continue to operate with the set of flags it got from the
boot microcode for all intents and purposes (including, but not limited to
/proc/cpuinfo "flags" information being stale).

I'd also start pestering the motherboard vendor for firmware updates at least
every two months, or something to that effect :-(

-- 
You are receiving this mail because:
You are the assignee for the bug.
