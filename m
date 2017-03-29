From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 194963] schedutil governor causes audio problem in game
Date: Wed, 29 Mar 2017 00:28:54 +0000
Message-ID: <bug-194963-137361-x6LOz6Azei@https.bugzilla.kernel.org/>
References: <bug-194963-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:41080 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932352AbdC2A3B (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 28 Mar 2017 20:29:01 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id B82342845F
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2017 00:28:59 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 7946528459
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2017 00:28:59 +0000 (UTC)
In-Reply-To: <bug-194963-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=194963

--- Comment #12 from Rafael J. Wysocki (rjw@rjwysocki.net) ---
I forgot to say that the patch in comment #11 is based on the current
linux-next branch of the linux-pm.git repository:

https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git/log/?h=linux-next

and it should be safe to test it along with that branch.

-- 
You are receiving this mail because:
You are the assignee for the bug.
