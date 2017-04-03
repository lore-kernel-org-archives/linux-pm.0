From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 176411] cpufreq/cpuinfo_cur_freq reports <unknown>
Date: Mon, 03 Apr 2017 23:44:21 +0000
Message-ID: <bug-176411-137361-6iO5LbZrcA@https.bugzilla.kernel.org/>
References: <bug-176411-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:54256 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751734AbdDCXoY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Apr 2017 19:44:24 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id E9BB526419
        for <linux-pm@vger.kernel.org>; Mon,  3 Apr 2017 23:44:23 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 44957284BC
        for <linux-pm@vger.kernel.org>; Mon,  3 Apr 2017 23:44:22 +0000 (UTC)
In-Reply-To: <bug-176411-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=176411

--- Comment #31 from Len Brown (lenb@kernel.org) ---
@ Dominik Gronkiewicz 

> I also noticed that machine has slowed down significantly.

This suggests that timers are broken.
Please see if there is anything in the dmesg about this -- such as your TSC
being de-activited as a clock source.

> Disabling C-states in MSI BIOS
> indeed brings back full functionality and performance of the CPU.

This is important if this is true, can you verify that re-enabling
C-states breaks your system?


> the problem seems to occur only after a reboot and never after a cold
> shutdown.

is that with C-states enabled or disabled?

-- 
You are receiving this mail because:
You are the assignee for the bug.
