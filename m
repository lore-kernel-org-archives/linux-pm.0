From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 197153] Wrong cores frequencies values in /proc/cpuinfo
Date: Sat, 07 Oct 2017 22:33:31 +0000
Message-ID: <bug-197153-137361-Zv7FCfUeMf@https.bugzilla.kernel.org/>
References: <bug-197153-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:50000 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751940AbdJGWdd (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Oct 2017 18:33:33 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id B8D9E287D5
        for <linux-pm@vger.kernel.org>; Sat,  7 Oct 2017 22:33:32 +0000 (UTC)
In-Reply-To: <bug-197153-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=197153

--- Comment #6 from Artem S. Tashkinov (t.artem@mailcity.com) ---
The /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq interface is also
broken in 4.13.

This one liner:

cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq | awk '{if (max<$0)
max=$0}END{printf "%.2fGHz",max/1000000}'

prints values from 0.50GHz to 2.55GHz even though my laptop is more or less
completely idle (no running applications aside from XFCE itself).

-- 
You are receiving this mail because:
You are the assignee for the bug.
