Return-Path: <SRS0=9RE4=SZ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8683C10F03
	for <linux-pm@archiver.kernel.org>; Tue, 23 Apr 2019 17:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 93A8D20645
	for <linux-pm@archiver.kernel.org>; Tue, 23 Apr 2019 17:12:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfDWRMr (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 Apr 2019 13:12:47 -0400
Received: from mga12.intel.com ([192.55.52.136]:31594 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727656AbfDWRMr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 23 Apr 2019 13:12:47 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Apr 2019 10:12:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.60,386,1549958400"; 
   d="scan'208";a="293877427"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga004.jf.intel.com with ESMTP; 23 Apr 2019 10:07:45 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1hIytU-000Cxy-Ku; Wed, 24 Apr 2019 01:07:44 +0800
Date:   Wed, 24 Apr 2019 01:07:20 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Amit Kucheria <amit.kucheria@linaro.org>
Cc:     kbuild-all@01.org, linux-pm@vger.kernel.org,
        Eduardo Valentin <edubezval@gmail.com>
Subject: [RFC PATCH soc-thermal] drivers: thermal: tsens: tsens_v0_1_feat can
 be static
Message-ID: <20190423170720.GA81562@lkp-kbuild05>
References: <201904240154.EAoubNVL%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <201904240154.EAoubNVL%lkp@intel.com>
X-Patchwork-Hint: ignore
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org


Fixes: 5be1c7f5f9ce ("drivers: thermal: tsens: Introduce reg_fields to deal with register description")
Signed-off-by: kbuild test robot <lkp@intel.com>
---
 tsens-v0_1.c |    4 ++--
 tsens-v2.c   |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/thermal/qcom/tsens-v0_1.c b/drivers/thermal/qcom/tsens-v0_1.c
index d171a4a..a7560e9 100644
--- a/drivers/thermal/qcom/tsens-v0_1.c
+++ b/drivers/thermal/qcom/tsens-v0_1.c
@@ -319,14 +319,14 @@ static int calibrate_8974(struct tsens_priv *priv)
 
 /* v0.1: 8916, 8974 */
 
-const struct tsens_features tsens_v0_1_feat = {
+static const struct tsens_features tsens_v0_1_feat = {
 	.ver_major	= VER_0_1,
 	.crit_int	= 0,
 	.adc		= 1,
 	.srot_split	= 1,
 };
 
-const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
+static const struct reg_field tsens_v0_1_regfields[MAX_REGFIELDS] = {
 	/* ----- SROT ------ */
 	/* No VERSION information */
 
diff --git a/drivers/thermal/qcom/tsens-v2.c b/drivers/thermal/qcom/tsens-v2.c
index e15a302..b58f5af 100644
--- a/drivers/thermal/qcom/tsens-v2.c
+++ b/drivers/thermal/qcom/tsens-v2.c
@@ -83,14 +83,14 @@ static int get_temp_tsens_v2(struct tsens_priv *priv, int id, int *temp)
 
 /* v2.x: 8996, 8998, sdm845 */
 
-const struct tsens_features tsens_v2_feat = {
+static const struct tsens_features tsens_v2_feat = {
 	.ver_major	= VER_2_X,
 	.crit_int	= 1,
 	.adc		= 0,
 	.srot_split	= 1,
 };
 
-const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
+static const struct reg_field tsens_v2_regfields[MAX_REGFIELDS] = {
 	/* ----- SROT ------ */
 	/* VERSION */
 	[VER_MAJOR] = REG_FIELD(SROT_HW_VER_OFF, 28, 31),
