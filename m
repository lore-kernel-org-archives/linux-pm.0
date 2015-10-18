From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Sun, 18 Oct 2015 18:23:14 +0000
Message-ID: <bug-103351-137361-lawsHMbqnN@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39618 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751393AbbJRSXU (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 18 Oct 2015 14:23:20 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id E15A52064F
	for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2015 18:23:17 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id E856820641
	for <linux-pm@vger.kernel.org>; Sun, 18 Oct 2015 18:23:16 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #84 from Fredrik Atmer <fredrik+kernel@atmer.se> ---
I just did the craziest (probably) thing ever! 

(As per sac's comment https://bugzilla.kernel.org/show_bug.cgi?id=103351#c55)

I read out my BIOS with flashrom, updated the microcode in it to 0x13 using the
UFU tool to (in a virtual XP machine), flashed the new BIOS file back using
flashrom, and now I believe I'm actually running 0x13 "natively".

That was probably reckless, don't do it! I just had to tell someone who can
appreciate the beauty of it.. =D

-- 
You are receiving this mail because:
You are the assignee for the bug.
