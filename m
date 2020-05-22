Return-Path: <SRS0=ID/Q=7E=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9960FC433E0
	for <linux-pm@archiver.kernel.org>; Fri, 22 May 2020 03:41:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EC3820812
	for <linux-pm@archiver.kernel.org>; Fri, 22 May 2020 03:41:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgEVDlB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 21 May 2020 23:41:01 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:4889 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727080AbgEVDlA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 21 May 2020 23:41:00 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 858741D5D9A6821937A9;
        Fri, 22 May 2020 11:40:58 +0800 (CST)
Received: from linux-ibm.site (10.175.102.37) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.487.0; Fri, 22 May 2020 11:40:48 +0800
From:   Xiongfeng Wang <wangxiongfeng2@huawei.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>
CC:     <Souvik.Chakravarty@arm.com>, <Thanu.Rangarajan@arm.com>,
        <Sudeep.Holla@arm.com>, <guohanjun@huawei.com>,
        <john.garry@huawei.com>, <jonathan.cameron@huawei.com>,
        <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH v4 0/2] add SW BOOST support for CPPC
Date:   Fri, 22 May 2020 11:34:34 +0800
Message-ID: <1590118476-28742-1-git-send-email-wangxiongfeng2@huawei.com>
X-Mailer: git-send-email 1.7.12.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.102.37]
X-CFilter-Loop: Reflected
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

ACPI spec 6.2 section 8.4.7.1 provide the following two CPC registers.

"Highest performance is the absolute maximum performance an individual
processor may reach, assuming ideal conditions. This performance level
may not be sustainable for long durations, and may only be achievable if
other platform components are in a specific state; for example, it may
require other processors be in an idle state.

Nominal Performance is the maximum sustained performance level of the
processor, assuming ideal operating conditions. In absence of an
external constraint (power, thermal, etc.) this is the performance level
the platform is expected to be able to maintain continuously. All
processors are expected to be able to sustain their nominal performance
state simultaneously."

We can use Highest Performance as the max performance in boost mode and
Nomial Performance as the max performance in non-boost mode. If the
Highest Performance is greater than the Nominal Performance, we assume
SW BOOST is supported.

v3->v4:
	run 'boost_set_msr_each' for each CPU in the policy rather than
	each CPU in the system for 'acpi-cpufreq'
	add 'Suggested-by'

Xiongfeng Wang (2):
  cpufreq: change '.set_boost' to act on only one policy
  CPPC: add support for SW BOOST

 drivers/cpufreq/acpi-cpufreq.c | 10 ++++----
 drivers/cpufreq/cppc_cpufreq.c | 39 +++++++++++++++++++++++++++++--
 drivers/cpufreq/cpufreq.c      | 53 +++++++++++++++++++++---------------------
 include/linux/cpufreq.h        |  2 +-
 4 files changed, 71 insertions(+), 33 deletions(-)

-- 
1.7.12.4

