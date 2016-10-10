From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 177171] Reduced frequency window for conservative governor
Date: Mon, 10 Oct 2016 20:38:24 +0000
Message-ID: <bug-177171-137361-pNbRszo1vW@https.bugzilla.kernel.org/>
References: <bug-177171-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52146 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752132AbcJJUjB (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Oct 2016 16:39:01 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id C68522028D
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2016 20:38:26 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
        by mail.kernel.org (Postfix) with ESMTP id C9ABA202A1
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2016 20:38:24 +0000 (UTC)
In-Reply-To: <bug-177171-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=177171

Rafael J. Wysocki <rjw@rjwysocki.net> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO
                 CC|                            |rjw@rjwysocki.net,
                   |                            |viresh.kumar@linaro.org
         Regression|No                          |Yes

--- Comment #3 from Rafael J. Wysocki <rjw@rjwysocki.net> ---
Sorry for the breakage.

Do I understand correctly that the governor doesn't select frequencies below
2000000 now, although it did that before?

-- 
You are receiving this mail because:
You are the assignee for the bug.
