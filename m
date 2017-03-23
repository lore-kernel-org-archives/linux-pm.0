From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 194963] schedutil governor causes audio problem in game
Date: Thu, 23 Mar 2017 15:11:37 +0000
Message-ID: <bug-194963-137361-qZvqGJwMKK@https.bugzilla.kernel.org/>
References: <bug-194963-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:37168 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751807AbdCWPLm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 11:11:42 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 4CF1E28475
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 15:11:41 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 6B0DB28475
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 15:11:40 +0000 (UTC)
In-Reply-To: <bug-194963-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=194963

Rafael J. Wysocki (rjw@rjwysocki.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO
                 CC|                            |rjw@rjwysocki.net

--- Comment #3 from Rafael J. Wysocki (rjw@rjwysocki.net) ---
It also would be good to test this patch:

https://patchwork.kernel.org/patch/9637821/

and maybe also this one:

https://patchwork.kernel.org/patch/9640261/

to see if it improves things for the intel_pstate "powersave" on that machine.

-- 
You are receiving this mail because:
You are the assignee for the bug.
