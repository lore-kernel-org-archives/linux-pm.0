From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 194963] schedutil governor causes audio problem in game
Date: Thu, 23 Mar 2017 14:31:57 +0000
Message-ID: <bug-194963-137361-HmnR6tiV98@https.bugzilla.kernel.org/>
References: <bug-194963-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:60664 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S932592AbdCWOb7 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 10:31:59 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 862261FF28
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 14:31:58 +0000 (UTC)
Received: from pdx-korg-bugzilla-1.web.codeaurora.org (unknown [172.30.200.120])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id 1C6461FF28
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 14:31:58 +0000 (UTC)
In-Reply-To: <bug-194963-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=194963

Viresh Kumar (viresh.kumar@linaro.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |viresh.kumar@linaro.org

--- Comment #2 from Viresh Kumar (viresh.kumar@linaro.org) ---
John,

Can you please give us the value of 
/sys/devices/system/cpu/cpufreq/schedutil/rate_limit_us

?

Try making this around 10000 (10ms). This is how frequently we try to change
the frequency and lowering it will make us more aggressive.

-- 
You are receiving this mail because:
You are the assignee for the bug.
