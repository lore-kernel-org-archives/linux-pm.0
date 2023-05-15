Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDF1AC7EE2D
	for <linux-pm@archiver.kernel.org>; Mon, 15 May 2023 09:29:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbjEOJ3E (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 15 May 2023 05:29:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239726AbjEOJ23 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 May 2023 05:28:29 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2B31213E;
        Mon, 15 May 2023 02:27:50 -0700 (PDT)
Received: from kwepemi500024.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4QKYrZ6M36zsRm8;
        Mon, 15 May 2023 17:25:50 +0800 (CST)
Received: from huawei.com (10.175.124.27) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Mon, 15 May
 2023 17:27:48 +0800
From:   Zeng Heng <zengheng4@huawei.com>
To:     <lenb@kernel.org>, <viresh.kumar@linaro.org>, <rafael@kernel.org>
CC:     <weiyongjun1@huawei.com>, <linux-pm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>,
        <linux-acpi@vger.kernel.org>, <liwei391@huawei.com>,
        <wangxiongfeng2@huawei.com>
Subject: [PATCH 0/2] drivers/cpufreq: gain accurate CPU frequency from cpufreq/scaling_cur_freq
Date:   Mon, 15 May 2023 18:00:05 +0800
Message-ID: <20230515100005.3540793-3-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230515100005.3540793-1-zengheng4@huawei.com>
References: <20230515100005.3540793-1-zengheng4@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500024.china.huawei.com (7.221.188.100)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

When users want to get frequency by scaling_cur_freq under cpufreq sysfs,
they often get the invalid result like:

$ cat /sys/devices/system/cpu/cpu6/cpufreq/scaling_cur_freq
4294967295

So this series provides fixes to the concerned issue.

Zeng Heng (2):
  cpufreq: CPPC: keep target core awake when reading its cpufreq rate
  acpi: CPPC: read delivered_reg and reference_reg in critical section

 drivers/acpi/cppc_acpi.c       |  4 ++++
 drivers/cpufreq/cppc_cpufreq.c | 30 ++++++++++++++++--------------
 2 files changed, 20 insertions(+), 14 deletions(-)

--
2.25.1

