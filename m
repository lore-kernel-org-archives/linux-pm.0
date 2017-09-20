From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 197009] /proc/cpuinfo does not update frequency
Date: Wed, 20 Sep 2017 19:03:37 +0000
Message-ID: <bug-197009-137361-UWzlEvbErZ@https.bugzilla.kernel.org/>
References: <bug-197009-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:52960 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751471AbdITTDi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 20 Sep 2017 15:03:38 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 2CED4288CD
        for <linux-pm@vger.kernel.org>; Wed, 20 Sep 2017 19:03:38 +0000 (UTC)
In-Reply-To: <bug-197009-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=197009

Doug Smythies (dsmythies@telus.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |dsmythies@telus.net

--- Comment #1 from Doug Smythies (dsmythies@telus.net) ---
That is correct, and was intentional. It just lists tsc now.

To get the actual CPU frequencies, you have to use:

cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq

Or, I guess, more correctly these days:

cat /sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq

-- 
You are receiving this mail because:
You are the assignee for the bug.
