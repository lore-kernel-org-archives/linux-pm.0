From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 173361] Under heavy load, the CPU speed suddenly and
 irreversibly drops from 3500 to 400 MHz
Date: Thu, 29 Sep 2016 21:32:55 +0000
Message-ID: <bug-173361-137361-086kheugCG@https.bugzilla.kernel.org/>
References: <bug-173361-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:35674 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934363AbcI2VdA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Sep 2016 17:33:00 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 825D6203A5
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2016 21:32:58 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
        by mail.kernel.org (Postfix) with ESMTP id 259A22038E
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2016 21:32:56 +0000 (UTC)
In-Reply-To: <bug-173361-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=173361

Rafael J. Wysocki <rjw@rjwysocki.net> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |rjw@rjwysocki.net
           Assignee|linux-pm@vger.kernel.org    |rjw@rjwysocki.net

-- 
You are receiving this mail because:
You are the assignee for the bug.
