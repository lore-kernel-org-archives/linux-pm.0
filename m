From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Mon, 28 Sep 2015 14:23:47 +0000
Message-ID: <bug-103351-137361-x9ykjYFuJo@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:32868 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933806AbbI1OXu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Sep 2015 10:23:50 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 2FF8B20760
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2015 14:23:49 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 295A920723
	for <linux-pm@vger.kernel.org>; Mon, 28 Sep 2015 14:23:48 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

firefox.cat-fox@gmx.net changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |firefox.cat-fox@gmx.net

--- Comment #14 from firefox.cat-fox@gmx.net ---
Hello,

same on Schenker XMG P505 with Intel i-5700HQ. Tried with Kubuntu 15.04 and
15.10-beta1. Kernel version is: 4.1.0-3.3 Ubuntu, from upstream Version 4.1.3

"processor.max_cstate=0 intel_idle.max_cstate=0 idle=poll" can be used as
workaround but the fan is quiet noisy and nervous.

Speedstep cannot be switched off in bios.

best regards.

-- 
You are receiving this mail because:
You are the assignee for the bug.
