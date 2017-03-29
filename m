From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 194963] schedutil governor causes audio problem in game
Date: Wed, 29 Mar 2017 06:27:14 +0000
Message-ID: <bug-194963-137361-1kxXQ66Qy3@https.bugzilla.kernel.org/>
References: <bug-194963-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:57524 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753037AbdC2G1Q (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2017 02:27:16 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 4C13328405
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2017 06:27:15 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id EF3782768C
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2017 06:27:14 +0000 (UTC)
In-Reply-To: <bug-194963-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=194963

--- Comment #14 from John (john.ettedgui@gmail.com) ---
Well actually it's not good enough for me yet, I still get the audio issue,
very rarely though. I'll switch to ondemand on the same kernel and see if I
also get it (since it's a different kernel who knows...).

-- 
You are receiving this mail because:
You are the assignee for the bug.
