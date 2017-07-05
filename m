From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 0/5] powernv:idle: Cleanup idle states initialization
Date: Wed,  5 Jul 2017 22:08:11 +0530
Message-ID: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:37554 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751987AbdGEQil (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 5 Jul 2017 12:38:41 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v65GcfcL018990
        for <linux-pm@vger.kernel.org>; Wed, 5 Jul 2017 12:38:41 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2bgmdvcpx9-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Wed, 05 Jul 2017 12:38:40 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
        Wed, 5 Jul 2017 10:38:35 -0600
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>, Nicholas Piggin <npiggin@gmail.com>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Hi,

This patch set aims at cleaning up the powernv idle initialization
code mainly covering the following

a) Currently there is redundant code for parsing the device-tree for
   idle states. We do it in two places, once during the platform idle
   initialization, once more when the cpidle driver initializes. In
   this patchset the device-tree is parsed only once and we maintain
   an in-kernel data structure with the details of each platform idle
   state. The cpu-idle initialization code looks at this data
   structure for initializing cpuidle states. This makes the cpuidle
   driver initialization more streamlined.

b) Currently the idle initialzation code for power8 and power9 are
   mixed up. In this patchset we segregate them into their respective
   functions for improved readability.

c) The current code has a bug when the Sleep-Winkle-Engine is unable
   to restore the hypervisor states for the deep idle states that lose
   full hypervisor context, since in such cases we don't disable such
   deep states. Thus, the CPUs that enter such deep states don't
   wakeup correctly.

Patch 1 in the series addresses a).

Patches 2,3,4 address b)

Patch 5 fixes the bug c)

These patches are applied on top of next branch of the powerpc-linux
git tree. The patches have been tested on POWER8 and POWER9.
   
Gautham R. Shenoy (5):
  powernv:idle: Move device-tree parsing to one place.
  powernv:idle: Change return type of pnv_probe_idle_states to int
  powernv:idle: Define idle init function for power8
  powernv:idle: Move initialization of sibling pacas to
    pnv_alloc_idle_core_states
  powernv:idle: Disable LOSE_FULL_CONTEXT states when stop-api fails.

 arch/powerpc/include/asm/cpuidle.h    |  32 +-
 arch/powerpc/platforms/powernv/idle.c | 576 ++++++++++++++++++++++++++--------
 drivers/cpuidle/cpuidle-powernv.c     | 233 ++++----------
 3 files changed, 521 insertions(+), 320 deletions(-)

-- 
1.9.4
