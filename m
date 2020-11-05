Return-Path: <SRS0=Evqw=EL=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C191C55ABD
	for <linux-pm@archiver.kernel.org>; Thu,  5 Nov 2020 13:52:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B0ED20715
	for <linux-pm@archiver.kernel.org>; Thu,  5 Nov 2020 13:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JFSJapFs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730783AbgKENwP (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 5 Nov 2020 08:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730759AbgKENwP (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 5 Nov 2020 08:52:15 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62470C0613D4
        for <linux-pm@vger.kernel.org>; Thu,  5 Nov 2020 05:52:13 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id w14so1846022wrs.9
        for <linux-pm@vger.kernel.org>; Thu, 05 Nov 2020 05:52:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=78Yqfg/j79d9NNkXhCSDFD9fF8BplsRrEs56vasrB44=;
        b=JFSJapFsRo6fFsFNT5fq3w8nSjl4V+HnuwbE7ug9ngodKD0vduSY+0kui8DwmjtAPJ
         kuDolIsvGEJeALyCIBBKgsqVPOqjVyHROxbcYLY7+FxTk/hWaXgWQF4gxBp4m7jPPu/e
         V/wGGsC0G9QRt/fJF94Ey4675nYZViP77HuFt7BecddqP4nIOBARYYXi7Rj18BQ852ZX
         OcXBaznuft+Xyhfj5bo2NlAf2dr9C1Gb4MzntpvHJluLC0rzQ1C7vuXARFE0lu8fU/3D
         L9+zpZ3/bJ2L6Z7VCZRzR0Hur4Y4CV2E21NVkSdslSMKvKzu/BlwARcduggTxTSp7ZEo
         ERIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=78Yqfg/j79d9NNkXhCSDFD9fF8BplsRrEs56vasrB44=;
        b=BbKUBPrefw+fPzfs2a9EpsuTcblk+TrQeUAFvgTzxK8Gp79tuSkP1bAMf4I9DrqbgB
         ythMabtCzN1NxgQ1aKkLRwgzOUY2mBfA/V30JUhZoAzp2ct08EED8Jw9jstBoGLXpNag
         Puec2v4rn0W1cD7kgU+8PNiTymHGdvgMt4cRONqNNKonoJUDe6dumXe3Ht8uZWIU5d3a
         kB0OBu7bn3w6P8QouV3VpS5uFqrf0UDo7oAOgS6XFsM1epPlt/SZmnp/YlS707HF8TGo
         79QdcWnmWFbZVP28EDlAHjgiBRk0eKDmT43ALRQLG9iws3VPbU2EBXJnCLDA8XBWxQ4I
         o6Rw==
X-Gm-Message-State: AOAM531Bi+3E83lLsGpeall0ROQd2YCOi0gq4amUn8N+7gcAGHaDZljq
        rv6Uq2mFRqSKUZ4t6KRciHYk0Mzxrh4Xig==
X-Google-Smtp-Source: ABdhPJzTOx7XwqB2M/gYtejLYoKHQ4+Uv+vPHpnflGImQA3lZXNsJSYNIzCdzisV+S2ZiaSBlc5M5g==
X-Received: by 2002:adf:e6cf:: with SMTP id y15mr3290322wrm.116.1604584331755;
        Thu, 05 Nov 2020 05:52:11 -0800 (PST)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id h4sm2648541wrq.3.2020.11.05.05.52.10
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Nov 2020 05:52:11 -0800 (PST)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     linux-pm@vger.kernel.org, bjorn.andersson@linaro.org,
        mdtipton@codeaurora.org
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        akashast@codeaurora.org, georgi.djakov@linaro.org
Subject: [PATCH 2/3] interconnect: qcom: sdm845: Add the missing nodes for QUP
Date:   Thu,  5 Nov 2020 15:52:10 +0200
Message-Id: <20201105135211.7160-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201105135211.7160-1-georgi.djakov@linaro.org>
References: <20201105135211.7160-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The QUP nodes are currently defined just as entries in the topology,
but they are not referenced by any of the NoCs. Let's fix this and
"attach" them to their NoCs, so that the QUP drivers are able to use
them as path endpoints and scale their bandwidth.

This is based on the information from the downstream msm-4.9 kernel.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 drivers/interconnect/qcom/sdm845.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/interconnect/qcom/sdm845.c b/drivers/interconnect/qcom/sdm845.c
index 5304aea3b058..366870150cbd 100644
--- a/drivers/interconnect/qcom/sdm845.c
+++ b/drivers/interconnect/qcom/sdm845.c
@@ -177,6 +177,7 @@ DEFINE_QBCM(bcm_sn15, "SN15", false, &qnm_memnoc);
 
 static struct qcom_icc_bcm *aggre1_noc_bcms[] = {
 	&bcm_sn9,
+	&bcm_qup0,
 };
 
 static struct qcom_icc_node *aggre1_noc_nodes[] = {
@@ -190,6 +191,7 @@ static struct qcom_icc_node *aggre1_noc_nodes[] = {
 	[SLAVE_A1NOC_SNOC] = &qns_a1noc_snoc,
 	[SLAVE_SERVICE_A1NOC] = &srvc_aggre1_noc,
 	[SLAVE_ANOC_PCIE_A1NOC_SNOC] = &qns_pcie_a1noc_snoc,
+	[MASTER_QUP_1] = &qhm_qup1,
 };
 
 static const struct qcom_icc_desc sdm845_aggre1_noc = {
@@ -218,6 +220,7 @@ static struct qcom_icc_node *aggre2_noc_nodes[] = {
 	[SLAVE_A2NOC_SNOC] = &qns_a2noc_snoc,
 	[SLAVE_ANOC_PCIE_SNOC] = &qns_pcie_snoc,
 	[SLAVE_SERVICE_A2NOC] = &srvc_aggre2_noc,
+	[MASTER_QUP_2] = &qhm_qup2,
 };
 
 static const struct qcom_icc_desc sdm845_aggre2_noc = {
