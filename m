Return-Path: <SRS0=QwoY=AE=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6AAC433E1
	for <linux-pm@archiver.kernel.org>; Tue, 23 Jun 2020 04:08:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D37D20780
	for <linux-pm@archiver.kernel.org>; Tue, 23 Jun 2020 04:08:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="wybIFliE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732015AbgFWEIq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 23 Jun 2020 00:08:46 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:26864 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1732030AbgFWEIp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 23 Jun 2020 00:08:45 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592885325; h=Content-Transfer-Encoding: MIME-Version:
 Message-Id: Date: Subject: Cc: To: From: Sender;
 bh=l7xpyBPCAxLZ0rd7XLxxfMJk3gdpmgz4YVkp6OkbyGU=; b=wybIFliEnCQCP91fM8RlGviz9QqvRZwxUoojpmsDqEfKZ5cXo9/chYdo4YmYc/XsyQmgYhYy
 qbWqdg2f0g9zaBmeNMnqqMQtgaPyt5BstpCnNSv7yAVxx1VCSOlEzDawJ+Yt19PBPky81T94
 xrVyYmmMGbjmSLub2YLQn4dyhe8=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI5ZDFmMiIsICJsaW51eC1wbUB2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n10.prod.us-east-1.postgun.com with SMTP id
 5ef1803e567385e8e794f196 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 23 Jun 2020 04:08:30
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id CEC95C43391; Tue, 23 Jun 2020 04:08:29 +0000 (UTC)
Received: from mdtipton-linux.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mdtipton)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 23D51C433C6;
        Tue, 23 Jun 2020 04:08:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 23D51C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mdtipton@codeaurora.org
From:   Mike Tipton <mdtipton@codeaurora.org>
To:     georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, agross@kernel.org,
        linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Mike Tipton <mdtipton@codeaurora.org>
Subject: [PATCH 0/4] interconnect: qcom: Misc bcm-voter changes and fixes
Date:   Mon, 22 Jun 2020 21:08:10 -0700
Message-Id: <20200623040814.23791-1-mdtipton@codeaurora.org>
X-Mailer: git-send-email 2.24.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

These changes are mostly unrelated, but there are some dependencies
between them.

Mike Tipton (4):
  interconnect: qcom: Support bcm-voter-specific TCS wait behavior
  interconnect: qcom: Only wait for completion in AMC/WAKE by default
  interconnect: qcom: Add support for per-BCM scaling factors
  interconnect: qcom: Fix small BW votes being truncated to zero

 drivers/interconnect/qcom/bcm-voter.c | 63 ++++++++++++++++++---------
 drivers/interconnect/qcom/icc-rpmh.c  |  3 ++
 drivers/interconnect/qcom/icc-rpmh.h  |  2 +
 3 files changed, 47 insertions(+), 21 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

