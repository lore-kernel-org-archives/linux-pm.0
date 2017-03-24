From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 194963] schedutil governor causes audio problem in game
Date: Fri, 24 Mar 2017 04:02:21 +0000
Message-ID: <bug-194963-137361-0ezpm8lLZ8@https.bugzilla.kernel.org/>
References: <bug-194963-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:51836 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751205AbdCXECX (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 24 Mar 2017 00:02:23 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id ABF8928474
        for <linux-pm@vger.kernel.org>; Fri, 24 Mar 2017 04:02:21 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 51C0226E56
        for <linux-pm@vger.kernel.org>; Fri, 24 Mar 2017 04:02:21 +0000 (UTC)
In-Reply-To: <bug-194963-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=194963

--- Comment #8 from John (john.ettedgui@gmail.com) ---
(In reply to Rafael J. Wysocki from comment #7)
> OK, this means that schedutil is not a good match for you.
> 
> It is a bit less aggressive than ondemand, on purpose.

Oh I see, I didn't realize that, I thought it was about as dynamic as ondemand.
Then I am sorry about a wrong report!

> There is one more schedutil change that you may try, but I need to prepare a
> patch for that first.
> 

I'll be happy to test it whenever it's ready. Since I have plenty of workaround
there's of course no sense of urgence on my end.

> If you mean scaling_governor=performance, then it will always request the
> max P-state now, as that's what it is supposed to be doing.

Yes that is what I meant, I thought scaling_governor=performance with
driver=intel_pstate would scale unlike with driver=cpufreq, I was wrong again.

> Thanks for the testing, the intel_pstate change will be queued up for 4.12
> in the next couple of days.

Well thank you for this patch, I am happy to finally be able to use pstate :)


If you don't mind me asking here, since we talked about many different
governors, and their drivers, which one do you recommend for a desktop, that
does run games, but also other things that don't require much power. Based on
my tests I'm thinking either cpufreq's ondemand or pstate's powersave.

Thank you!

-- 
You are receiving this mail because:
You are the assignee for the bug.
