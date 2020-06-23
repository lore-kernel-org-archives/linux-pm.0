Return-Path: <SRS0=QwoY=AE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 180A3C433DF
	for <linux-pm@archiver.kernel.org>; Tue, 23 Jun 2020 18:27:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3A85207FF
	for <linux-pm@archiver.kernel.org>; Tue, 23 Jun 2020 18:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733197AbgFWS1J (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 Jun 2020 14:27:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:12868 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1733125AbgFWS1I (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Jun 2020 14:27:08 -0400
IronPort-SDR: To8L2ztHVALr33XCQ7Yiv9ujHC7N3DWdKIvOI3/GKRrt8Rd42RltRJlECVZkFL/gHwYLd4+DY6
 HcRt0hWFh9+w==
X-IronPort-AV: E=McAfee;i="6000,8403,9661"; a="132578328"
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="132578328"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2020 11:27:07 -0700
IronPort-SDR: q3WaV4JvWvoBXHLkISnUzV9G1BEcxUR8oRve9TB9fScZ3aGYWHLiTViPJnEZ6jGCeOo8pKlSA7
 dJ3ob6Df86kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,272,1589266800"; 
   d="scan'208";a="452329750"
Received: from spandruv-mobl.amr.corp.intel.com ([10.255.228.214])
  by orsmga005.jf.intel.com with ESMTP; 23 Jun 2020 11:27:07 -0700
From:   Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To:     rjw@rjwysocki.net, viresh.kumar@linaro.org, lenb@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: cpufreq: intel_pstate: Support raw epp and energy_efficiency
Date:   Tue, 23 Jun 2020 11:27:03 -0700
Message-Id: <20200623182705.1425539-1-srinivas.pandruvada@linux.intel.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

v2
Remove raw value support for EPB

Srinivas Pandruvada (2):
  cpufreq: intel_pstate: Allow enable/disable energy efficiency
  cpufreq: intel_pstate: Allow raw energy performance preference value

 Documentation/admin-guide/pm/intel_pstate.rst | 13 ++-
 drivers/cpufreq/intel_pstate.c                | 99 ++++++++++++++++---
 2 files changed, 99 insertions(+), 13 deletions(-)

-- 
2.25.4

