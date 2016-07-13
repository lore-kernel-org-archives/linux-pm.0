From: Steve Muckle <steve.muckle@linaro.org>
Subject: [PATCH v3 0/3] cpufreq: avoid redundant driver calls in schedutil
Date: Wed, 13 Jul 2016 13:25:24 -0700
Message-ID: <1468441527-23534-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f181.google.com ([209.85.192.181]:36712 "EHLO
	mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbcGMUZh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 13 Jul 2016 16:25:37 -0400
Received: by mail-pf0-f181.google.com with SMTP id t190so21836326pfb.3
        for <linux-pm@vger.kernel.org>; Wed, 13 Jul 2016 13:25:36 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Steve Muckle <smuckle@linaro.org>

Invoking the cpufreq driver to set a frequency can be expensive. On platforms
with a cpufreq driver that does not support fast switching a thread must be
woken to complete the operation. IPIs will also occur if and when support to
process remote task wakeups is added in schedutil.

Currently schedutil calculates a raw frequency request from scheduler
utilization data. This raw frequency request does not correlate to supported
cpufreq driver frequencies aside from being capped by the CPU's maximum
frequency. Consequently, there may be many consecutive requests for different
raw frequency values which all translate to the same driver-supported
frequency. For example on a platform with 3 supported frequencies 200MHz,
400MHz, and 600MHz, raw requests for 257MHz, 389MHz, and 307MHz all map to a
driver-supported frequency of 400MHz in schedutil. Assuming these requests were
consecutive and there were no changes in policy limits (min/max), there is no
need to issue the second or third request.

In order to resolve a raw frequency request to a driver-supported one a new
cpufreq API is added, cpufreq_driver_resolve_freq(). This API relies on a new
cpufreq driver callback in the case of ->target() style drivers. Otherwise it
uses the existing frequency table operations.

Lookups are cached both in cpufreq_driver_resolve_freq() (for the benefit of the
driver) and in schedutil.

Changes since v2:
- incorporated feedback from Viresh to use resolve_freq driver callbacks
  only for ->target() style drivers, to use cpufreq's freq table operations,
  and move freq mapping caching into cpufreq policy
Changes since v1:
- incorporated feedback from Rafael to avoid referencing freq_table from
  schedutil by introducing a new cpufreq API

Steve Muckle (3):
  cpufreq: add cpufreq_driver_resolve_freq()
  cpufreq: schedutil: map raw required frequency to driver frequency
  cpufreq: acpi-cpufreq: use cached frequency mapping when possible

 drivers/cpufreq/acpi-cpufreq.c   |  5 ++++-
 drivers/cpufreq/cpufreq.c        | 25 +++++++++++++++++++++++++
 include/linux/cpufreq.h          | 16 ++++++++++++++++
 kernel/sched/cpufreq_schedutil.c | 31 +++++++++++++++++++++++--------
 4 files changed, 68 insertions(+), 9 deletions(-)

-- 
2.7.3

