Return-Path: <SRS0=bqaS=U3=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AF91C4321A
	for <linux-pm@archiver.kernel.org>; Fri, 28 Jun 2019 05:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C8882147A
	for <linux-pm@archiver.kernel.org>; Fri, 28 Jun 2019 05:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727039AbfF1Fud (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 28 Jun 2019 01:50:33 -0400
Received: from mga17.intel.com ([192.55.52.151]:54821 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726240AbfF1Fud (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 28 Jun 2019 01:50:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Jun 2019 22:50:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,426,1557212400"; 
   d="scan'208";a="167664530"
Received: from gangcao-mobl2.ccr.corp.intel.com (HELO rzhang-dell-9360.ccr.corp.intel.com) ([10.249.174.16])
  by orsmga006.jf.intel.com with ESMTP; 27 Jun 2019 22:50:30 -0700
From:   Zhang Rui <rui.zhang@intel.com>
To:     rjw@rjwysocki.net
Cc:     linux-pm@vger.kernel.org, srinivas.pandruvada@intel.com,
        rui.zhang@intel.com
Subject: [PATCH 00/13] intel_rapl: RAPL abstraction and MMIO RAPL support
Date:   Fri, 28 Jun 2019 13:50:16 +0800
Message-Id: <1561701029-3415-1-git-send-email-rui.zhang@intel.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Besideis MSR interface, RAPL can also be controlled via the MMIO interface,
by accessing the MCHBar registers exposed by the processor thermal device.

Currently, we only have RAPL MSR interface in Linux kernel, this brings
problems on some platforms that BIOS performs a low power limits via the
MMIO interface by default. This results in poor system performance,
and there is no way for us to change the MMIO MSR setting in Linux.

To fix this, RAPL MMIO interface support is introduced in this patch set.

Patch 1/13 to patch 11/13 abstract the RAPL code, and move all the shared
code into a separate file, intel_rapl_common.c, so that it can be used
by both MSR and MMIO interfaces.
Patch 12/13 introduced RAPL support via MMIO registers, exposed by the
processor thermal devices.
Patch 13/13 fixes a module autoloading issue found later.

The patch series has been tested on Dell XPS 9360, a SKL platform.

Note that this patch series are based on the -tip tree, which contains the
latest RAPL changes for multi-die support.

thanks,
rui
