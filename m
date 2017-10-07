From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 197153] Wrong cores frequencies values in /proc/cpuinfo
Date: Sat, 07 Oct 2017 15:21:06 +0000
Message-ID: <bug-197153-137361-AEBk0e2FMD@https.bugzilla.kernel.org/>
References: <bug-197153-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:52956 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751179AbdJGPVI (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 7 Oct 2017 11:21:08 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id E33A9287D2
        for <linux-pm@vger.kernel.org>; Sat,  7 Oct 2017 15:21:07 +0000 (UTC)
In-Reply-To: <bug-197153-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=197153

Artem S. Tashkinov (t.artem@mailcity.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |torvalds@linux-foundation.o
                   |                            |rg

--- Comment #2 from Artem S. Tashkinov (t.artem@mailcity.com) ---
This breaks a lot of user space applications which report frequencies.

CC'ing Linus Torvalds.

-- 
You are receiving this mail because:
You are the assignee for the bug.
