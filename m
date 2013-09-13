From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH 0/2] cpufreq: fix transition_ongoing count for powernow-k8
Date: Fri, 13 Sep 2013 18:29:37 +0530
Message-ID: <cover.1379062834.git.viresh.kumar@linaro.org>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

This has been running in my mind since few days... That we have fixed cpufreq
core and all other drivers for transition serialization but what about
powernow-k8? It is somewhat special (even more than exynos5440).. It queues a
work from ->target() and may or maynot send notifications at all..

Finally I have got a solution now (detailed logs in the patch)..
These must go with following patchset:

https://lkml.org/lkml/2013/9/12/173

Compile tested only..

Viresh Kumar (2):
  cpufreq: Create cpufreq_transition_complete()
  cpufreq: powernow-k8: mark freq transition complete on error cases

 drivers/cpufreq/cpufreq.c     | 25 ++++++++++++-----------
 drivers/cpufreq/powernow-k8.c | 47 +++++++++++++++++++++++++++++++------------
 include/linux/cpufreq.h       |  7 +++++++
 3 files changed, 54 insertions(+), 25 deletions(-)

-- 
1.7.12.rc2.18.g61b472e

