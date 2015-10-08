From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Thu, 08 Oct 2015 23:21:59 +0000
Message-ID: <bug-103351-137361-CwOfN6eedN@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:54444 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752922AbbJHXWF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 8 Oct 2015 19:22:05 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id C966320814
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2015 23:22:03 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id A539520808
	for <linux-pm@vger.kernel.org>; Thu,  8 Oct 2015 23:22:02 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #52 from kernel@benjam.info <kernel@benjam.info> ---
(In reply to matthew.dewitt from comment #51)
> 
> How do I get 0x13??

I think the 5700HQ updates include microcode version 0x13, but the UEFI update
I pulled the 5675C and 5775C updates from was older than the 5700HQ update.
It's also possible that the different processors use different version numbers.

However, looking at the microcode signatures, the last 5x75C microcode update
is dated 2015-06-19, while the last 5700HQ microcode update is dated
2015-03-27, so I don't really know. I really wish Intel would tell us
something.

If anyone can find a 5675C or 5775C motherboard that installs a microcode
version past 0x12 for the 5675C or 5775C, I'd be happy to extract the microcode
updates and add them to the Github repository.

-- 
You are receiving this mail because:
You are the assignee for the bug.
