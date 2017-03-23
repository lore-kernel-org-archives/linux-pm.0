From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: [PATCH v1 0/2] cpuidle: Fixes in cpuidle driver
Date: Thu, 23 Mar 2017 20:52:45 +0530
Message-ID: <20170323152247.14733-1-svaidy@linux.vnet.ibm.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:40774 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S934745AbdCWPYB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 23 Mar 2017 11:24:01 -0400
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id v2NFNsNp127814
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 11:24:00 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
        by mx0b-001b2d01.pphosted.com with ESMTP id 29cf05fwpe-1
        (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
        for <linux-pm@vger.kernel.org>; Thu, 23 Mar 2017 11:24:00 -0400
Received: from localhost
        by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-pm@vger.kernel.org> from <svaidy@linux.vnet.ibm.com>;
        Fri, 24 Mar 2017 01:23:57 +1000
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Neuling <mikey@neuling.org>, Michael Ellerman <mpe@ellerman.id.au>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

When CONFIG_HOTPLUG_CPU=n and cpu_present is less than cpu_possible,
then cpuidle-powernv not passing an explicit drv->cpu_mask allows
generic cpuidle driver to try create sysfs objects for cpus that does
not have cpu_devices created by calling register_cpu().

This caused kernel to access incorrect address and crash. The
following patch series fixes the cpuidle-powernv driver and also adds
additional checks in cpuidle_add_sysfs()

This patch set is against v4.11-rc3.

Changed from v1: Updated commit message and comments.

Signed-off-by: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
