Return-Path: <SRS0=ntCr=5U=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1418BC2BA15
	for <linux-pm@archiver.kernel.org>; Sat,  4 Apr 2020 19:29:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C80D62071C
	for <linux-pm@archiver.kernel.org>; Sat,  4 Apr 2020 19:29:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="O3RWMiL7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726269AbgDDT3X (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 4 Apr 2020 15:29:23 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:2454 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726258AbgDDT3X (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 4 Apr 2020 15:29:23 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5e88e0040000>; Sat, 04 Apr 2020 12:29:09 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sat, 04 Apr 2020 12:29:22 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sat, 04 Apr 2020 12:29:22 -0700
Received: from HQMAIL107.nvidia.com (172.20.187.13) by HQMAIL111.nvidia.com
 (172.20.187.18) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sat, 4 Apr
 2020 19:29:21 +0000
Received: from hqnvemgw03.nvidia.com (10.124.88.68) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3 via Frontend
 Transport; Sat, 4 Apr 2020 19:29:21 +0000
Received: from sumitg-l4t.nvidia.com (Not Verified[10.24.37.103]) by hqnvemgw03.nvidia.com with Trustwave SEG (v7,5,8,10121)
        id <B5e88e00e0000>; Sat, 04 Apr 2020 12:29:21 -0700
From:   Sumit Gupta <sumitg@nvidia.com>
To:     <rjw@rjwysocki.net>, <viresh.kumar@linaro.org>,
        <catalin.marinas@arm.com>, <will@kernel.org>,
        <thierry.reding@gmail.com>, <jonathanh@nvidia.com>,
        <talho@nvidia.com>, <linux-pm@vger.kernel.org>,
        <linux-tegra@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <bbasu@nvidia.com>, <sumitg@nvidia.com>, <mperttunen@nvidia.com>
Subject: [TEGRA194_CPUFREQ Patch v2 0/3] Add cpufreq driver for Tegra194 
Date:   Sun, 5 Apr 2020 00:59:04 +0530
Message-ID: <1586028547-14993-1-git-send-email-sumitg@nvidia.com>
X-Mailer: git-send-email 2.7.4
X-NVConfidentiality: public
MIME-Version: 1.0
Content-Type: text/plain
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1586028549; bh=ITK3P8Lpo3/BUJoeRA6qOlDnXfyv8xAa8YmjBZBRX2o=;
        h=X-PGP-Universal:From:To:CC:Subject:Date:Message-ID:X-Mailer:
         X-NVConfidentiality:MIME-Version:Content-Type;
        b=O3RWMiL78Yri78v66kd2ilnAGd0zonL7JvmgbMnVo9ZURwhZZRVaYR95PJV8eHXCe
         0MtuxKwZ5kZBwCtYmJ0qaydDUCpiTEfUIScBK65yM8qzt3areo2cMmRMCw9r8ERlC+
         jrM+oqV/oLAbi2HreKbIDbKXhOehsbfgVm1Mzhcgps+HeI5sQxJb9AmILbrDto03bv
         PcqNCG+aL1UTWex68BN0OYJmbyzCaDRNKiMwu3ybZG2NZ0bdLMvefc8Miq1OBPHTP3
         ScoS5lZAahHg7gJKgtY5RhS7PiOOU4lUxo/TbzP358iH57vFDSJ+muBmHDGuN+OXdH
         wAw14V+fcMJxQ==
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The patch series adds cpufreq driver for Tegra194 SOC.

v1[1] -> v2:
- Remove cpufreq_lock mutex from tegra194_cpufreq_set_target [Viresh].
- Remove CPUFREQ_ASYNC_NOTIFICATION flag [Viresh].
- Remove redundant _begin|end() call from tegra194_cpufreq_set_target.
- Rename opp_table to freq_table [Viresh].

Sumit Gupta (3):
  firmware: tegra: adding function to get BPMP data
  cpufreq: Add Tegra194 cpufreq driver
  arm64: defconfig: Enable CONFIG_ARM_TEGRA194_CPUFREQ

 arch/arm64/configs/defconfig       |   1 +
 drivers/cpufreq/Kconfig.arm        |   6 +
 drivers/cpufreq/Makefile           |   1 +
 drivers/cpufreq/tegra194-cpufreq.c | 412 +++++++++++++++++++++++++++++++++++++
 drivers/firmware/tegra/bpmp.c      |  38 ++++
 include/soc/tegra/bpmp.h           |   5 +
 6 files changed, 463 insertions(+)
 create mode 100644 drivers/cpufreq/tegra194-cpufreq.c

[1] https://marc.info/?t=157539452300001&r=1&w=2
-- 
2.7.4

