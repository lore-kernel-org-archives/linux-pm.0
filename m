From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V3 0/5] CPUFreq: governors: further cleanups
Date: Tue, 13 Oct 2015 13:39:00 +0530
Message-ID: <cover.1444723240.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36303 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752549AbbJMIJP (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2015 04:09:15 -0400
Received: by pacex6 with SMTP id ex6so14158823pac.3
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2015 01:09:15 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

Here is the third version based on the review comments you gave. I have
tried to resolve most of them, and it looks much better now. Thanks for
your comments.

As I am traveling this week, don't have access to hardware to retest the
series. But I am quite sure it should work just fine, as there weren't
lots of updates from how the final code looked earlier. Anyway, I have
pushed this for the build bot sometime back and it will let us know of
any obvious issues.

V2->V3:
- Few got merged already, and are dropped now
- Patches are reordered a bit to make them more sensible
- gov_queue_work() isn't modified at all with the mask of CPUs, as you
  suggested earlier.
- Some minor commit/logs updated.

V1->V2:
- Dropped 2/10 from V1 as it wasn't required
- 3/10 saw some changes due to above patch being dropped
- 7/10 changed a bit as we check for pending work items by looking at
  shared->policy, rather than calling delayed_work_pending. We wanted to
  check if governor is operational or not and the new check is enough
  for that.

Viresh Kumar (5):
  cpufreq: ondemand: Drop unnecessary locks from update_sampling_rate()
  cpufreq: ondemand: update sampling rate immediately
  cpufreq: ondemand: queue work for policy->cpus together
  cpufreq: governor: Quit work-handlers early if governor is stopped
  cpufreq: Get rid of ->governor_enabled and its lock

 drivers/cpufreq/cpufreq.c          | 24 ------------------
 drivers/cpufreq/cpufreq_governor.c | 33 +++++++++++++++++--------
 drivers/cpufreq/cpufreq_ondemand.c | 50 ++++++++++++--------------------------
 include/linux/cpufreq.h            |  1 -
 4 files changed, 39 insertions(+), 69 deletions(-)

-- 
2.4.0

