From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 197009] /proc/cpuinfo does not update frequency
Date: Fri, 22 Sep 2017 05:01:24 +0000
Message-ID: <bug-197009-137361-d7PkbrOms7@https.bugzilla.kernel.org/>
References: <bug-197009-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.wl.linuxfoundation.org ([198.145.29.98]:52230 "EHLO
        mail.wl.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751358AbdIVFCA (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 22 Sep 2017 01:02:00 -0400
Received: from mail.wl.linuxfoundation.org (localhost [127.0.0.1])
        by mail.wl.linuxfoundation.org (Postfix) with ESMTP id B62D9297C2
        for <linux-pm@vger.kernel.org>; Fri, 22 Sep 2017 05:01:59 +0000 (UTC)
In-Reply-To: <bug-197009-137361@https.bugzilla.kernel.org/>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=197009

Viresh Kumar (viresh.kumar@linaro.org) changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |viresh.kumar@linaro.org

--- Comment #3 from Viresh Kumar (viresh.kumar@linaro.org) ---
(In reply to Doug Smythies from comment #1)
> That is correct, and was intentional. It just lists tsc now.
> 
> To get the actual CPU frequencies, you have to use:
> 
> cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq
> 
> Or, I guess, more correctly these days:
> 
> cat /sys/devices/system/cpu/cpufreq/policy*/scaling_cur_freq

They are both pointing to the same file. The former is link to the later one.

-- 
You are receiving this mail because:
You are the assignee for the bug.
