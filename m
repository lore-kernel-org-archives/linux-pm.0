Return-Path: <SRS0=9RE4=SZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5B5C10F03
	for <linux-pm@archiver.kernel.org>; Tue, 23 Apr 2019 17:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FBFA20835
	for <linux-pm@archiver.kernel.org>; Tue, 23 Apr 2019 17:23:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726655AbfDWRXr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:23:47 -0400
Received: from mga02.intel.com ([134.134.136.20]:41170 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728763AbfDWRXr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Apr 2019 13:23:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 10:23:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,386,1549958400"; 
   d="scan'208";a="225998681"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 23 Apr 2019 10:23:45 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hIz8z-0003UE-2d; Wed, 24 Apr 2019 01:23:45 +0800
Date:   Wed, 24 Apr 2019 01:23:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     kbuild-all@01.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>
Subject: [soc-thermal:linus 30/35] drivers/thermal/qcom/tsens-v1.c:147:29:
 sparse: sparse: symbol 'tsens_v1_feat' was not declared. Should it be
 static?
Message-ID: <201904240119.HiYjKUFl%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-thermal.git linus
head:   0e50a5ee6b8a23c6798aae23efcd4b8e055c06ef
commit: 5cb7aedfa7f230060b73cfad49e3cdb45463e815 [30/35] drivers: thermal: tsens: Add generic support for TSENS v1 IP
reproduce:
        # apt-get install sparse
        git checkout 5cb7aedfa7f230060b73cfad49e3cdb45463e815
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>



sparse warnings: (new ones prefixed by >>)

>> drivers/thermal/qcom/tsens-v1.c:147:29: sparse: sparse: symbol 'tsens_v1_feat' was not declared. Should it be static?
>> drivers/thermal/qcom/tsens-v1.c:155:24: sparse: sparse: symbol 'tsens_v1_regfields' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
