From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 194963] schedutil governor causes audio problem in game
Date: Thu, 23 Mar 2017 13:07:48 +0000
Message-ID: <bug-194963-137361-vGxfr1kDsw@https.bugzilla.kernel.org/>
References: <bug-194963-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:50082 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932370AbdCWNHt (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 09:07:49 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 76CD227D5E
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 13:07:48 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 44BF727D5E
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 13:07:48 +0000 (UTC)
In-Reply-To: <bug-194963-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=194963

--- Comment #1 from John (john.ettedgui@gmail.com) ---
I just tried a few more tests:

1) pstate's powersave: no issue (but it also doesn't scale for me...)

2) cpufreq's powersave: I have more the issue than not (in my original posting
it was maybe once every 2 seconds or so, in this case it's much more frequent).

3) cpufreq's conservative: better than powersave but still no good.

4) cpufreq's ondemand: all good as expected.

Based on that I'm guessing it's scaling related.

-- 
You are receiving this mail because:
You are the assignee for the bug.
