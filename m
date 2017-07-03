From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 196263] powersave broken
Date: Mon, 03 Jul 2017 21:04:02 +0000
Message-ID: <bug-196263-137361-XyEBvoBVpB@https.bugzilla.kernel.org/>
References: <bug-196263-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:50504 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753171AbdGCVEE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2017 17:04:04 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 1530026223
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2017 21:04:04 +0000 (UTC)
In-Reply-To: <bug-196263-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=196263

Rafael J. Wysocki (rjw@rjwysocki.net) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |NEEDINFO
                 CC|                            |rjw@rjwysocki.net

--- Comment #1 from Rafael J. Wysocki (rjw@rjwysocki.net) ---
intel_pstate "powersave" is not the powersave governor you are used to.

1. Does it help to run with intel_pstate=passive in the kernel command line?

2. Does it help to run with intel_pstate=disabled in the kernel command line?

-- 
You are receiving this mail because:
You are the assignee for the bug.
