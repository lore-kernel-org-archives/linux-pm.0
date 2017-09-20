From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 197009] New: /proc/cpuinfo does not update frequency
Date: Wed, 20 Sep 2017 18:55:27 +0000
Message-ID: <bug-197009-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:52410 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751462AbdITSz3 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2017 14:55:29 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 8870A29210
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2017 18:55:28 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=197009

            Bug ID: 197009
           Summary: /proc/cpuinfo does not update frequency
           Product: Power Management
           Version: 2.5
    Kernel Version: 4.13
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: aleksey@rybalkin.org
        Regression: No

Created attachment 258537
  --> https://bugzilla.kernel.org/attachment.cgi?id=258537&action=edit
kernel config

The 4.13 kernel with intel_pstate=passive (or active) does not appear to
correctly update the CPU frequency in /proc/cpuinfo

After booting the reported frequency (but not the real frequency) is stuck on
one value and does not update:

$ grep MHz /proc/cpuinfo
cpu MHz         : 2194.859
cpu MHz         : 2194.859
cpu MHz         : 2194.859
cpu MHz         : 2194.859

hardware: ThinkPad X250
cpu: Intel(R) Core(TM) i5-5200U CPU @ 2.20GHz
kernel: 4.13.3 vanilla (config attached)

As far as I remember this worked in 4.11 and broke after 4.12, I can double
check if needed.

-- 
You are receiving this mail because:
You are the assignee for the bug.
