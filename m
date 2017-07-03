From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 196263] New: powersave broken
Date: Mon, 03 Jul 2017 20:53:29 +0000
Message-ID: <bug-196263-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:48110 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753174AbdGCUxb (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2017 16:53:31 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id C540426D05
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2017 20:53:30 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=196263

            Bug ID: 196263
           Summary: powersave broken
           Product: Power Management
           Version: 2.5
    Kernel Version: 4.11.6
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: roman.gruber@gmx.at
        Regression: No

Recent kernel upgrade enforces driver: intel_pstate. there the powersave
governour is broken.

To verify this behaviour I emerged the biggest package available in gentoo, 
libreoffice

I changed to the powersave governour. Synced the portage tree and updated my
system. This also included libreoffice

i7z reported maxed out cpu. Fans were spinning, fan air was quite hot, as in
state ondemand or performance. 

On previous kernels powersave would clock down the cpu to 1200, and the fan
hardly will be recognizeable, fan air would stay in a certain lower range. 

Compile timings of powersave governour iwth intel_pstate is similar to
performanceor ondemand on previous kernels. 

ASUS-G75VW roman # splat app-office/libreoffice-5.3.4.2
 * app-office/libreoffice-5.3.4.2

        Emerged at: Mo Jul  3 21:22:39 2017
        Build time: 1 hour, 10 minutes, and 38 seconds

ASUS-G75VW roman # cpupower frequency-info
analyzing CPU 0:
  driver: intel_pstate
  CPUs which run at the same hardware frequency: 0
  CPUs which need to have their frequency coordinated by software: 0
  maximum transition latency:  Cannot determine or is not supported.
  hardware limits: 1.20 GHz - 3.30 GHz
  available cpufreq governors: performance powersave
  current policy: frequency should be within 1.20 GHz and 3.30 GHz.
                  The governor "powersave" may decide which speed to use
                  within this range.
  current CPU frequency: 1.20 GHz (asserted by call to hardware)
  boost state support:
    Supported: yes
    Active: yes
    3100 MHz max turbo 4 active cores
    3100 MHz max turbo 3 active cores
    3200 MHz max turbo 2 active cores
    3300 MHz max turbo 1 active cores

ASUS-G75VW roman # uname -a
Linux ASUS-G75VW 4.11.6-gentoo-23-06-2017 #1 SMP Fri Jun 23 19:54:15 CEST 2017
x86_64 Intel(R) Core(TM) i7-3610QM CPU @ 2.30GHz GenuineIntel GNU/Linux

--

Similar timings with performance governour on older kernels with previous
packages, just a few samples taken as reference

 * app-office/libreoffice-5.2.7.2

        Emerged at: Do Mai 11 23:32:41 2017
        Build time: 1 hour, 10 minutes, and 55 seconds


 * app-office/libreoffice-5.2.3.3-r1

        Emerged at: Sa Dez  3 23:58:27 2016
        Build time: 1 hour, 6 minutes, and 44 seconds

--

cpu, ivybridge: model name      : Intel(R) Core(TM) i7-3610QM CPU @ 2.30GHz

--

  current policy: frequency should be within 1.20 GHz and 3.30 GHz.
                  The governor "powersave" may decide which speed to use
                  within this range.

Please fix this or revert to the old behaviour.

I expect powersave to be powersave, therefore no high cpu clocks, no hot air,
no  recognizeable fans.

Kernels around ~4.9.x or before are not affected in my case.

-- 
You are receiving this mail because:
You are the assignee for the bug.
