From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/2] cpufreq: Allow light-weight tear down and bring up of CPUs
Date: Tue, 12 Feb 2019 12:36:45 +0530
Message-ID: <cover.1549955027.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The cpufreq core doesn't remove the cpufreq policy anymore on CPU
offline operation, rather that happens when the CPU device gets
unregistered from the kernel. This allows faster recovery when the CPU
comes back online. This is also very useful during system wide
suspend/resume where we offline all non-boot CPUs during suspend and
then bring them back on resume.

This patcset takes the same idea a step ahead to allow drivers to do
light weight tear-down and bring up during CPU offline/online operations
and updates the cpufreq-dt driver to implement the new helpers.

V1->V2:
- s/light_weight_exit()/offline()
- Also introduce the online() counterpart

Viresh Kumar (2):
  cpufreq: Allow light-weight tear down and bring up of CPUs
  cpufreq: dt: Implement online/offline() callbacks

 drivers/cpufreq/cpufreq-dt.c | 17 +++++++++++
 drivers/cpufreq/cpufreq.c    | 55 +++++++++++++++++++++++-------------
 include/linux/cpufreq.h      |  2 ++
 3 files changed, 55 insertions(+), 19 deletions(-)

-- 
2.20.1.321.g9e740568ce00
