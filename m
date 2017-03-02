From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/3] cupfreq: schedutil: Minor fix and cleanups
Date: Thu,  2 Mar 2017 14:03:19 +0530
Message-ID: <cover.1488437503.git.viresh.kumar@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

The first patch fixes an issue and the other two do cleanups. I have run
hackbench with these patches and no regressions were noticed.

--
viresh

Viresh Kumar (3):
  cpufreq: schedutil: move cached_raw_freq to struct sugov_policy
  cpufreq: schedutil: Pass sg_policy to get_next_freq()
  cpufreq: schedutil: remove redundant code from
    sugov_next_freq_shared()

 kernel/sched/cpufreq_schedutil.c | 37 +++++++++++++------------------------
 1 file changed, 13 insertions(+), 24 deletions(-)

-- 
2.7.1.410.g6faf27b
