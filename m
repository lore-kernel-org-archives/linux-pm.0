From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Fri, 16 Oct 2015 13:19:08 +0000
Message-ID: <bug-103351-137361-JTuFyIsDFd@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54594 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753817AbbJPNTO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 16 Oct 2015 09:19:14 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id BEBB720A74
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 13:19:13 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id B339320A7D
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2015 13:19:11 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #75 from Henrique de Moraes Holschuh <hmh@hmh.eng.br> ---
(In reply to Alexey Dyachenko from comment #73)
> microcode updated early
> pf=0x2
> cpuinfo http://pastebin.com/92EjQxsM

HLE and RTM still enabled.  However, this is microcode 0x12, which we didn't
expect to turn HLE and RTM off anyway from previous reports...

Alexey, maybe you could try microcode 0x13 which Benjan has added to his
experimental branch?  It should not be any more dangerous than microcode 0x12,
as you're using early updates...

-- 
You are receiving this mail because:
You are the assignee for the bug.
