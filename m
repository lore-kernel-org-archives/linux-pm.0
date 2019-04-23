Return-Path: <SRS0=9RE4=SZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CC30C10F03
	for <linux-pm@archiver.kernel.org>; Tue, 23 Apr 2019 17:23:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07182148D
	for <linux-pm@archiver.kernel.org>; Tue, 23 Apr 2019 17:23:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728801AbfDWRXr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:23:47 -0400
Received: from mga18.intel.com ([134.134.136.126]:51582 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726655AbfDWRXr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Apr 2019 13:23:47 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 10:23:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,386,1549958400"; 
   d="scan'208";a="136712565"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 23 Apr 2019 10:23:45 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hIz8y-0003SM-Vm; Wed, 24 Apr 2019 01:23:44 +0800
Date:   Wed, 24 Apr 2019 01:23:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     kbuild-all@01.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>
Subject: [RFC PATCH soc-thermal] drivers: thermal: tsens: tsens_v1_feat can
 be static
Message-ID: <20190423172343.GA50421@lkp-kbuild05>
References: <201904240119.HiYjKUFl%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201904240119.HiYjKUFl%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Fixes: 5cb7aedfa7f2 ("drivers: thermal: tsens: Add generic support for TSENS v1 IP")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 tsens-v1.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v1.c b/drivers/thermal/qcom/tsens-v1.c
index a1221ef..10b595d 100644
--- a/drivers/thermal/qcom/tsens-v1.c
+++ b/drivers/thermal/qcom/tsens-v1.c
@@ -144,7 +144,7 @@ static int calibrate_v1(struct tsens_priv *priv)
 
 /* v1.x: qcs404,405 */
 
-const struct tsens_features tsens_v1_feat = {
+static const struct tsens_features tsens_v1_feat = {
 	.ver_major	= VER_1_X,
 	.crit_int	= 0,
 	.adc		= 1,
@@ -152,7 +152,7 @@ const struct tsens_features tsens_v1_feat = {
 	.max_sensors	= 11,
 };
 
-const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
+static const struct reg_field tsens_v1_regfields[MAX_REGFIELDS] = {
 	/* ----- SROT ------ */
 	/* VERSION */
 	[VER_MAJOR] = REG_FIELD(SROT_HW_VER_OFF, 28, 31),
