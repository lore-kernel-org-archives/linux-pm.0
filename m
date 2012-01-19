From: Antti P Miettinen <amiettinen@nvidia.com>
Subject: [PATCH v3 0/3] RFC: CPU frequency min as PM QoS param
Date: Thu, 19 Jan 2012 14:34:49 +0200
Message-ID: <1326976492-3970-1-git-send-email-amiettinen@nvidia.com>
Return-path: <cpufreq-owner@vger.kernel.org>
Sender: cpufreq-owner@vger.kernel.org
To: davej@redhat.com, pavel@ucw.cz, rjw@sisk.pl, len.brown@intel.com, khilman@ti.com, j-pihet@ti.com, markgross@thegnar.org, cpufreq@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

The inspiration for this patch series is the N9 CPU frequency boost
upon input events:

http://www.spinics.net/lists/cpufreq/msg00667.html

and the related changes in git://codeaurora.org/kernel/msm.git tree.
Those patches modify the ondemand cpufreq governor. This patch series
adds minimum CPU frequency as PM QoS parameter and modifies the
cpufreq core to enforce the PM QoS limit.

I've been testing these changes against Ubuntu 3.2 kernel on a Dell
E6420 with the ACPI cpufreq driver. The patches are against
linux-next/master, compile tested against it.

V3:
* split max to separate patch set (V2 patches 7 and 8)
* split adding sysfs files to separate patch set (V2 patch 3)
* fold user_policy handling into min enforcement (V2 patches 4 and 5)
* split input event booster to separate patch set (V2 patch 6)

	--Antti

Alex Frid (1):
  PM QoS: Simplify PM QoS expansion/merge

Antti P Miettinen (2):
  PM QoS: Add CPU frequency minimum as PM QoS param
  cpufreq: Enforce PM QoS minimum limit

 drivers/cpufreq/cpufreq.c |   43 ++++++++++++++++++++++++++++++++++++++++---
 include/linux/pm_qos.h    |   17 ++++++++++++-----
 kernel/power/qos.c        |   40 ++++++++++++++++++++++++++--------------
 3 files changed, 78 insertions(+), 22 deletions(-)

-- 
1.7.4.1

