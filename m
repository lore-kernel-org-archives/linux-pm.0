From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [BUG] schedutil governor produces regular max freq spikes because
 of lockup detector watchdog threads
Date: Fri, 5 Jan 2018 22:37:32 +0200
Message-ID: <1515184652.6892.26.camel@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-by2nam03on0078.outbound.protection.outlook.com ([104.47.42.78]:39590
        "EHLO NAM03-BY2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751537AbeAEUhh (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 5 Jan 2018 15:37:37 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael@kernel.org>, Steve Muckle <smuckle@linaro.org>
Cc: Anson Huang <anson.huang@nxp.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

Hello,

When using the schedutil governor together with the softlockup detector
all CPUs go to their maximum frequency on a regular basis. This seems
to be because the watchdog creates a RT thread on each CPU and this
causes regular kicks with:

    cpufreq_update_this_cpu(rq, SCHED_CPUFREQ_RT);

The schedutil governor responds to this by immediately setting the
maximum cpu frequency, this is very undesirable.

The issue can be fixed by this patch from android:
    https://patchwork.kernel.org/patch/9301909/

The patch stalled in a long discussion about how it's difficult for
cpufreq to deal with RT and how some RT users might just disable
cpufreq. It is indeed hard but if the system experiences regular power
kicks from a common debug feature they will end up disabling schedutil
instead. No other governors behave this way, perhaps the current
behavior should be considered a bug in schedutil.

That patch now has conflicts with latest upstream. Perhaps a modified
variant should be reconsidered for inclusion, or is there some other
solution pending?

Alternatively the watchdog threads could be somehow marked as to never
cause increased cpufreq.

--
Regards,
Leonard
