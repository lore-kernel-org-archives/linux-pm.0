From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 196263] powersave broken
Date: Mon, 03 Jul 2017 21:24:45 +0000
Message-ID: <bug-196263-137361-Cy9vZaSUW2@https.bugzilla.kernel.org/>
References: <bug-196263-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:53784 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751713AbdGCVYq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 3 Jul 2017 17:24:46 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 3803F22B26
        for <linux-pm@vger.kernel.org>; Mon,  3 Jul 2017 21:24:46 +0000 (UTC)
In-Reply-To: <bug-196263-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=196263

--- Comment #2 from Rafael J. Wysocki (rjw@rjwysocki.net) ---
(In reply to Rafael J. Wysocki from comment #1)
> intel_pstate "powersave" is not the powersave governor you are used to.
> 
> 1. Does it help to run with intel_pstate=passive in the kernel command line?
> 
> 2. Does it help to run with intel_pstate=disabled in the kernel command line?

That should be intel_pstate=disable, sorry.

-- 
You are receiving this mail because:
You are the assignee for the bug.
