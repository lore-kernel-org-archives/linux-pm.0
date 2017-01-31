From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 176411] cpufreq/cpuinfo_cur_freq reports <unknown>
Date: Tue, 31 Jan 2017 21:06:00 +0000
Message-ID: <bug-176411-137361-dBSbC5Uz3S@https.bugzilla.kernel.org/>
References: <bug-176411-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750940AbdAaVGF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 31 Jan 2017 16:06:05 -0500
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 871FC2025B
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2017 21:06:03 +0000 (UTC)
Received: from bugzilla1.web.kernel.org (bugzilla1.web.kernel.org [172.20.200.51])
        by mail.kernel.org (Postfix) with ESMTP id 2C04020221
        for <linux-pm@vger.kernel.org>; Tue, 31 Jan 2017 21:06:01 +0000 (UTC)
In-Reply-To: <bug-176411-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=176411

ish@unx.ca changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |ish@unx.ca

--- Comment #27 from ish@unx.ca ---
Thought I would chime in hear and say that I'm seeing something very similar.

model        : 63
model name    : Intel(R) Core(TM) i7-5820K CPU @ 3.30GHz
stepping    : 2

The motherboard is a MSI X99A Raider.  I did not see an option to disable over
clocking, but did disable C-states and made sure turbo boost was enabled.

On cold boot the system is fine. The cores fluctuate between 1200 and 3400 Mhz
as expected. But on a normal reboot they appear to be locked at 1200 Mhz and
never accelerate.  Additionally, apps like ps and htop show all processes with
a CPU usage of 0%.

I can increase the speed by doing a "cpupower frequency-set -g performance",
but all processes show 0% CPU usage which is not correct for the apps I'm
running.

-- 
You are receiving this mail because:
You are the assignee for the bug.
