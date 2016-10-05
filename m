From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 176411] cpufreq/cpuinfo_cur_freq reports <unknown>
Date: Wed, 05 Oct 2016 20:39:44 +0000
Message-ID: <bug-176411-137361-gaZCPn2YDB@https.bugzilla.kernel.org/>
References: <bug-176411-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:40620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752754AbcJEUjs (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Oct 2016 16:39:48 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id F0B9920165
        for <linux-pm@vger.kernel.org>; Wed,  5 Oct 2016 20:39:46 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
        by mail.kernel.org (Postfix) with ESMTP id 040EF20149
        for <linux-pm@vger.kernel.org>; Wed,  5 Oct 2016 20:39:45 +0000 (UTC)
In-Reply-To: <bug-176411-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=176411

Rafael J. Wysocki <rjw@rjwysocki.net> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO
                 CC|                            |rjw@rjwysocki.net

--- Comment #1 from Rafael J. Wysocki <rjw@rjwysocki.net> ---
What's in

/sys/devices/system/cpu/cpu*/cpufreq/scaling_driver

?

-- 
You are receiving this mail because:
You are the assignee for the bug.
