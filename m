Return-Path: <SRS0=d17u=6C=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FFD8C2BA19
	for <linux-pm@archiver.kernel.org>; Sat, 18 Apr 2020 08:31:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8492021D82
	for <linux-pm@archiver.kernel.org>; Sat, 18 Apr 2020 08:31:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725856AbgDRIbN (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 18 Apr 2020 04:31:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:9878 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725801AbgDRIbM (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 18 Apr 2020 04:31:12 -0400
IronPort-SDR: Rdk0uKTxrCtnJuz2Jtd9nncjie8rJ5PXrBJzY6wxySY8a1EHWuYJlkLUQ44TRTeA8LQrt0x86w
 OHrQ1aQkLFTg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Apr 2020 01:31:11 -0700
IronPort-SDR: hL1EjEYgZTvU2tAV9UO+xA2cb625vugVGc729HMVv1FGFqKwbRjC1RtWx/aeNTO0YrKYNU2TEC
 I4b4xEdTOkRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,398,1580803200"; 
   d="scan'208";a="455864199"
Received: from chenyu-office.sh.intel.com ([10.239.158.173])
  by fmsmga006.fm.intel.com with ESMTP; 18 Apr 2020 01:31:04 -0700
From:   Chen Yu <yu.c.chen@intel.com>
To:     linux-pm@vger.kernel.org
Cc:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Doug Smythies <dsmythies@telus.net>,
        linux-kernel@vger.kernel.org, Chen Yu <yu.c.chen@intel.com>
Subject: [PATCH 0/3][v3] tools/power turbostat: Enable accumulated energy consumption for long time sampling
Date:   Sat, 18 Apr 2020 16:31:34 +0800
Message-Id: <cover.1587196252.git.yu.c.chen@intel.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The RAPL Joule Counter is 32 bit, turbostat would
only print a *star* instead of printing the actual energy
consumed due to the overflow of RAPL register.

Introduce the accumulated RAPL mechanism to avoid the possible
overflow.

Chen Yu (3):
  tools/power turbostat: Make the energy variable to be 64 bit
  tools/power turbostat: Introduce functions to accumulate RAPL
    consumption
  tools/power turbostat: Enable accumulate RAPL display

 tools/power/x86/turbostat/Makefile    |   2 +-
 tools/power/x86/turbostat/turbostat.c | 292 ++++++++++++++++++++++----
 2 files changed, 248 insertions(+), 46 deletions(-)

-- 
2.17.1

