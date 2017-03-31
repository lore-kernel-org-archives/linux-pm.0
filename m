From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 194963] schedutil governor causes audio problem in game
Date: Fri, 31 Mar 2017 03:51:21 +0000
Message-ID: <bug-194963-137361-LrUA4dIsS0@https.bugzilla.kernel.org/>
References: <bug-194963-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:52938 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753730AbdCaDvY (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 30 Mar 2017 23:51:24 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 688662867F
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2017 03:51:23 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id D08682867F
        for <linux-pm@vger.kernel.org>; Fri, 31 Mar 2017 03:51:22 +0000 (UTC)
In-Reply-To: <bug-194963-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=194963

--- Comment #18 from John (john.ettedgui@gmail.com) ---
So I've been on passive for about a day, and I didn't notice any difference
with acpi-cpufreq. As you've correctly stated in your email, I am not doing any
measurements so it's all a bit of a guesswork. I could plot frequencies if
needed.

One thing I forgot to mention earlier is that I use the most cpu intensive
resample method in pulseaudio (speex-float-10).

On another forum, one user tried to replicate my tests and never had any issue
or worse performance with standard schedutil from 4.10 on a 2500k.  I don't
know if he's using pulse or straight alsa, and if the former which resampler is
used. I'll try to get this information. Not sure what that means, but I thought
I might as well share this.

-- 
You are receiving this mail because:
You are the assignee for the bug.
