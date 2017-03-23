From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 194963] New: schedutil governor causes audio problem in game
Date: Thu, 23 Mar 2017 10:40:58 +0000
Message-ID: <bug-194963-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:60372 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932484AbdCWKlA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 06:41:00 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 3807227C14
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 10:40:59 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id EFA3627C14
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 10:40:58 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=194963

            Bug ID: 194963
           Summary: schedutil governor causes audio problem in game
           Product: Power Management
           Version: 2.5
    Kernel Version: 4.10.4
          Hardware: x86-64
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: john.ettedgui@gmail.com
        Regression: No

Created attachment 255443
  --> https://bugzilla.kernel.org/attachment.cgi?id=255443&action=edit
dmesg

Hello,

I'm on the kernel 4.10.4 but I've had the same issues for a few weeks already,
definitely on .3 and probably on .2 but not sure anymore.

When I switched the cpu governor from ondemand or performance to schedutil, it
all seemed fine, but actually playing a game in wine gives me audio cracking
every now and then, fairly similarly to when we didn't have a pulseaudio
backend in wine. (I have not tried using only alsa).

Interestingly I've tried 2 different games in Wine and the problem only happens
with one, I assume the more CPU intensive one: StarCraft 2.

Restarting the computer, killing pulseaudio and restarting it, limiting the
apps opened, not of that changed anything, but switching the governor back
fixed it right away.

My CPU is an Intel i7 4790k, this is my kernel line:
linux   /vmlinuz-linux root=/dev/sda3 rw  rootfstype=btrfs raid=noautodetect
intel_iommu=on quiet add_efi_memmap clocksource=hpet hpet=enable splash
consoleblank=0 intel_pstate=disable sysrq_always_enabled=1


I am not sure what else to provide, there was nothing in dmesg that seemed
related, nor any error in Wine, please tell me how I can help.

Thank you,
John

-- 
You are receiving this mail because:
You are the assignee for the bug.
