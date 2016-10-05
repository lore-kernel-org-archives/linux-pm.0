From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 176411] New: cpufreq/cpuinfo_cur_freq <unknown> for i7 5820k
Date: Wed, 05 Oct 2016 14:53:35 +0000
Message-ID: <bug-176411-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:49070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753007AbcJEOxi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 5 Oct 2016 10:53:38 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 661B7202B8
        for <linux-pm@vger.kernel.org>; Wed,  5 Oct 2016 14:53:36 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
        by mail.kernel.org (Postfix) with ESMTP id 6C98E2026D
        for <linux-pm@vger.kernel.org>; Wed,  5 Oct 2016 14:53:35 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=176411

            Bug ID: 176411
           Summary: cpufreq/cpuinfo_cur_freq <unknown> for i7 5820k
           Product: Power Management
           Version: 2.5
    Kernel Version: 4.7.6
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: high
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: mike.d.lui@gmail.com
        Regression: No

# cat /proc/cpuinfo | grep model

model           : 63
model name      : Intel(R) Core(TM) i7-5820K CPU @ 3.30GHz
...

# cat /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq

<unknown><unknown><unknown><unknown><unknown><unknown><unknown><unknown><unknown><unknown><unknown><unknown>

# cat /proc/[pid]/stat

will also show '0' for utime, stime, cutime, and cstime

Certain utilities like 'top' and 'ps' will show '0%' for %CPU for a given
process, but not for a given CPU.

I've upgraded my kernel a few times in the past several weeks, and I noticed
this issue before, although I'm not sure the exact kernel version I started
noticing this. This same behavior has been reported for an i7 5930k (also
6-core Haswell-E). Performance degradation that I began noticing around the
same time may be related.

-- 
You are receiving this mail because:
You are the assignee for the bug.
