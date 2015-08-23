From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 103351] New: Machine check exception on Broadwell quad-core
 with SpeedStep enabled
Date: Sun, 23 Aug 2015 13:45:11 +0000
Message-ID: <bug-103351-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:45189 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752260AbbHWNpO (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 23 Aug 2015 09:45:14 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id E956420654
	for <linux-pm@vger.kernel.org>; Sun, 23 Aug 2015 13:45:12 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
	by mail.kernel.org (Postfix) with ESMTP id ECA2220651
	for <linux-pm@vger.kernel.org>; Sun, 23 Aug 2015 13:45:11 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=103351

            Bug ID: 103351
           Summary: Machine check exception on Broadwell quad-core with
                    SpeedStep enabled
           Product: Power Management
           Version: 2.5
    Kernel Version: 4.2rc7
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: kris7topher@gmail.com
        Regression: No

On my MSI GE62 2QE Apache Pro laptop with an Intel Core i7 5700HQ processor, I
am having machine check exceptions appearing randomly when SpeedStep is enabled
in the BIOS. I can trigger them quite reliable by running M-x package-install
in emacs, but they also occur without any specific reason.

The bug can be triggered with the 4.2rc7-mainline kernel, as well as the Arch
Linux 4.1.6-1 and 3.14.51-1-lts kernels. Booting with intel_pstate=disable does
not solve the problem, only disable SpeedStep in the BIOS altogether does (but
that also prevents CPU scaling to be done). After booting with mce=3 to ignore
the machine check exception, I managed to capture the following error message:

CPU 2: Machine Check Exception: 5 Bank: 4 be00000000800400
RIP !INEXACT! 10:<ffffffff81045de2> {acpi_processor_ffh_cstate_enter+0x92/0xc0}
TSC 41979f424e MISC 7fc7ff2e82b9
PROCESSOR 0:40671 TIME 1439935114 SOCKET 0 APIC 4 microcode d

After this error, the affected CPU core reports numerous stalls, and the system
remains unusable. Unfortunately, the output of mcelog ("Hardware event. This is
not a software error.") did not enlighten me.

The issue seems to be connected to the stability issue of the Core i7 5775C
processor, which was reported by Phoronix along a workaround
athttp://www.phoronix.com/scan.php?page=news_item&px=core-i7-5775c-oc-fixed-mode

I also tested the system with memtest86, which did not report any errors in 8
passes. Running Windows 10 x64 Education on the machine (and some CPU and
memory intensive scientific computing on it) also remains stable without any
anomalies.

-- 
You are receiving this mail because:
You are the assignee for the bug.
