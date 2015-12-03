From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/6] cpufreq: governor: replace per-cpu delayed work with timers
Date: Thu,  3 Dec 2015 09:37:48 +0530
Message-ID: <cover.1449115453.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f44.google.com ([209.85.220.44]:33492 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755111AbbLCEIC (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Dec 2015 23:08:02 -0500
Received: by pabfh17 with SMTP id fh17so61123046pab.0
        for <linux-pm@vger.kernel.org>; Wed, 02 Dec 2015 20:08:01 -0800 (PST)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, ashwin.chaugule@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael,

As suggested by you, this series updates the governor core to keep
per-cpu timers and a shared work for the entire policy.

More details are present in the changelogs, hope they are somewhat
better this time.

I have tested it with the test-suite, that I created sometime back while
fixing locking issues in governors.. Tried all kind of stuff in parallel
that could have broken it (those are the testcases that separate people
reported over time, around governors). It works fine.

The first one is a bug fix really, which I noticed today only :), next
three are minor cleanups to prepare for the big change. Fourth one is
the main patch that does the conversion and the final one is
cherry-picked from the last series as that was still relevant.

This is rebased over: pm/linux-next.

V1->V2:
- Updated first patch to not move variable definitions to the top of the
  routine.
- Last patch had minor rebase conflict due to above change and so is
  updated as well.
- Included RBY tag from Ashwin.
- Rebased over pm/linux-next

Viresh Kumar (6):
  cpufreq: ondemand: Update sampling rate only for concerned policies
  cpufreq: ondemand: Work is guaranteed to be pending
  cpufreq: governor: Pass policy as argument to ->gov_dbs_timer()
  cpufreq: governor: initialize/destroy timer_mutex with 'shared'
  cpufreq: governor: replace per-cpu delayed work with timers
  cpufreq: ondemand: update update_sampling_rate() to make it more
    efficient

 drivers/cpufreq/cpufreq_conservative.c |   6 +-
 drivers/cpufreq/cpufreq_governor.c     | 145 +++++++++++++++++++--------------
 drivers/cpufreq/cpufreq_governor.h     |  23 ++++--
 drivers/cpufreq/cpufreq_ondemand.c     |  61 ++++++++++----
 4 files changed, 145 insertions(+), 90 deletions(-)

-- 
2.6.2.198.g614a2ac

