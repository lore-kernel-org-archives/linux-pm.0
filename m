From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 194963] schedutil governor causes audio problem in game
Date: Wed, 29 Mar 2017 05:21:39 +0000
Message-ID: <bug-194963-137361-PmQgFzvV6x@https.bugzilla.kernel.org/>
References: <bug-194963-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:54924 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752410AbdC2FVm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 29 Mar 2017 01:21:42 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id EF49528456
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2017 05:21:40 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id EAAD02845B
        for <linux-pm@vger.kernel.org>; Wed, 29 Mar 2017 05:21:39 +0000 (UTC)
In-Reply-To: <bug-194963-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=194963

--- Comment #13 from John (john.ettedgui@gmail.com) ---
I've tested it quickly and it seems to work just fine.
I've re-used my 4.10 kconfig file, and defaulted every new other option.

I'll keep running it and we'll see.

Is it ok that I didn't test the repository without the extra patch?

Thank you!

-- 
You are receiving this mail because:
You are the assignee for the bug.
