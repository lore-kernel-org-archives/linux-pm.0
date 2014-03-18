From: dirk.brandewie@gmail.com
Subject: [PATCH v3 0/2] Add stop callback to the cpufreq_driver interface.
Date: Tue, 18 Mar 2014 10:22:39 -0700
Message-ID: <1395163361-26380-1-git-send-email-dirk.j.brandewie@intel.com>
References: <1394831037-15553-1-git-send-email-dirk.j.brandewie@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1394831037-15553-1-git-send-email-dirk.j.brandewie@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, rjw@rjwysocki.net, patrick.marlier@gmail.com, viresh.kumar@linaro.org, srivatsa.bhat@linux.vnet.ibm.com, dirk.brandewie@gmail.com, Dirk Brandewie <dirk.j.brandewie@intel.com>
List-Id: linux-pm@vger.kernel.org

From: Dirk Brandewie <dirk.j.brandewie@intel.com>

Changes: 
v2->v3
Changed the calling of the ->stop() callback to be conditional on the
core being the last core controlled by a given policy.

v1->2
Change name of callback function added to cpufreq_driver interface.

Some drivers (intel_pstate) need to modify state on a core before it
is completely offline.  The ->exit() callback is executed during the
CPU_POST_DEAD phase of the cpu offline process which is too late to
change the state of the core.

Patch 1 adds an optional callback function to the cpufreq_driver
interface which is called by the core during the CPU_DOWN_PREPARE
phase of cpu offline in __cpufreq_remove_dev_prepare().

Patch 2 changes intel_pstate to use the ->stop callback to do
its cleanup during cpu offline. 

Dirk Brandewie (2):
  cpufreq: Add exit_prepare callback to cpufreq_driver interface
  intel_pstate: Set core to min P state during core offline

 Documentation/cpu-freq/cpu-drivers.txt |  8 +++++++-
 drivers/cpufreq/cpufreq.c              |  3 +++
 drivers/cpufreq/intel_pstate.c         | 20 +++++++++++++-------
 include/linux/cpufreq.h                |  1 +
 4 files changed, 24 insertions(+), 8 deletions(-)

-- 
1.8.3.1
