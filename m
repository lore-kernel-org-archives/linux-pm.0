From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH V2 0/5] cpufreq: Use QoS layer to manage freq-constraints
Date: Thu, 21 Feb 2019 16:59:26 +0530
Message-ID: <cover.1550748118.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rafael Wysocki <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Kevin Hilman <khilman@kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, mka@chromium.org, juri.lelli@gmail.com, Qais.Yousef@arm.com, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hello,

This patchset attempts to manage CPU frequency constraints using the PM
QoS framework. It only does the basic stuff right now and moves the
userspace constraints to use the QoS infrastructure.

Todo:
- Migrate all users to the QoS framework and get rid of cpufreq specific
  notifiers.
- Make PM QoS learn about the relation of CPUs in a policy, so a single
  list of constraints is managed for all of them instead of per-cpu
  constraints.

V1->V2:
- The previous version introduced a completely new framework, this one
  moves to PM QoS instead.
- Lots of changes because of this.

--
viresh

Viresh Kumar (5):
  PM / QOS: Pass request type to dev_pm_qos_{add|remove}_notifier()
  PM / QOS: Pass request type to dev_pm_qos_read_value()
  PM / QoS: Add support for MIN/MAX frequency constraints
  cpufreq: Register notifiers with the PM QoS framework
  cpufreq: Add QoS requests for userspace constraints

 Documentation/power/pm_qos_interface.txt |  12 +-
 drivers/base/power/domain.c              |   8 +-
 drivers/base/power/domain_governor.c     |   4 +-
 drivers/base/power/qos.c                 | 115 +++++++++++--
 drivers/base/power/runtime.c             |   2 +-
 drivers/cpufreq/cpufreq.c                | 202 ++++++++++++++++-------
 drivers/cpuidle/governor.c               |   2 +-
 include/linux/cpufreq.h                  |  12 +-
 include/linux/pm_qos.h                   |  71 ++++++--
 9 files changed, 323 insertions(+), 105 deletions(-)

-- 
2.21.0.rc0.269.g1a574e7a288b
