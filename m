From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 194963] schedutil governor causes audio problem in game
Date: Fri, 24 Mar 2017 00:40:53 +0000
Message-ID: <bug-194963-137361-zooxmJmNr7@https.bugzilla.kernel.org/>
References: <bug-194963-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:40648 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S933766AbdCXAwF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 20:52:05 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 473F728474
        for <linux-pm@vger.kernel.org>; Fri, 24 Mar 2017 00:40:54 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 03B6628474
        for <linux-pm@vger.kernel.org>; Fri, 24 Mar 2017 00:40:54 +0000 (UTC)
In-Reply-To: <bug-194963-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=194963

--- Comment #6 from John (john.ettedgui@gmail.com) ---
The schedutil patch didn't seem to change anything, though the 4th hunk of
cpufreq_schedutil.c didn't apply and I had to do it manually, so it is possible
I messed up somewhere (I copied/pasted it so it's unlikely, but I thought it'd
be better to say it).

As for pstate, I think that's the first time I've seen my CPU scaling on
pstate's powersave. I've tried the game, and I think, but not sure, that when
it started the sound cracked for just a bit, maybe before the CPU scaled up
enough? After that no issue, and I verified the CPU was at its maximum
frequency. When I quit the game, the CPU scaled down to its minimum frequency
within 2 seconds. Pstate's performance still doesn't scale, is it expected? I
thought on pstate both would.

Thank you!

-- 
You are receiving this mail because:
You are the assignee for the bug.
