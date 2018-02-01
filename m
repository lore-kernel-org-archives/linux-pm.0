From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 198637] New: cpuinfo_cur_freq differs from scaling_cur_freq on
 an AMD FX-8320E
Date: Thu, 01 Feb 2018 17:17:41 +0000
Message-ID: <bug-198637-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:51340 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751378AbeBARRn (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 1 Feb 2018 12:17:43 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id AA3A228B81
        for <linux-pm@vger.kernel.org>; Thu,  1 Feb 2018 17:17:42 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=198637

            Bug ID: 198637
           Summary: cpuinfo_cur_freq differs from scaling_cur_freq on an
                    AMD FX-8320E
           Product: Power Management
           Version: 2.5
    Kernel Version: 4.15.0
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: stefantalpalaru@yahoo.com
        Regression: No

With the "performance" governor:

root# cat /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_cur_freq
4400000
4400000
4400000
4400000
4400000
4400000
4400000
4400000
root# cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq 
3029755
3114686
4173759
4365672
2865808
3887821
4247518
3671205

This is a problem because only the latter, wrong value is readable by non-root
users and it's also the only one shown in /proc/cpuinfo.

According to this 2011 email -
http://permalink.gmane.org/gmane.linux.kernel.cpufreq/7008 :

> everyone may read out scaling_cur_freq, and scaling_cur_freq differs from
cpuinfo_cur_freq _only_ if something is broken

So what's broken and how can we fix it?

Additional info:
- scaling_driver is "acpi-cpufreq"
- scaling_min_freq and scaling_max_freq have correct values (same as their
cpuinfo_ counterparts)
- the CPU has Turbo Core disabled and it's overclocked to 4.4GHz but the
problem should also manifest on default setups

-- 
You are receiving this mail because:
You are the assignee for the bug.
