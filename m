From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] Machine check exception on Broadwell quad-core with
 SpeedStep enabled
Date: Wed, 14 Oct 2015 21:16:45 +0000
Message-ID: <bug-103351-137361-jhsGgQFu4v@https.bugzilla.kernel.org/>
References: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:50419 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932329AbbJNVQt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 14 Oct 2015 17:16:49 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 4EA11209DD
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2015 21:16:48 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
	by mail.kernel.org (Postfix) with ESMTP id 66C37209D7
	for <linux-pm@vger.kernel.org>; Wed, 14 Oct 2015 21:16:47 +0000 (UTC)
In-Reply-To: <bug-103351-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

--- Comment #62 from saunders.52@wright.edu ---

(In reply to Fredrik Atmer from comment #61)
> I thought I had posted this earlier, but here goes.
> 
> Don't go ruin my day again... Yes, rtm is in there. Everything I've run so
> far seem to be working. Is there a stress test for threading or some
> suggested program I can run for testing? I tried running some sysbench test,
> but I have no idea what I am looking for. They all bogged down the system
> completely, but everything returned to normal after they finished.

That's so weird given my MSI laptop with UEFI-supplied microcode 13 doesn't
have rtm listed. Huh.

-- 
You are receiving this mail because:
You are the assignee for the bug.
