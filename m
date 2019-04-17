Return-Path: <SRS0=TlO+=ST=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F82C282DA
	for <linux-pm@archiver.kernel.org>; Wed, 17 Apr 2019 00:52:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D38320821
	for <linux-pm@archiver.kernel.org>; Wed, 17 Apr 2019 00:52:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728514AbfDQAwy (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 Apr 2019 20:52:54 -0400
Received: from mga03.intel.com ([134.134.136.65]:25346 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728373AbfDQAwy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Apr 2019 20:52:54 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Apr 2019 17:52:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,359,1549958400"; 
   d="scan'208";a="162546571"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 16 Apr 2019 17:52:50 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hGYoj-000AVJ-S2; Wed, 17 Apr 2019 08:52:49 +0800
Date:   Wed, 17 Apr 2019 08:52:13 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>
Cc:     kbuild-all@01.org, linux-acpi@vger.kernel.org, devel@acpica.org,
        linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [pm:bleeding-edge 80/85]
 drivers/platform/x86/intel_cht_int33fe.c:98:1-3: WARNING: PTR_ERR_OR_ZERO
 can be used
Message-ID: <201904170807.nArPTXtw%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/rafael/linux-pm.git bleeding-edge
head:   98438d88cbe65037744bdc071720389797f9c575
commit: 7ea0bcd165658c84544d5f241126b782d14fbb7f [80/85] platform/x86: intel_cht_int33fe: Register max17047 in its own function


coccinelle warnings: (new ones prefixed by >>)

>> drivers/platform/x86/intel_cht_int33fe.c:98:1-3: WARNING: PTR_ERR_OR_ZERO can be used

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
