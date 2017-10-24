From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 197009] /proc/cpuinfo does not update frequency
Date: Tue, 24 Oct 2017 05:12:32 +0000
Message-ID: <bug-197009-137361-GwmORPBd9R@https.bugzilla.kernel.org/>
References: <bug-197009-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:45456 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750783AbdJXFMe (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Oct 2017 01:12:34 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id ABE3A28977
        for <linux-pm@vger.kernel.org>; Tue, 24 Oct 2017 05:12:33 +0000 (UTC)
In-Reply-To: <bug-197009-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=197009

Steven Haigh (netwiz@crc.id.au) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |netwiz@crc.id.au

--- Comment #5 from Steven Haigh (netwiz@crc.id.au) ---
I'm trying to figure out if I've hit a bug or not... My laptop CPU now doesn't
seem to clock down - meaning the temps are higher and the laptop CPU fan is
always running - even when idle.

I noticed it used the intel_pstate driver, I disabled this and tried the
acpi_cpufreq driver, however I see the following:

# cat /sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq
2828056
2890338
2889348
2800463

The frequencies supported are:
2901000 2900000 2800000 2700000 2500000 2400000 2300000 2200000 2000000 1900000
1800000 1700000 1600000 1400000 1300000 1200000

I've tried the ondemand and performance gov with no changes.

Is this an actual problem (I think so), or am I checking the freq settings in
the wrong place and the values displayed are making me bark up the wrong tree?

-- 
You are receiving this mail because:
You are the assignee for the bug.
