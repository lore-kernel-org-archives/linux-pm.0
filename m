From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 197009] /proc/cpuinfo does not update frequency
Date: Mon, 20 Nov 2017 22:22:16 +0000
Message-ID: <bug-197009-137361-bxzIJsYKpH@https.bugzilla.kernel.org/>
References: <bug-197009-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:33924 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751768AbdKTWWT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Nov 2017 17:22:19 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 194682934F
        for <linux-pm@vger.kernel.org>; Mon, 20 Nov 2017 22:22:19 +0000 (UTC)
In-Reply-To: <bug-197009-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=197009

Rafael J. Wysocki (rjw@rjwysocki.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|DOCUMENTED                  |CODE_FIX

--- Comment #13 from Rafael J. Wysocki (rjw@rjwysocki.net) ---
Now, whatever is reported as "cpu MHz" in /proc/cpuinfo in 4.13 and later has a
little to do with the intel_pstate driver in any case.  It always comes from
some code outside of this driver, this way or another.

That said, there is mainline commit 7d5905dc14a8 (x86 / CPU: Always show
current CPU frequency in /proc/cpuinfo) causing "cpu MHz" in /proc/cpuinfo to
report the current frequency again.  It is going to be backported to 4.13.y and
4.14.y if all goes well.

-- 
You are receiving this mail because:
You are the assignee for the bug.
