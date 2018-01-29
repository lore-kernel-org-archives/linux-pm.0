From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 198601] Conservative governor is broken in 4.14.14
Date: Mon, 29 Jan 2018 07:05:19 +0000
Message-ID: <bug-198601-137361-qHiuF06C44@https.bugzilla.kernel.org/>
References: <bug-198601-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:49656 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751032AbeA2HFU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 29 Jan 2018 02:05:20 -0500
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 9366722BF1
        for <linux-pm@vger.kernel.org>; Mon, 29 Jan 2018 07:05:19 +0000 (UTC)
In-Reply-To: <bug-198601-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=198601

Zhang Rui (rui.zhang@intel.com) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO
                 CC|                            |rui.zhang@intel.com

--- Comment #1 from Zhang Rui (rui.zhang@intel.com) ---
does the problem still exist in 4.15?

what's the earliest kernel version that does not have this problem?
can you attach the cpu frequency with the good kernel?

-- 
You are receiving this mail because:
You are the assignee for the bug.
