From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 194963] schedutil governor causes audio problem in game
Date: Thu, 30 Mar 2017 03:32:16 +0000
Message-ID: <bug-194963-137361-DNDP3qstRz@https.bugzilla.kernel.org/>
References: <bug-194963-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:44912 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932113AbdC3DcS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2017 23:32:18 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 6FB0928482
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2017 03:32:17 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 237E526E39
        for <linux-pm@vger.kernel.org>; Thu, 30 Mar 2017 03:32:17 +0000 (UTC)
In-Reply-To: <bug-194963-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=194963

--- Comment #16 from John (john.ettedgui@gmail.com) ---
Well I've had the same issue on ondemand, then I switched to performance to see
and it was all fine, I switched back again to schedutil and since then it's
been fine. So maybe it was a heavy service running in the background at that
time or something like that...

Based on that, I will retract comment 14.

I will test it with intel_pstate=passive and report.

-- 
You are receiving this mail because:
You are the assignee for the bug.
