From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: [PATCH 0/5] Cpufreq fixes related to cpu hotplug/sysfs-writes
Date: Sat, 07 Sep 2013 01:22:44 +0530
Message-ID: <20130906195206.26919.20884.stgit@srivatsabhat.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: rjw@sisk.pl, sboyd@codeaurora.org, viresh.kumar@linaro.org
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org


Hi,

This patchset solves the cpufreq synchronization problems related to CPU
hotplug and writes to cpufreq sysfs files. The problem was reported and
described by Stephen Boyd here:

https://lkml.org/lkml/2013/8/27/643
https://lkml.org/lkml/2013/8/30/597

All the patches apply on Rafael's bleeding-edge branch on linux-pm git
tree[1].

[1]. git://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge


 Srivatsa S. Bhat (5):
      cpufreq: Split __cpufreq_remove_dev() into 2 parts (kobj cleanup & the rest)
      cpufreq: Invoke __cpufreq_remove_dev_finish() after releasing cpu_hotplug.lock
      cpufreq: Synchronize the cpufreq store_*() routines with CPU hotplug
      cpufreq: Remove temporary fix for race between CPU hotplug and sysfs-writes
      cpufreq: Use signed type for 'ret' variable, to store negative error values

 drivers/cpufreq/cpufreq.c |   90 ++++++++++++++++++++++++++++++++++-----------
 include/linux/cpufreq.h   |    1 -
 2 files changed, 68 insertions(+), 23 deletions(-)


Thanks,
Srivatsa S. Bhat
IBM Linux Technology Center

