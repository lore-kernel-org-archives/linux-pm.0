From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 00/10] cpufreq: governor: Further cleanups (v4.3)
Date: Mon, 22 Jun 2015 13:32:47 +0530
Message-ID: <cover.1434959517.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pd0-f180.google.com ([209.85.192.180]:36254 "EHLO
	mail-pd0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755993AbbFVIDI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 22 Jun 2015 04:03:08 -0400
Received: by pdcu2 with SMTP id u2so7347218pdc.3
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2015 01:03:07 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael/Preeti,

As Preeti is still around, I wanted her to Test/Review few more patches
that I had. Sorry Preeti :)

So, this one sits on top of the earlier patches [1], that fixed some
serious crashes for us. And this and the earlier series are both 4.3
material.

This series fixes few more possible race conditions. Over that there is
some non-trivial cleanup, in order to simplify code.

Pushed here:
ssh://git@git.linaro.org/people/viresh.kumar/linux.git cpufreq/gov-locking

--
viresh

[1] lkml.kernel.org/r/cover.1434713657.git.viresh.kumar@linaro.org

Viresh Kumar (10):
  cpufreq: Use __func__ to print function's name
  cpufreq: conservative: Avoid races with transition notifier
  cpufreq: conservative: remove 'enable' field
  cpufreq: ondemand: only queue canceled works from
    update_sampling_rate()
  cpufreq: governor: Drop __gov_queue_work()
  cpufreq: ondemand: Drop unnecessary locks from update_sampling_rate()
  cpufreq: ondemand: queue work for policy->cpus together
  cpufreq: ondemand: update sampling rate immidiately
  cpufreq: governor: Quit work-handlers early if governor is stopped
  cpufreq: Get rid of ->governor_enabled and its lock

 drivers/cpufreq/cpufreq.c              | 27 +----------
 drivers/cpufreq/cpufreq_conservative.c | 38 +++++++++------
 drivers/cpufreq/cpufreq_governor.c     | 86 +++++++++++++++-------------------
 drivers/cpufreq/cpufreq_governor.h     |  3 +-
 drivers/cpufreq/cpufreq_ondemand.c     | 57 +++++++++-------------
 include/linux/cpufreq.h                |  1 -
 6 files changed, 83 insertions(+), 129 deletions(-)

-- 
2.4.0

--
To unsubscribe from this list: send the line "unsubscribe linux-pm" in
