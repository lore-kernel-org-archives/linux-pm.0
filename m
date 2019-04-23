Return-Path: <SRS0=9RE4=SZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD61C10F03
	for <linux-pm@archiver.kernel.org>; Tue, 23 Apr 2019 17:07:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7626621850
	for <linux-pm@archiver.kernel.org>; Tue, 23 Apr 2019 17:07:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729188AbfDWRHq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:07:46 -0400
Received: from mga12.intel.com ([192.55.52.136]:31304 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728902AbfDWRHq (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Apr 2019 13:07:46 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 10:07:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,386,1549958400"; 
   d="scan'208";a="164342192"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga004.fm.intel.com with ESMTP; 23 Apr 2019 10:07:45 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hIytU-000CwE-Ij; Wed, 24 Apr 2019 01:07:44 +0800
Date:   Wed, 24 Apr 2019 01:07:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     kbuild-all@01.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>
Subject: [soc-thermal:linus 20/35] drivers/thermal/qcom/tsens-v0_1.c:322:29:
 sparse: sparse: symbol 'tsens_v0_1_feat' was not declared. Should it be
 static?
Message-ID: <201904240154.EAoubNVL%lkp@intel.com>
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
commit: 5be1c7f5f9ce74e41c193fb481f69de5b4d727ea [20/35] drivers: thermal: tsens: Introduce reg_fields to deal with register description
reproduce:
        # apt-get install sparse
        git checkout 5be1c7f5f9ce74e41c193fb481f69de5b4d727ea
        make ARCH=x86_64 allmodconfig
        make C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>



sparse warnings: (new ones prefixed by >>)

>> drivers/thermal/qcom/tsens-v0_1.c:322:29: sparse: sparse: symbol 'tsens_v0_1_feat' was not declared. Should it be static?
>> drivers/thermal/qcom/tsens-v0_1.c:329:24: sparse: sparse: symbol 'tsens_v0_1_regfields' was not declared. Should it be static?
--
>> drivers/thermal/qcom/tsens-v2.c:86:29: sparse: sparse: symbol 'tsens_v2_feat' was not declared. Should it be static?
>> drivers/thermal/qcom/tsens-v2.c:93:24: sparse: sparse: symbol 'tsens_v2_regfields' was not declared. Should it be static?

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
