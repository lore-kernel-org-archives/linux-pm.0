From: Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/2][RFC v2] Update the cpuinfo.max when power supply changes
Date: Fri,  1 Mar 2019 02:06:54 +0800
Message-ID: <cover.1551375162.git.yu.c.chen@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Len Brown <len.brown@intel.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, yu.chen.surf@gmail.com, Chen Yu <yu.c.chen@intel.com>
List-Id: linux-pm@vger.kernel.org

On Dell Inc. XPS13 9333, the BIOS changes the value of
MSR_IA32_MISC_ENABLE_TURBO_DISABLE at runtime (e.g., when
the power source changes), the maximum frequency of the
CPU is not updated accordingly. This is due to the policy's
cpuinfo.max is not updated when _PPC notifier fires.

Firstly we should update the cpuinfo.max in this corner case,
secondly we should broadcast the _PPC notifier to all online
CPUs to keep information consistent.

Chen Yu (2):
  ACPI: add "processor.broadcast_ppc" hook to broadcast  _PPC
  ACPI: Update cpuinfo.max after bootup if necessary

 drivers/acpi/processor_perflib.c | 16 ++++++++++++++--
 drivers/cpufreq/cpufreq.c        |  2 ++
 drivers/cpufreq/intel_pstate.c   | 15 +++++++++++++--
 3 files changed, 29 insertions(+), 4 deletions(-)

-- 
2.17.1
