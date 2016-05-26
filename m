From: Steve Muckle <steve.muckle@linaro.org>
Subject: [PATCH v2 0/3] cpufreq: avoid redundant driver calls in schedutil
Date: Wed, 25 May 2016 19:52:58 -0700
Message-ID: <1464231181-30741-1-git-send-email-smuckle@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Juri Lelli <Juri.Lelli@arm.com>, Patrick Bellasi <patrick.bellasi@arm.com>, Michael Turquette <mturquette@baylibre.com>
List-Id: linux-pm@vger.kernel.org

In the series [0] I included a patch which attempted to avoid redundant driver
calls in the schedutil governor by mapping the raw required CPU frequencies to
driver frequencies. This vastly increases the likelihood of detecting a
redundant cpufreq driver call, i.e. one which will end up attempting to set the
CPU frequency to the frequency it is already running at. The redundant call can
be avoided. This is especially valuable in the case of drivers which do not
support fast path updates or if remote CPU cpufreq callbacks are implemented.

Unfortunately the implementation of this in [0] walked the frequency table
directly in schedutil. Rafael pointed out that not all drivers may have a
frequency table and that a driver callback might be implemented to return the
driver frequency associated with a particular target frequency. The driver
could then also cache this lookup and possibly use it on an ensuing
fast_switch. This series implements that approach.

Given that this change is beneficial on its own I've split it out into its own
series from the remote callback support.

[0] https://lkml.org/lkml/2016/5/9/853

Steve Muckle (3):
  cpufreq: add resolve_freq driver callback
  cpufreq: acpi-cpufreq: add resolve_freq callback
  cpufreq: schedutil: map raw required frequency to driver frequency

 drivers/cpufreq/acpi-cpufreq.c   | 56 ++++++++++++++++++++++++++++++----------
 drivers/cpufreq/cpufreq.c        | 25 ++++++++++++++++++
 include/linux/cpufreq.h          | 11 ++++++++
 kernel/sched/cpufreq_schedutil.c | 30 +++++++++++++++------
 4 files changed, 101 insertions(+), 21 deletions(-)

-- 
2.4.10
