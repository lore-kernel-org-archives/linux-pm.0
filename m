From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 177161] CPU frequencies in /proc/cpuinfo aren't dynamically
 updated
Date: Tue, 11 Oct 2016 00:02:22 +0000
Message-ID: <bug-177161-137361-2EpRBF8nbw@https.bugzilla.kernel.org/>
References: <bug-177161-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:39034 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752354AbcJKAC0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Oct 2016 20:02:26 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 6759120320
        for <linux-pm@vger.kernel.org>; Tue, 11 Oct 2016 00:02:24 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
        by mail.kernel.org (Postfix) with ESMTP id 763E3202F8
        for <linux-pm@vger.kernel.org>; Tue, 11 Oct 2016 00:02:22 +0000 (UTC)
In-Reply-To: <bug-177161-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=177161

Len Brown <lenb@kernel.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |lenb@kernel.org
           Assignee|linux-pm@vger.kernel.org    |lenb@kernel.org

--- Comment #3 from Len Brown <lenb@kernel.org> ---
I proposed a patch to make /proc/cpuinfo accurate several months ago.
Red Hat didn't like it, arguing that changing values is a support issue.
So there was not agreement on what to do here -- let's go find out if
it changed by mistake...

-- 
You are receiving this mail because:
You are the assignee for the bug.
