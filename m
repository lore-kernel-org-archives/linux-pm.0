From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 177161] New: CPU frequencies in /proc/cpuinfo aren't
 dynamically updated
Date: Mon, 10 Oct 2016 13:15:42 +0000
Message-ID: <bug-177161-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:60806 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752063AbcJJNPp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Oct 2016 09:15:45 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 5158C201BC
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2016 13:15:44 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
        by mail.kernel.org (Postfix) with ESMTP id 59A9B201B9
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2016 13:15:43 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=177161

            Bug ID: 177161
           Summary: CPU frequencies in /proc/cpuinfo aren't dynamically
                    updated
           Product: Power Management
           Version: 2.5
    Kernel Version: >=4.8
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: itumaykin+kernel@gmail.com
        Regression: Yes

Created attachment 241281
  --> https://bugzilla.kernel.org/attachment.cgi?id=241281&action=edit
lspci -nn -k -vvv

Hello.

Since 4.8 frequencies in /proc/cpuinfo aren't dynamically updated anymore.
I guess they are stuck to the values written during boot as I get different
values from boot to boot.

This wasn't the case with 4.7.x or any previous kernel series.

Please fix.

-- 
You are receiving this mail because:
You are the assignee for the bug.
