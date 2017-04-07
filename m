From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 176411] cpufreq/cpuinfo_cur_freq reports <unknown>, MSI X99A
 SLI PLUS i7-5820K,  MSI i7-5930K, MSI X99A Raider i7-5820K
Date: Fri, 07 Apr 2017 06:58:41 +0000
Message-ID: <bug-176411-137361-HH0LArdmMJ@https.bugzilla.kernel.org/>
References: <bug-176411-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:56744 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752775AbdDGG6r (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Apr 2017 02:58:47 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id D2444285EE
        for <linux-pm@vger.kernel.org>; Fri,  7 Apr 2017 06:58:46 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 3047E285F0
        for <linux-pm@vger.kernel.org>; Fri,  7 Apr 2017 06:58:46 +0000 (UTC)
In-Reply-To: <bug-176411-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=176411

Zhang Rui (rui.zhang@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEEDINFO                    |CLOSED
         Resolution|---                         |UNREPRODUCIBLE

--- Comment #34 from Zhang Rui (rui.zhang@intel.com) ---
(In reply to ish from comment #33)
> It appears that this has resolved itself for me. I've recently updated to
> kernel:
> 
> Linux desktop 4.10.8-200.fc25.x86_64 #1 SMP Fri Mar 31 13:20:22 UTC 2017
> x86_64 x86_64 x86_64 GNU/Linux
> 
> with Fedora 25.
> 

Good to know.

> I did a few reboots without power cycle with c-states disabled, which is how
> I last left my bios configured.  Running htop showed CPU percentages after
> each boot, i7z showed cores hitting max mhz.
> 
> I then reset my bios to factory default, which enables c-state. And did a
> few non-power cycle reboots, again seeing expected behaviour with the cores.
> I did not have to power cycle this time to get full speed.
> 
> I'll keep monitoring it, but is it possible a kernel update could have fixed
> it?

Well, maybe, I'm not quite sure, but I do know there is quite a lot of
intel-pstate fixes in recent kernels.
Anyway, bug closes as it can not be reproduced. Please feel free to reopen it
if you can reproduce the problem in the latest upstream kernel again.

-- 
You are receiving this mail because:
You are the assignee for the bug.
