Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05D11C43462
	for <linux-pm@archiver.kernel.org>; Fri, 30 Apr 2021 10:30:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D87DB613CD
	for <linux-pm@archiver.kernel.org>; Fri, 30 Apr 2021 10:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231181AbhD3KbV (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 30 Apr 2021 06:31:21 -0400
Received: from alexa-out.qualcomm.com ([129.46.98.28]:32283 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230020AbhD3KbT (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Apr 2021 06:31:19 -0400
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 30 Apr 2021 03:30:32 -0700
X-QCInternal: smtphost
Received: from ironmsg02-blr.qualcomm.com ([10.86.208.131])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/AES256-SHA; 30 Apr 2021 03:30:29 -0700
X-QCInternal: smtphost
Received: from c-rkambl-linux1.ap.qualcomm.com (HELO c-rkambl-linux1.qualcomm.com) ([10.242.50.221])
  by ironmsg02-blr.qualcomm.com with ESMTP; 30 Apr 2021 15:59:54 +0530
Received: by c-rkambl-linux1.qualcomm.com (Postfix, from userid 2344811)
        id D5226488D; Fri, 30 Apr 2021 15:59:53 +0530 (IST)
From:   Rajeshwari <rkambl@codeaurora.org>
To:     amitk@kernel.org, thara.gopinath@linaro.org, agross@kernel.org,
        bjorn.andersson@linaro.org, rui.zhang@intel.com,
        daniel.lezcano@linaro.org, robh+dt@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        sanm@codeaurora.org, manafm@codeaurora.org,
        Rajeshwari <rkambl@codeaurora.org>
Subject: [PATCH V3 0/3] Add DT bindings and device tree nodes for TSENS in SC7280
Date:   Fri, 30 Apr 2021 15:59:49 +0530
Message-Id: <1619778592-8112-1-git-send-email-rkambl@codeaurora.org>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adding compatible string in TSENS dt-bindings, device node for TSENS controller and 
critical interrupt support, Thermal zone, cooling maps support and changing Hysteresis 
value for critical trip point, adding cooling-cells property.

Changes:
1) Adding sensors according to sensor index rules under thermal-zones.
2) Changing Hysteresis, as it is not needed for critical trip point, when it reaches 
   critical threshold system will go for shutdown.
3) Adding cooling-cells property under cpus node.

Dependencies:
https://lore.kernel.org/patchwork/project/lkml/list/?series=487403
https://lore.kernel.org/patchwork/patch/1410952/

Rajeshwari (3):
  dt-bindings: thermal: tsens: Add compatible string to TSENS binding
    for SC7280
  arm64: dts: qcom: SC7280:  Add device node support for TSENS
  arm64: dts: qcom: SC7280: Add thermal zone support

 .../devicetree/bindings/thermal/qcom-tsens.yaml    |   1 +
 arch/arm64/boot/dts/qcom/sc7280.dtsi               | 874 +++++++++++++++++++++
 2 files changed, 875 insertions(+)

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member 
of Code Aurora Forum, hosted by The Linux Foundation

