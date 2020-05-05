Return-Path: <SRS0=9sfO=6T=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE7FEC47254
	for <linux-pm@archiver.kernel.org>; Tue,  5 May 2020 11:12:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B5B0C20735
	for <linux-pm@archiver.kernel.org>; Tue,  5 May 2020 11:12:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="NNAUBPeO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbgEELMu (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 5 May 2020 07:12:50 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:14779 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728872AbgEELMs (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 May 2020 07:12:48 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588677167; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=0eyelEi64rXXRGTuED+vS31cCGjUGaQJnhSz6yhcSRw=; b=NNAUBPeONjd2ARUuYO/QsQoPLpq/5dwj2U4LsvbDSfuMOswwGcDlgdxhxvdNSVjy1ykIu9mp
 BDEc+o7dhC2cz7X+Nyr2Zei4ah6v2QW27Hazt/KR3J9D5lyAtu21h9k4sKOQMAgfwnnPRfhH
 TuTviQvPJG9nthBDFVlXiZBy6es=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eb14a23.7f36f9414a40-smtp-out-n05;
 Tue, 05 May 2020 11:12:35 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id AAE28C433CB; Tue,  5 May 2020 11:12:34 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: manafm)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EA761C433D2;
        Tue,  5 May 2020 11:12:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EA761C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=manafm@codeaurora.org
From:   Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Amit Kucheria <amit.kucheria@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manafm@codeaurora.org>
Subject: [PATCH 0/2] Add 0C (zeorC) interrupt support to tsens driver
Date:   Tue,  5 May 2020 16:42:02 +0530
Message-Id: <20200505111204.963-1-manafm@codeaurora.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Changes:
* Add zeroc interrupt support to tsens driver
* Update zeroc interrupt support in yaml

Manaf Meethalavalappu Pallikunhi (2):
  drivers: thermal: tsens: Add 0C (zeorC) interrupt support
  dt-bindings: thermal: tsens: Add zeroc interrupt support in yaml

 .../bindings/thermal/qcom-tsens.yaml          |  7 +-
 drivers/thermal/qcom/tsens-common.c           | 72 ++++++++++++++++++-
 drivers/thermal/qcom/tsens-v2.c               |  7 ++
 drivers/thermal/qcom/tsens.c                  | 51 +++++++++++--
 drivers/thermal/qcom/tsens.h                  | 11 +++
 5 files changed, 140 insertions(+), 8 deletions(-)

-- 
2.26.2
