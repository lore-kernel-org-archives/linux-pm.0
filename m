From: bugzilla-daemon@bugzilla.kernel.org
Subject: [Bug 177171] New: Reduced frequency window for conservative governor
Date: Mon, 10 Oct 2016 15:43:23 +0000
Message-ID: <bug-177171-137361@https.bugzilla.kernel.org/>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.136]:51246 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752286AbcJJPne (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 10 Oct 2016 11:43:34 -0400
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 1CE2D20279
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2016 15:43:25 +0000 (UTC)
Received: from bugzilla2.web.kernel.org (bugzilla2.web.kernel.org [172.20.200.52])
        by mail.kernel.org (Postfix) with ESMTP id 0D19C201BC
        for <linux-pm@vger.kernel.org>; Mon, 10 Oct 2016 15:43:24 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org

https://bugzilla.kernel.org/show_bug.cgi?id=177171

            Bug ID: 177171
           Summary: Reduced frequency window for conservative governor
           Product: Power Management
           Version: 2.5
    Kernel Version: 4.8
          Hardware: All
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: cpufreq
          Assignee: linux-pm@vger.kernel.org
          Reporter: aleksey@rybalkin.org
        Regression: No

Hello.

Since 4.8 the conservative governor has a reduced frequency window on my
machine (ThinkPad X250), despite correct values for scaling_{min,max}_freq

$ cat /sys/devices/system/cpu/cpufreq/policy0/scaling_{min,max}_freq
500000
2200000

The actual window became from 2000000 to 2200000 with accordingly more heating
and more cpu fan activations, which is not optimal.

I have bisected the problem to this commit: 

commit d352cf47d93e39494b44b792cca8d35a3a0bd9b3
Author: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Date:   Mon Jun 13 23:33:49 2016 +0200

    cpufreq: conservative: Do not use transition notifications

    The conservative governor registers a transition notifier so it
    can update its internal requested_freq value if it falls out of the
    policy->min...policy->max range, but requested_freq is not really
    necessary.

    That value is used to track the frequency requested by the governor
    previously, but policy->cur can be used instead of it and then the
    governor will not have to worry about updating the tracked value when
    the current frequency changes independently (for example, as a result
    of min or max changes).

    Accodringly, drop requested_freq from struct cs_policy_dbs_info
    and modify cs_dbs_timer() to use policy->cur instead of it.
    While at it, notice that __cpufreq_driver_target() clamps its
    target_freq argument between policy->min and policy->max, so
    the callers of it don't have to do that and make additional
    changes in cs_dbs_timer() in accordance with that.

    After these changes the transition notifier used by the conservative
    governor is not necessary any more, so drop it, which also makes it
    possible to drop the struct cs_governor definition and simplify the
    code accordingly.

    Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
    Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
You are receiving this mail because:
You are the assignee for the bug.
