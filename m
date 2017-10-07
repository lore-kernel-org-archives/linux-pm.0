From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 197153] Wrong cores frequencies values in /proc/cpuinfo
Date: Sat, 07 Oct 2017 16:02:06 +0000
Message-ID: <bug-197153-137361-UWAKGbjxGl@https.bugzilla.kernel.org/>
References: <bug-197153-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:54336 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751279AbdJGQCJ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Oct 2017 12:02:09 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id A23002899B
        for <linux-pm@vger.kernel.org>; Sat,  7 Oct 2017 16:02:08 +0000 (UTC)
In-Reply-To: <bug-197153-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=197153

--- Comment #5 from Artem S. Tashkinov (t.artem@mailcity.com) ---
While we're at it I don't understand why I see four different values at 

/sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq

My CPU has just two physical cores (the two others are HT). I'm OK with Value0
Value0 and Value1 Value1 but not with four different values. I understand that
frequencies are dynamic but not that dynamic so that the cat utility which
completes in under 0.001 seconds could see four quite different values.

-- 
You are receiving this mail because:
You are the assignee for the bug.
