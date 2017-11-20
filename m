From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 197009] /proc/cpuinfo does not update frequency
Date: Mon, 20 Nov 2017 05:28:31 +0000
Message-ID: <bug-197009-137361-AVchj2xdI8@https.bugzilla.kernel.org/>
References: <bug-197009-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:41578 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751132AbdKTF2c (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 20 Nov 2017 00:28:32 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 63CA028FD9
        for <linux-pm@vger.kernel.org>; Mon, 20 Nov 2017 05:28:32 +0000 (UTC)
In-Reply-To: <bug-197009-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=197009

--- Comment #9 from Rob Thomas (xrobau@gmail.com) ---
This ticket is specifically in regards to /proc/cpuinfo not displaying the
correct speed, which is a cosmetic issue. This has nothing to do with the
ACTUAL speed of the CPUs.

The revert of the revert was in this commit:

https://www.spinics.net/lists/stable/msg197162.html

Again, this ticket is purely about a cosmetic issue. Nothing else, as you can
see by the code.

If you're having problems with REAL power consumption, I suggest you open a new
ticket, or see if you can find an existing ticket that is your actual problem.

-- 
You are receiving this mail because:
You are the assignee for the bug.
