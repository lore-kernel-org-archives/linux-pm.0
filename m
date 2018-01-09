From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH 0/2] drivers: remove incorrect usage/dependency on topology_physical_package_id
Date: Tue,  9 Jan 2018 16:49:26 +0000
Message-ID: <1515516568-31359-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi all,

There has been ongoing attempt to add ACPI topology support on ARM/ARM64
platform using PPTT. However it was discovered that the physical package
id is mapped to the so called clusters on ARM platforms and they don't
map to the physical socket as in other architectures.

In order to add the correct support for the well defined physical sockets,
we need to find remove the incorrect usage or any dependency on
topology_physical_package_id which currently maps to the clusters.

There's still one pending user of topology_physical_package_id, which is
arm_big_little driver which is used by bL switcher and by TC2 platform.
I would like to get some feedback on how to remove that dependency ?
Can we hard-code the cluster values ? Any other suggestions ?

Sudeep Holla (2):
  drivers: psci: remove cluster terminology and dependency on
    physical_package_id
  cpufreq: scpi: remove arm_big_little dependency

 drivers/cpufreq/scpi-cpufreq.c  | 193 ++++++++++++++++++++++++++++++++++++----
 drivers/firmware/psci_checker.c |  46 +++++-----
 2 files changed, 200 insertions(+), 39 deletions(-)

--
2.7.4
