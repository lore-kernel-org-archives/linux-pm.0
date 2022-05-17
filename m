Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E75D6C433F5
	for <linux-pm@archiver.kernel.org>; Tue, 17 May 2022 22:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbiEQWdU (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 17 May 2022 18:33:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiEQWdU (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 17 May 2022 18:33:20 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170443EABA;
        Tue, 17 May 2022 15:33:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1652826799; x=1684362799;
  h=from:to:cc:subject:date:message-id;
  bh=ktE04coO5bw2iUMOgThFEuycIpP9WgRpewz8e7wF3Ys=;
  b=dfFpUQCmdF+GPbwA+qeu7CA4BJ00tDcbpZRk9McNav+96Js1WM9JVnfT
   TpxVtjn4cV0iLEuqp2BT+nDijmh1GNva/EF0jfGLBSAz9RGIACFddb5Ld
   9ohNFqRvxT9japi5phaJLa9Tb0zJcHwrmoOaZ7TKI2JAuJmkFx4DnI3Nd
   VjoN8IV/MkieWvfONYogISW63T3Uo4gVuQ1MvZtK2doB6FMDK7fB4slFf
   2GqTL7LCiPMv5IljxhkCmMLc/KCT4tCfDQORkbHEBPSZmd7dxJaEz5f6J
   fJ6YmjQIqdG8Ri+0ePJYDf7VZnhUK52Fuq3GHYrjGXiyaPdNPRpl9roKA
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10350"; a="268945486"
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="268945486"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 15:33:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,233,1647327600"; 
   d="scan'208";a="555993791"
Received: from chang-linux-3.sc.intel.com ([172.25.66.173])
  by orsmga002.jf.intel.com with ESMTP; 17 May 2022 15:33:18 -0700
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-pm@vger.kernel.org
Cc:     tglx@linutronix.de, dave.hansen@linux.intel.com,
        peterz@infradead.org, bp@alien8.de, rafael@kernel.org,
        ravi.v.shankar@intel.com, chang.seok.bae@intel.com
Subject: [PATCH v4 0/2] x86/fpu: Make AMX state ready for CPU idle
Date:   Tue, 17 May 2022 15:24:28 -0700
Message-Id: <20220517222430.24524-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

First of all, my apologies for the long delay with my vacation.

Changes from v3 [1]:
* Call out AMX state only needs to be initialized for CPU idle (Thomas).
* Drop the XCR0 accessor changes as not relevant (Dave).

The series is available here:
  git://github.com/intel/amx-linux.git tilerelease

=== Original Cover Letter ===

AMX state is a large state (at least 8KB or more). Entering CPU idle with
this non-initialized large state may result in shallow states while a
deeper low-power state is available.

We can confirm this behavior is implementation-specific. Section 3.3 in [2]
will be updated to clarify this.

Thanks,
Chang

[1]: https://lore.kernel.org/lkml/20220325022219.829-1-chang.seok.bae@intel.com/
[2]: Intel Architecture Instruction Set Extension Programming Reference
     May 2021, https://software.intel.com/content/dam/develop/external/us/en/documents-tps/architecture-instruction-set-extensions-programming-reference.pdf

Chang S. Bae (2):
  x86/fpu: Add a helper to prepare AMX state for low-power CPU idle
  intel_idle: Add a new flag to initialize the AMX state

 arch/x86/include/asm/fpu/api.h       |  2 ++
 arch/x86/include/asm/special_insns.h |  9 +++++++++
 arch/x86/kernel/fpu/core.c           | 13 +++++++++++++
 drivers/idle/intel_idle.c            | 18 ++++++++++++++++--
 4 files changed, 40 insertions(+), 2 deletions(-)


base-commit: 42226c989789d8da4af1de0c31070c96726d990c
-- 
2.17.1

