From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 156601] New: All governors except "performance" are not
 available anymore
Date: Mon, 12 Sep 2016 20:13:38 +0000
Message-ID: <bug-156601-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:46920 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751092AbcILUNl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 12 Sep 2016 16:13:41 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 80B7E2039E
        for <linux-pm@vger.kernel.org>; Mon, 12 Sep 2016 20:13:39 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
        by mail.kernel.org (Postfix) with ESMTP id 8A2B02039D
        for <linux-pm@vger.kernel.org>; Mon, 12 Sep 2016 20:13:38 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=156601

            Bug ID: 156601
           Summary: All governors except "performance" are not available
                    anymore
           Product: Power Management
           Version: 2.5
    Kernel Version: 4.6.5
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: sworddragon2@aol.com
        Regression: No

I'm noticing that in
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors only the
"performance" governor is available while on this system multiple governors
(like "ondemand") were available in the past. On installing kernel version
4.4.16 and checking
/sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors multiple
governors are available again. The used cpu is an "AMD Phenom(tm) II X6 1045T
Processor".

-- 
You are receiving this mail because:
You are the assignee for the bug.
