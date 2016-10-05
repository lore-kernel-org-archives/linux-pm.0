From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 176411] cpufreq/cpuinfo_cur_freq reports <unknown>
Date: Wed, 05 Oct 2016 23:34:41 +0000
Message-ID: <bug-176411-137361-id2LpBAhig@https.bugzilla.kernel.org/>
References: <bug-176411-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:44010 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751227AbcJEXep (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Oct 2016 19:34:45 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id B4EC120340
        for <linux-pm@vger.kernel.org>; Wed,  5 Oct 2016 23:34:43 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
        by mail.kernel.org (Postfix) with ESMTP id 0CB0F20131
        for <linux-pm@vger.kernel.org>; Wed,  5 Oct 2016 23:34:42 +0000 (UTC)
In-Reply-To: <bug-176411-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=176411

--- Comment #6 from Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com> ---
Looks like the schedule util tick is not getting called back.
Since you have issue with all time keeping issues for process stats also, I
suspect something to do with tick.

Can you run some load and attach same turbostat:
# turbostat --debug --msr=0x199

Do you have some special kernel config or running a distro config?
Attach .config also.

Kernel command line: What is cat /proc/cmdline?

-- 
You are receiving this mail because:
You are the assignee for the bug.
