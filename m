From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 177171] Reduced frequency window for conservative governor
Date: Fri, 14 Oct 2016 23:43:54 +0000
Message-ID: <bug-177171-137361-XR7AIScVAi@https.bugzilla.kernel.org/>
References: <bug-177171-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:36968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751425AbcJNXxE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 14 Oct 2016 19:53:04 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 9A60720439
        for <linux-pm@vger.kernel.org>; Fri, 14 Oct 2016 23:43:56 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
        by mail.kernel.org (Postfix) with ESMTP id A48982042B
        for <linux-pm@vger.kernel.org>; Fri, 14 Oct 2016 23:43:54 +0000 (UTC)
In-Reply-To: <bug-177171-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=177171

Rafael J. Wysocki <rjw@rjwysocki.net> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|RESOLVED                    |CLOSED
         Resolution|PATCH_ALREADY_AVAILABLE     |CODE_FIX

--- Comment #10 from Rafael J. Wysocki <rjw@rjwysocki.net> ---
Merged as commit abb6627910a1e783c8e034b35b7c80e5e7f98f41:

http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=pm&id=abb6627910a1e783c8e034b35b7c80e5e7f98f41

-- 
You are receiving this mail because:
You are the assignee for the bug.
