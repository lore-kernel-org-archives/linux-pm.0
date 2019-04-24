Return-Path: <SRS0=aEVV=S2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D88FC10F11
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 11:16:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFA3D2089F
	for <linux-pm@archiver.kernel.org>; Wed, 24 Apr 2019 11:16:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726869AbfDXLQx (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 24 Apr 2019 07:16:53 -0400
Received: from mga03.intel.com ([134.134.136.65]:22094 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726135AbfDXLQx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 24 Apr 2019 07:16:53 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 24 Apr 2019 04:16:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,389,1549958400"; 
   d="scan'208";a="164397223"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 24 Apr 2019 04:16:51 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hJFtS-000HQu-VJ; Wed, 24 Apr 2019 19:16:50 +0800
Date:   Wed, 24 Apr 2019 19:16:45 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     kbuild-all@01.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>
Subject: [soc-thermal:for-kernelci 23/35]
 drivers/thermal/qcom/tsens-common.c:77 is_sensor_enabled() warn: unsigned
 'hw_id' is never less than zero.
Message-ID: <201904241943.GxWJlzHM%lkp@intel.com>
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
commit: cb467d58a3181b4cfe036655bee3999babcdb770 [23/35] drivers: thermal: tsens: Add new operation to check if a sensor is enabled

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>


New smatch warnings:
drivers/thermal/qcom/tsens-common.c:77 is_sensor_enabled() warn: unsigned 'hw_id' is never less than zero.
drivers/thermal/qcom/tsens-common.c:78 is_sensor_enabled() warn: signedness bug returning '(-22)'

Old smatch warnings:
drivers/thermal/qcom/tsens-common.c:28 qfprom_read() warn: passing zero to 'ERR_CAST'
drivers/thermal/qcom/tsens-common.c:158 init_common() warn: passing zero to 'PTR_ERR'
drivers/thermal/qcom/tsens-common.c:175 init_common() warn: passing zero to 'PTR_ERR'

vim +/hw_id +77 drivers/thermal/qcom/tsens-common.c

    71	
    72	bool is_sensor_enabled(struct tsens_priv *priv, u32 hw_id)
    73	{
    74		u32 val;
    75		int ret;
    76	
  > 77		if ((hw_id > (priv->num_sensors - 1)) || (hw_id < 0))
  > 78			return -EINVAL;
    79		ret = regmap_field_read(priv->rf[SENSOR_EN], &val);
    80		if (ret)
    81			return ret;
    82	
    83		return val & (1 << hw_id);
    84	}
    85	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
