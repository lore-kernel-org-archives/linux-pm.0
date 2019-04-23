Return-Path: <SRS0=9RE4=SZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A1E3C10F03
	for <linux-pm@archiver.kernel.org>; Tue, 23 Apr 2019 19:32:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2313B21738
	for <linux-pm@archiver.kernel.org>; Tue, 23 Apr 2019 19:32:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725956AbfDWTcx (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 Apr 2019 15:32:53 -0400
Received: from mga04.intel.com ([192.55.52.120]:14790 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfDWTcx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Apr 2019 15:32:53 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 12:32:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,386,1549958400"; 
   d="scan'208";a="136745301"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Apr 2019 12:32:51 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hJ19u-000GvF-R5; Wed, 24 Apr 2019 03:32:50 +0800
Date:   Wed, 24 Apr 2019 03:32:02 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Talel Shenhar <talel@amazon.com>
Cc:     kbuild-all@01.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>,
        David Woodhouse <dwmw@amazon.co.uk>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [soc-thermal:for-kernelci 34/35]
 drivers/thermal/thermal_mmio.c:120:3-8: No need to set .owner here. The core
 will do it.
Message-ID: <201904240343.b2RBtBuM%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git for-kernelci
head:   0e50a5ee6b8a23c6798aae23efcd4b8e055c06ef
commit: 35838aa51cd6dbf5ae2c78ecd1d1df0cc0324256 [34/35] thermal: Introduce Amazon's Annapurna Labs Thermal Driver

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>



coccinelle warnings: (new ones prefixed by >>)

>> drivers/thermal/thermal_mmio.c:120:3-8: No need to set .owner here. The core will do it.

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
