From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 198601] Conservative governor is broken in 4.14.14
Date: Mon, 29 Jan 2018 07:49:31 +0000
Message-ID: <bug-198601-137361-Pb2Kl4m0kd@https.bugzilla.kernel.org/>
References: <bug-198601-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:52792 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751042AbeA2Hte (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jan 2018 02:49:34 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 6FD6228874
        for <linux-pm@vger.kernel.org>; Mon, 29 Jan 2018 07:49:34 +0000 (UTC)
In-Reply-To: <bug-198601-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=198601

Artem S. Tashkinov (t.artem@mailcity.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEEDINFO                    |ASSIGNED

--- Comment #3 from Artem S. Tashkinov (t.artem@mailcity.com) ---
(In reply to Viresh Kumar from comment #2)
> Try this commit (already in Linus's master), we solved this problem sometime
> back
> 
> 56026645e2b6 cpufreq: governor: Ensure sufficiently large sampling intervals
> 
> Not sure if your problem is a new one though.

I can confirm that this patch fixes the issue.

Please submit it for 4.14.16.

-- 
You are receiving this mail because:
You are the assignee for the bug.
