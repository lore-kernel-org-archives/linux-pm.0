From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Tue, 29 Sep 2015 00:47:28 +0000
Message-ID: <bug-103351-137361-VbJUITwH50@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40603 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754098AbbI2Arc (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 28 Sep 2015 20:47:32 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 82D48206F0
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2015 00:47:31 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 0712320726
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2015 00:47:30 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

matthew.dewitt@gmail.com changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |matthew.dewitt@gmail.com

--- Comment #16 from matthew.dewitt@gmail.com ---
This is definitely a GCC/GLIBC issue/trigger:

- Slackware 14.1 w/ 4.2.1 kernel from kernel.org
- No issues.
- Compiles and runs without issue.

- Slackware 14.1 Stable (with/without 4.2.1, else stock 3.x 14.1 kernel huge.s)
- 'slackpkg upgrade-all' (exclude kernel, update slackpkg first, etc)
- Machine crashes half way throught the update (update of GCC?)

- Slackware -Current (as of 09/28/15)
- Machine is unstable, crashes during any large compile (recompile kernel)

- Fedora 22 - Stable. No issues. GCC not installed.

- Fedora 23 BETA (As of 09/28/15) does not even finish install from Live CD.
Crashes.

System:

i7 5700HQ

-- 
You are receiving this mail because:
You are the assignee for the bug.
