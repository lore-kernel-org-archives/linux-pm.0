Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52883CA0ED3
	for <linux-pm@archiver.kernel.org>; Tue, 12 Sep 2023 05:02:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230216AbjILFCQ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 12 Sep 2023 01:02:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232019AbjILFBw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 12 Sep 2023 01:01:52 -0400
Received: from srv01.abscue.de (abscue.de [IPv6:2a03:4000:63:bf5:4817:8eff:feeb:8ac7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51DE510EA;
        Mon, 11 Sep 2023 22:00:39 -0700 (PDT)
Received: from srv01.abscue.de (localhost [127.0.0.1])
        by spamfilter.srv.local (Postfix) with ESMTP id 6C2551C3D97;
        Tue, 12 Sep 2023 07:00:37 +0200 (CEST)
Received: from fluffy-mammal.fritz.box (dslb-092-072-011-207.092.072.pools.vodafone-ip.de [92.72.11.207])
        by srv01.abscue.de (Postfix) with ESMTPSA id 0E0DB1C3D98;
        Tue, 12 Sep 2023 07:00:37 +0200 (CEST)
From:   =?UTF-8?q?Otto=20Pfl=C3=BCger?= <otto.pflueger@abscue.de>
To:     linux-arm-msm@vger.kernel.org
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        =?UTF-8?q?Otto=20Pfl=C3=BCger?= <otto.pflueger@abscue.de>
Subject: [PATCH v2 2/3] genpd: qcom: rpmpd: Add MSM8917 power domains
Date:   Tue, 12 Sep 2023 07:00:27 +0200
Message-Id: <20230912050028.4804-3-otto.pflueger@abscue.de>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230912050028.4804-1-otto.pflueger@abscue.de>
References: <20230912050028.4804-1-otto.pflueger@abscue.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

MSM8917 uses the SMPA2 and LDOA3 regulators provided by the PM8937 PMIC
for the VDDCX and VDDMX power domains in voltage level mode,
respectively. These definitions should also work on MSM8937.

Signed-off-by: Otto Pflüger <otto.pflueger@abscue.de>
---
 drivers/genpd/qcom/rpmpd.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/genpd/qcom/rpmpd.c b/drivers/genpd/qcom/rpmpd.c
index 3135dd1dafe0..2980ebd6ed8c 100644
--- a/drivers/genpd/qcom/rpmpd.c
+++ b/drivers/genpd/qcom/rpmpd.c
@@ -257,6 +257,24 @@ static struct rpmpd mx_l3a_corner_ao = {
 	.key = KEY_CORNER,
 };
 
+static struct rpmpd mx_l3a_lvl_ao;
+static struct rpmpd mx_l3a_lvl = {
+	.pd = { .name = "mx", },
+	.peer = &mx_l3a_lvl_ao,
+	.res_type = RPMPD_LDOA,
+	.res_id = 3,
+	.key = KEY_LEVEL,
+};
+
+static struct rpmpd mx_l3a_lvl_ao = {
+	.pd = { .name = "mx_ao", },
+	.peer = &mx_l3a_lvl,
+	.active_only = true,
+	.res_type = RPMPD_LDOA,
+	.res_id = 3,
+	.key = KEY_LEVEL,
+};
+
 static struct rpmpd mx_l12a_lvl_ao;
 static struct rpmpd mx_l12a_lvl = {
 	.pd = { .name = "mx", },
@@ -572,6 +590,20 @@ static const struct rpmpd_desc msm8916_desc = {
 	.max_state = MAX_CORNER_RPMPD_STATE,
 };
 
+static struct rpmpd *msm8917_rpmpds[] = {
+	[MSM8917_VDDCX] =	&cx_s2a_lvl,
+	[MSM8917_VDDCX_AO] =	&cx_s2a_lvl_ao,
+	[MSM8917_VDDCX_VFL] =	&cx_s2a_vfl,
+	[MSM8917_VDDMX] =	&mx_l3a_lvl,
+	[MSM8917_VDDMX_AO] =	&mx_l3a_lvl_ao,
+};
+
+static const struct rpmpd_desc msm8917_desc = {
+	.rpmpds = msm8917_rpmpds,
+	.num_pds = ARRAY_SIZE(msm8917_rpmpds),
+	.max_state = RPM_SMD_LEVEL_TURBO,
+};
+
 static struct rpmpd *msm8953_rpmpds[] = {
 	[MSM8953_VDDMD] =	&md_s1a_lvl,
 	[MSM8953_VDDMD_AO] =	&md_s1a_lvl_ao,
@@ -764,6 +796,7 @@ static const struct of_device_id rpmpd_match_table[] = {
 	{ .compatible = "qcom,msm8226-rpmpd", .data = &msm8226_desc },
 	{ .compatible = "qcom,msm8909-rpmpd", .data = &msm8916_desc },
 	{ .compatible = "qcom,msm8916-rpmpd", .data = &msm8916_desc },
+	{ .compatible = "qcom,msm8917-rpmpd", .data = &msm8917_desc },
 	{ .compatible = "qcom,msm8939-rpmpd", .data = &msm8939_desc },
 	{ .compatible = "qcom,msm8953-rpmpd", .data = &msm8953_desc },
 	{ .compatible = "qcom,msm8976-rpmpd", .data = &msm8976_desc },
-- 
2.39.1
