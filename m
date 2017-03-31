From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 194963] schedutil governor causes audio problem in game
Date: Fri, 31 Mar 2017 09:00:15 +0000
Message-ID: <bug-194963-137361-yfLBaHEsp8@https.bugzilla.kernel.org/>
References: <bug-194963-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:51376 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752295AbdCaJAU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2017 05:00:20 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 51FD628666
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2017 09:00:19 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id B9B012863A
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2017 09:00:18 +0000 (UTC)
In-Reply-To: <bug-194963-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=194963

--- Comment #21 from Rafael J. Wysocki (rjw@rjwysocki.net) ---
(In reply to John from comment #20)
> Sure that's fine.
> 
> Assuming the patch will be accepted, what governor would you now suggest me
> to use on what will be 4.12?

If it is accepted, there won't be much difference between schedutil and the new
"powersave" algorithm in intel_pstate, so whichever of the two you prefer I
suppose. :-)

> Thank you very much for your super quick help on this!

No problem.

-- 
You are receiving this mail because:
You are the assignee for the bug.
