From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 194963] schedutil governor causes audio problem in game
Date: Fri, 31 Mar 2017 08:45:10 +0000
Message-ID: <bug-194963-137361-Li3Go8KRx1@https.bugzilla.kernel.org/>
References: <bug-194963-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:48870 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751257AbdCaIpS (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 31 Mar 2017 04:45:18 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id D4A9E28610
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2017 08:45:16 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 9243928610
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2017 08:45:15 +0000 (UTC)
In-Reply-To: <bug-194963-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=194963

Rafael J. Wysocki (rjw@rjwysocki.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEEDINFO                    |RESOLVED
         Resolution|---                         |PATCH_ALREADY_AVAILABLE

--- Comment #19 from Rafael J. Wysocki (rjw@rjwysocki.net) ---
What it practically means is that the problem reported by you may be hard to
reproduce. :-)

Anyway, my conclusion is that the patch from comment #11 (or alternatively
https://patchwork.kernel.org/patch/9655173/) helps, so let me resolve this
report accordingly.

Whether or not the patch is accepted upstream, I'm not sure at this point,
because it may lead to increased energy consumption on other systems in
principle.

-- 
You are receiving this mail because:
You are the assignee for the bug.
