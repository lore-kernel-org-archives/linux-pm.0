From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v4] powernv: Dynamic Frequency Scaling Enablement
Date: Wed, 26 Mar 2014 22:25:46 +0530
Message-ID: <1395852947-22290-1-git-send-email-ego@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e23smtp05.au.ibm.com ([202.81.31.147]:59518 "EHLO
	e23smtp05.au.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932121AbaCZQ4K (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 26 Mar 2014 12:56:10 -0400
Received: from /spool/local
	by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <ego@linux.vnet.ibm.com>;
	Thu, 27 Mar 2014 02:56:07 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
	by d23dlp02.au.ibm.com (Postfix) with ESMTP id E98A92BB003F
	for <linux-pm@vger.kernel.org>; Thu, 27 Mar 2014 03:56:03 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id s2QGtmqc65339454
	for <linux-pm@vger.kernel.org>; Thu, 27 Mar 2014 03:55:49 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
	by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id s2QGu10t027247
	for <linux-pm@vger.kernel.org>; Thu, 27 Mar 2014 03:56:01 +1100
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, benh@kernel.crashing.org
Cc: linuxppc-dev@ozlabs.org, Linux PM list <linux-pm@vger.kernel.org>, svaidy@linux.vnet.ibm.com, srivatsa.bhat@linux.vnet.ibm.com, Anton Blanchard <anton@samba.org>, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Hi,

This is the v4 of the patchset to enable Dynamic Frequency Scaling
on IBM PowerNV Platforms. I have incorporated the review comments
from the previous version (can be found at [1]). 

In this version, 

  * Multiple patches from the previous version have been into a single
    patch, since the higher numbered patches implemented some helper
    functions and the driver methods which should have been a part of
    the first patch to begin with.

  * Use the generic helpers provided by the cpufreq core available in
    the latest linux-next tree.

  * Fix the code to avoid casting integer pointers to void.

The patch is based on top of the commit:06ed26d1de59ce7cbbe68378b7e470be169750e5
of the linux-next tree.


[1]: https://www.mail-archive.com/linuxppc-dev@lists.ozlabs.org/msg76675.html

Vaidyanathan Srinivasan (1):
  powernv, cpufreq: cpufreq driver for powernv platform

 arch/powerpc/configs/pseries_defconfig    |   1 +
 arch/powerpc/configs/pseries_le_defconfig |   1 +
 arch/powerpc/include/asm/reg.h            |   4 +
 arch/powerpc/platforms/powernv/Kconfig    |   6 +
 drivers/cpufreq/Kconfig.powerpc           |   8 +
 drivers/cpufreq/Makefile                  |   1 +
 drivers/cpufreq/powernv-cpufreq.c         | 372 ++++++++++++++++++++++++++++++
 7 files changed, 393 insertions(+)
 create mode 100644 drivers/cpufreq/powernv-cpufreq.c

-- 
1.8.3.1

