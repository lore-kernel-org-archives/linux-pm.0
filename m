From: Sudeep Holla <sudeep.holla@arm.com>
Subject: [PATCH v2 0/2] drivers: remove incorrect usage/dependency on topology_physical_package_id
Date: Wed, 10 Jan 2018 16:44:13 +0000
Message-ID: <1515602655-12740-1-git-send-email-sudeep.holla@arm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from foss.arm.com ([217.140.101.70]:45360 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S965974AbeAJQoi (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Jan 2018 11:44:38 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-amlogic@lists.infradead.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
Cc: Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Jeremy Linton <jeremy.linton@arm.com>, Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>

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
For now, we can leave that as is until we change the definition even for
ARM32 platforms as it's just used by only 32-bit platforms.

v1->v2:
	- Update change log in patch 1/2 as suggested by Lorenzo
	- Added acks from Viresh and Lorenzo

Sudeep Holla (2):
  drivers: psci: remove cluster terminology and dependency on
    physical_package_id
  cpufreq: scpi: remove arm_big_little dependency

 drivers/cpufreq/scpi-cpufreq.c  | 193 ++++++++++++++++++++++++++++++++++++----
 drivers/firmware/psci_checker.c |  46 +++++-----
 2 files changed, 200 insertions(+), 39 deletions(-)

--
2.7.4
