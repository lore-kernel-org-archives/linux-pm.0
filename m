From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: [PATCH 0/2] RFC: CPU frequency max as PM QoS param
Date: Thu, 19 Jan 2012 14:35:57 +0200
Message-ID: <1326976559-4009-1-git-send-email-amiettinen@nvidia.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: davej@redhat.com, pavel@ucw.cz, rjw@sisk.pl, len.brown@intel.com, khilman@ti.com, j-pihet@ti.com, markgross@thegnar.org, cpufreq@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

This is a continuation to "RFC: CPU frequency min as PM QoS param"
patchset. This patchset adds CPU frequency maximum as a PM QoS
parameter and modifies CPU frequncy core to enforce the limit. CPU
frequency ceiling can be used to improve the energy efficiency of
workloads that would cause the cpufreq governors to enforce an
unnecessarily high operating point. In other words, CPU frequency
maximum can act as an energy efficiency level request.

Tested on Dell E6420 with the ACPI cpufreq driver against Ubuntu
3.2. Patches are against linux-next, compile tested.

Antti P Miettinen (2):
  PM QoS: Add CPU frequency maximum as PM QoS param
  cpufreq: Enforce PM QoS maximum frequency

 drivers/cpufreq/cpufreq.c |   16 +++++++++++++---
 include/linux/pm_qos.h    |    2 ++
 kernel/power/qos.c        |   15 +++++++++++++++
 3 files changed, 30 insertions(+), 3 deletions(-)

-- 
1.7.4.1

