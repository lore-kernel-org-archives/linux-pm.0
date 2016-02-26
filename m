From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v10 0/2] cpufreq: powernv: Export throttle stat attributes and a bug fix
Date: Fri, 26 Feb 2016 16:06:50 +0530
Message-ID: <1456483012-29466-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp04.au.ibm.com ([202.81.31.146]:51404 "EHLO
	e23smtp04.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752855AbcBZKiF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 26 Feb 2016 05:38:05 -0500
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Fri, 26 Feb 2016 20:38:02 +1000
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, linux-pm@vger.kernel.org, ego@linux.vnet.ibm.com, shreyas@linux.vnet.ibm.com, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Patch[1] solves a bug in the module{init/exit} path and Patch[2]
exports the throttle stats for the chip. This patchset is on top of
linux-pm/linux-next.

Changes from v9:
- Patch[1/2] is newly added to correctly handle error path in
  powernv_cpufreq_init() and unregistration path in
  powernv_cpufreq_exit() as suggested by Viresh.
- Patch[2/2] is rebased on top of Patch[1/2].

Shilpasri G Bhat (2):
  cpufreq: powernv: Fix bugs in powernv_cpufreq_{init/exit}
  cpufreq: powernv: Add sysfs attributes to show throttle stats

 Documentation/ABI/testing/sysfs-devices-system-cpu |  69 +++++++++
 drivers/cpufreq/powernv-cpufreq.c                  | 162 ++++++++++++++++++---
 2 files changed, 212 insertions(+), 19 deletions(-)

-- 
1.9.3

