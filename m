From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/2] cpufreq: Upstream Android's Interactive governor
Date: Wed, 14 Sep 2016 14:19:39 +0530
Message-ID: <cover.1473842301.git.viresh.kumar@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:35036 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753254AbcINIuP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 14 Sep 2016 04:50:15 -0400
Received: by mail-pf0-f173.google.com with SMTP id z123so3654828pfz.2
        for <linux-pm@vger.kernel.org>; Wed, 14 Sep 2016 01:50:14 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, rostedt@goodmis.org, mingo@redhat.com, peterz@infradead.org, mike@android.com, toddpoynor@google.com, kandoiruchi@google.com, juri.lelli@arm.com, steve.muckle@linaro.org, vincent.guittot@linaro.org, john.stultz@linaro.org, amit.pundir@linaro.org, Viresh Kumar <viresh.kumar@linaro.org>

Hi Rafael et. al.,

We had some discussions [1] earlier on the PM mailing about
upstreaming the cpufreq governor most widely used on Android Mobile
phones and tablets: Interactive governor.

People (including Rafael) mostly agreed that we better get it upstreamed
and here is an attempt to upstream most of it (idle notifiers aren't
included in this series).

I picked the latest code spread over 70-80 patches from [2].  The
unmodified code, based over mainline is pushed [4] for reference.

I have updated the governor to align it with the current practices
followed with mainline governors, like using utilization hooks from the
scheduler and handling kobject (for governor's sysfs directory) in a
race free manner. And of course this included general cleanup of the
governor as well. This version is pushed here [3] for testing.

The Android version of interactive governor also uses idle EXIT
notifiers, but that code isn't part of this series and will be sent
separately later. For people interested in looking at that, those are 3
minor patches on top of this series and are pushed here [5].

I haven't changed the core logic of the governor intentionally, as that
rather requires more in-depth knowledge of the use case for which the
optimizations have been done. So, we should do any such thing later on
with new patches, so that people can fix regressions easily.

I also haven't tried to change the userspace interface as that may have
broken the userspace that already exists and uses this governor.

This has been lightly tested on my Exynos board (dual ARM A15), where
the governor gets inserted/removed multiple times, the sysfs files are
all functional. The frequency gets changed with load, etc.

Amit Pundir (Linaro) has done extensive testing with Android and
compared results of both Original Interactive governor and the modified
one (in this series) and found them to be comparable.

This series is based of pm/bleeding-edge branch.

V1->V2:
- Changes to fix compilation issues with latest mainline
- Timer APIs got updated
 - s/mod_timer_pinned/mod_timer
 - s/init_timer/init_timer_pinned
- Updated prototypes of cpufreq_frequency_table_target() and
  update_util_handler()

--
viresh

[1] http://marc.info/?l=linux-pm&m=146301864519072
[2] https://android.googlesource.com/kernel/common remotes/android/android-4.4
[3] git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/interactive
[4] git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/interactive-orig
[5] git://git.kernel.org/pub/scm/linux/kernel/git/vireshk/pm.git cpufreq/intearctive-idle-notifier

Viresh Kumar (2):
  cpufreq: Move gov_attr_* macros to cpufreq.h
  cpufreq: Add android's 'interactive' governor

 Documentation/cpu-freq/governors.txt       |   86 ++
 drivers/cpufreq/Kconfig                    |   30 +
 drivers/cpufreq/Makefile                   |    1 +
 drivers/cpufreq/cpufreq_governor.h         |    8 -
 drivers/cpufreq/cpufreq_interactive.c      | 1363 ++++++++++++++++++++++++++++
 include/linux/cpufreq.h                    |   12 +
 include/trace/events/cpufreq_interactive.h |  112 +++
 kernel/sched/cpufreq_schedutil.c           |    8 +-
 8 files changed, 1608 insertions(+), 12 deletions(-)
 create mode 100644 drivers/cpufreq/cpufreq_interactive.c
 create mode 100644 include/trace/events/cpufreq_interactive.h

-- 
2.7.1.410.g6faf27b

