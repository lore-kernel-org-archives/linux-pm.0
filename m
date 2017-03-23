From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 194963] schedutil governor causes audio problem in game
Date: Thu, 23 Mar 2017 23:03:36 +0000
Message-ID: <bug-194963-137361-1kaQ6Xu4BG@https.bugzilla.kernel.org/>
References: <bug-194963-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:35436 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1756452AbdCWXDm (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 19:03:42 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 7B81B2843D
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 23:03:41 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 16B132843D
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 23:03:40 +0000 (UTC)
In-Reply-To: <bug-194963-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=194963

--- Comment #4 from John (john.ettedgui@gmail.com) ---
(In reply to Viresh Kumar from comment #2)
> John,
> 
> Can you please give us the value of 
> /sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us
> 
> ?
> 
> Try making this around 10000 (10ms). This is how frequently we try to change
> the frequency and lowering it will make us more aggressive.

Hello Viresh,

cat /sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us
10000

It's already at that value, are there others you'd like me to try?

(In reply to Rafael J. Wysocki from comment #3)
> It also would be good to test this patch:
> 
> https://patchwork.kernel.org/patch/9637821/
> 
> and maybe also this one:
> 
> https://patchwork.kernel.org/patch/9640261/
> 
> to see if it improves things for the intel_pstate "powersave" on that
> machine.

Hello Rafael,

I will try these and report.
Does it matter if I use both patches together?


Thank you!

-- 
You are receiving this mail because:
You are the assignee for the bug.
