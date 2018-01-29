From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 198601] Conservative governor is broken in 4.14.14
Date: Mon, 29 Jan 2018 07:11:47 +0000
Message-ID: <bug-198601-137361-h1SQVvxmvR@https.bugzilla.kernel.org/>
References: <bug-198601-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:50216 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751042AbeA2HLu (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jan 2018 02:11:50 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id C0D7928742
        for <linux-pm@vger.kernel.org>; Mon, 29 Jan 2018 07:11:49 +0000 (UTC)
In-Reply-To: <bug-198601-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=198601

Viresh Kumar (viresh.kumar@linaro.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |viresh.kumar@linaro.org

--- Comment #2 from Viresh Kumar (viresh.kumar@linaro.org) ---
Try this commit (already in Linus's master), we solved this problem sometime
back

56026645e2b6 cpufreq: governor: Ensure sufficiently large sampling intervals

Not sure if your problem is a new one though.

-- 
You are receiving this mail because:
You are the assignee for the bug.
