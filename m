From: Saravana Kannan <skannan@codeaurora.org>
Subject: [PATCH 0/2] Adding support for scaling cache/memory based on CPU frequency
Date: Fri, 18 May 2018 01:24:46 -0700
Message-ID: <1526631889-5084-1-git-send-email-skannan@codeaurora.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, MyungJoo Ham <myungjoo.ham@samsung.com>, Kyungmin Park <kyungmin.park@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Cc: Saravana Kannan <skannan@codeaurora.org>, Rajendra Nayak <rjendra@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Many CPU architectures have caches that can scale independent of the CPUs.
Frequency scaling of the caches is necessary to make sure the cache is not
a performance bottleneck that leads to poor performance and power. The same
idea applies for RAM/DDR.

To achieve this, this patch series adds a generic devfreq governor that can
listen to the frequency transitions of each CPU frequency domain and then
adjusts the frequency of the cache (or any devfreq device) based on the
frequency of the CPUs.

To decide the frequency of the device, the governor does one of the
following:

* Uses a CPU frequency to device frequency mapping table
  - Either one mapping table used for all CPU freq policies (typically used
    for system with homogeneous cores/clusters that have the same OPPs.
  - One mapping table per CPU freq policy (typically used for ASMP systems
    with heterogeneous CPUs with different OPPs)

OR

* Scales the device frequency in proportion to the CPU frequency. So, if
  the CPUs are running at their max frequency, the device runs at its max
  frequency.  If the CPUs are running at their min frequency, the device
  runs at its min frequency. And interpolated for frequencies in between.

Since CPUs/clusters can be hotplugged and their policies disables, this
devfreq governor also has to listen to CPU freq policy notifiers for these
events. So, this patch brings back the policy CREATE/REMOVE notifiers.

Saravana Kannan (2):
  Revert "cpufreq: Remove policy create/remove notifiers"
  PM / devfreq: Generic cpufreq governor

 .../bindings/devfreq/devfreq-cpufreq.txt           |  53 ++
 drivers/cpufreq/cpufreq.c                          |  16 +-
 drivers/devfreq/Kconfig                            |   8 +
 drivers/devfreq/Makefile                           |   1 +
 drivers/devfreq/governor_cpufreq.c                 | 628 +++++++++++++++++++++
 include/linux/cpufreq.h                            |   3 +
 6 files changed, 704 insertions(+), 5 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/devfreq/devfreq-cpufreq.txt
 create mode 100644 drivers/devfreq/governor_cpufreq.c

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
