From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v3 0/6] powernv: cpufreq: Report frequency throttle by OCC
Date: Mon,  4 May 2015 14:24:06 +0530
Message-ID: <1430729652-14813-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp02.au.ibm.com ([202.81.31.144]:52085 "EHLO
	e23smtp02.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751570AbbEDJAX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 May 2015 05:00:23 -0400
Received: from /spool/local
	by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <shilpa.bhat@linux.vnet.ibm.com>;
	Mon, 4 May 2015 19:00:21 +1000
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Cc: rjw@rjwysocki.net, viresh.kumar@linaro.org, preeti@linux.vnet.ibm.com, linux-pm@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

This patchset intends to add frequency throttle reporting mechanism
to powernv-cpufreq driver when OCC throttles the frequency. OCC is an
On-Chip-Controller which takes care of the power and thermal safety of
the chip. The CPU frequency can be throttled during an OCC reset or
when OCC tries to limit the max allowed frequency. The patchset will
report such conditions so as to keep the user informed about reason
for the drop in performance of workloads when frequency is throttled.

Changes from v2:
- Split into multiple patches
- Semantic fixes

Shilpasri G Bhat (6):
  cpufreq: poowernv: Handle throttling due to Pmax capping at chip level
  powerpc/powernv: Add definition of OPAL_MSG_OCC message type
  cpufreq: powernv: Register for OCC related opal_message notification
  cpufreq: powernv: Call throttle_check() on receiving OCC_THROTTLE
  cpufreq: powernv: Report Psafe only if PMSR.psafe_mode_active bit is
    set
  cpufreq: powernv: Restore cpu frequency to policy->cur on unthrottling

 arch/powerpc/include/asm/opal-api.h |   8 ++
 drivers/cpufreq/powernv-cpufreq.c   | 199 +++++++++++++++++++++++++++++++++---
 2 files changed, 192 insertions(+), 15 deletions(-)

-- 
1.9.3

