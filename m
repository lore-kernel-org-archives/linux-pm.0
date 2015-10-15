From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 15 Oct 2015 13:29:28 +0000
Message-ID: <bug-103351-137361-GoAITnK7E2@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50378 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750774AbbJON3c (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 15 Oct 2015 09:29:32 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id BFB142075F
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 13:29:31 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 09B6020891
	for <linux-pm@vger.kernel.org>; Thu, 15 Oct 2015 13:29:30 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #68 from Adrienne Cohea <adriennecohea@gmail.com> ---
I wasn't showing rtm or hle in my flags for /proc/cpuinfo on the microcode 0xd
(with all of my MCE system halts) or in microcode (0x12) early applied. Is it
possible the microcode do something else other than just disable TSX-NI?
(Though, without rtm or hle showing in /proc/cpuinfo, that shouldn't have been
my problem anyway?)

All I know is that microcode 0x12 is working just fine.

-- 
You are receiving this mail because:
You are the assignee for the bug.
