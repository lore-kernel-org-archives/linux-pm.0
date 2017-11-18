From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 197009] /proc/cpuinfo does not update frequency
Date: Sat, 18 Nov 2017 15:34:27 +0000
Message-ID: <bug-197009-137361-37t5DMdHLK@https.bugzilla.kernel.org/>
References: <bug-197009-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:37292 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1757978AbdKRPe2 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 18 Nov 2017 10:34:28 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 6F8EA29FE7
        for <linux-pm@vger.kernel.org>; Sat, 18 Nov 2017 15:34:28 +0000 (UTC)
In-Reply-To: <bug-197009-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=197009

--- Comment #8 from Hal (haleakalas@yahoo.com) ---
The "fix" in 4.13.12 was undone/reversed in 4.13.13 and subsequent releases,
including 4.13.14 and 4.14.0.
Therefore we are back to square one with this issue, whether you call it a bug,
a regression or the improvement of the code. 

This has a significant impact on power consumption on some machines, especially
laptops and passive cooling type setups.

The issue that was reported as "CPU Frequency Monitor showing the maximum
frequency of the CPU in XFCE at all times" is just the tip of the iceberg. It
is far from being a cosmetic issue. It functionally is very disruptive.

On laptops it drains the battery at a rate far greater than normal. It makes
the difference of being or not being able to use your laptop during a 4 hr
flight.

Going back to acpi_cpufreq instead of intel_pstate is a temporary solution on
some hardware, but not always, as acpi_cpufreq doesn't seem to have the same
level of power savings optimizations as in intel_pstate.

What would it take to "reopen" this issue as it looks like from a "bug" point
of view this is now set aside.

-- 
You are receiving this mail because:
You are the assignee for the bug.
