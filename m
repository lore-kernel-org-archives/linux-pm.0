From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 173361] New: Under heavy load, the CPU speed suddenly and
 irreversibly drops from 3500 to 400 MHz
Date: Thu, 29 Sep 2016 14:57:55 +0000
Message-ID: <bug-173361-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:52566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932221AbcI2O57 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 29 Sep 2016 10:57:59 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 7ACC220251
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2016 14:57:57 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
        by mail.kernel.org (Postfix) with ESMTP id 40F9E2024F
        for <linux-pm@vger.kernel.org>; Thu, 29 Sep 2016 14:57:56 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=173361

            Bug ID: 173361
           Summary: Under heavy load, the CPU speed suddenly and
                    irreversibly drops from 3500 to 400 MHz
           Product: Power Management
           Version: 2.5
    Kernel Version: 4.8-rc1
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: Larry.Finger@lwfinger.net
        Regression: No

My Toshiba Tecra A50-A laptop that a CPU described as 'Model: 6.60.3 "Intel(R)
Core(TM) i7-4600M CPU @ 2.90GHz"'. Under heavy load, this dual-core unit with
hyperthreading will suddenly drop from a frequency of 3500 to 410 MHz. The only
way to recover is to reboot. See
http://lkml.iu.edu/hypermail/linux/kernel/1609.3/00720.html for some details
and other discussion.

This bug is being filed under power management because the 'sensors' command
shows the following:

finger@linux-1t8h:~> sensors
coretemp-isa-0000
Adapter: ISA adapter
Physical id 0:  +88.0°C  (high = +84.0°C, crit = +100.0°C)
Core 0:         +88.0°C  (high = +84.0°C, crit = +100.0°C)
Core 1:         +77.0°C  (high = +84.0°C, crit = +100.0°C)

Routinely, at least one of the CPUs has a temperature higher than the "high"
value. As Rafael Wysocki states "It looks like in 4.8-rc we made a change that
caused the "high" trip point to be acted on." In that case, the bug would be
that the frequency is never restored.

-- 
You are receiving this mail because:
You are the assignee for the bug.