Return-Path: <SRS0=sfwA=BL=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A631AC433E1
	for <linux-pm@archiver.kernel.org>; Sat,  1 Aug 2020 12:31:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C7062080C
	for <linux-pm@archiver.kernel.org>; Sat,  1 Aug 2020 12:31:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="sohCVxve"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728965AbgHAMbW (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 1 Aug 2020 08:31:22 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:59426 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728993AbgHAMbV (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 1 Aug 2020 08:31:21 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596285081; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=uturfSKxZbvQjzNudApCv3HIvQ0Xf8YorlQetv7wpsc=; b=sohCVxveXkeY54SiX4Ta7R79b5pw4hQkfBYvBgISOtJdTSL2GRjqs77J9XgYoJqBFE/ZBB3+
 fhO0IsjO4nW+OZWstNLB6B5nBmgl4NfawWrxSP55MeA/a6mywdprmecGu+5lBTKvI5pnflov
 oCtszj93Nr9f3jSmmtaCwTwqgXA=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-east-1.postgun.com with SMTP id
 5f2560892c24b37bbe5b964e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 01 Aug 2020 12:31:05
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 549A6C433CA; Sat,  1 Aug 2020 12:31:04 +0000 (UTC)
Received: from blr-ubuntu-253.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ECD47C43391;
        Sat,  1 Aug 2020 12:31:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ECD47C43391
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=sibis@codeaurora.org
From:   Sibi Sankar <sibis@codeaurora.org>
To:     robh+dt@kernel.org, georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, jonathan@marek.ca,
        linux-pm@vger.kernel.org, Sibi Sankar <sibis@codeaurora.org>
Subject: [PATCH 1/7] dt-bindings: interconnect: Add OSM L3 DT binding on SM8150
Date:   Sat,  1 Aug 2020 18:00:43 +0530
Message-Id: <20200801123049.32398-2-sibis@codeaurora.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200801123049.32398-1-sibis@codeaurora.org>
References: <20200801123049.32398-1-sibis@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add Operation State Manager (OSM) L3 interconnect provider binding on
SM8150 SoCs.

Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
---
 Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
index 91f70c9067d12..b6945c11eb46b 100644
--- a/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
+++ b/Documentation/devicetree/bindings/interconnect/qcom,osm-l3.yaml
@@ -19,6 +19,7 @@ properties:
     enum:
       - qcom,sc7180-osm-l3
       - qcom,sdm845-osm-l3
+      - qcom,sm8150-osm-l3
 
   reg:
     maxItems: 1
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

