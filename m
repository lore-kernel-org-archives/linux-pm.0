Return-Path: <SRS0=/XJp=SH=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4A2C4360F
	for <linux-pm@archiver.kernel.org>; Fri,  5 Apr 2019 03:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2BBCC217D7
	for <linux-pm@archiver.kernel.org>; Fri,  5 Apr 2019 03:55:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UgBFdxGk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729779AbfDEDy5 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:54:57 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:39762 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728735AbfDEDy5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Apr 2019 23:54:57 -0400
Received: by mail-lf1-f66.google.com with SMTP id m13so3319026lfb.6
        for <linux-pm@vger.kernel.org>; Thu, 04 Apr 2019 20:54:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2fmX8L8mVM4NgXf1g6sWhqGWg2W4HcpcrPAHYFtDCt8=;
        b=UgBFdxGk4+iN7NvDvKO+FAV9JoRsB9UxPq2WVWObq3KFOG9x6fMEX/uwqBXfXk5Bet
         1tkdntV+KpNxcUxH94mNAjoCXmfbAbaiplVTXPeNW4W/1jXBT/zkX/q6DGDUkGb8YkiH
         ov7R3zvrPHA7O6MBJqDVFrgjwjmTq6zFG1s1OM0a3GwlOM0DEaJ+4meFz4nTlCajlIwC
         vgIpsscQHE8xyxOQsAZCV6j4wlX9YIPK/HBjaqTW70OV2H21MGlee4gn5HrOqqN69tk7
         MbcJC4fY7/VaUZCgfdCJ2/onV6ID9MpzhKsBHj8IXwBMZ9VFh4bm/eNc4G74o2FnlyiU
         glKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2fmX8L8mVM4NgXf1g6sWhqGWg2W4HcpcrPAHYFtDCt8=;
        b=VRyFiXxLFuJcy4T0mEx15Zgmu5OGvJzmPGZ6QF5PuHHE5J9CdWOayJd+PvV9nORC06
         JqFfC6sVmqt8+Cgfj23l7wVelbjtBcUYIf0oMR9uaxd0hyoPop//MWMNRO75oKBdxZiI
         DAs+STfiwuMe4Qc0i8VVO6y+JVXOGghcfwWD8JXypZ4CL+UBG9Q9xjnuMSdfYmUUb1jm
         ISJKKaemsHhqC7zmVXUBbh6wwaZjRkq5mgJ3Yq9A0lpykFUvDScvZne5zst4ljLDoYua
         EVuasdSeYclWuWbpQIkA6Fb+FAsNUdCk+uKvxKZk+itjew53bioDlFQljsqmQy/z0gEd
         5n6A==
X-Gm-Message-State: APjAAAWg5z734dOFAa/P8ru95cM85n7spiH63+//nCs0djRD3xsZCXm3
        1gSoz8Dnuy5ifyRDPXtM+K/afg==
X-Google-Smtp-Source: APXvYqxW/kC8uTisJp2RkN1WX4o9fXwBzzXDH6b88HrbQm73taNxn5gY59AOQsHBx6GKc0Or1kidFg==
X-Received: by 2002:ac2:4554:: with SMTP id j20mr5518950lfm.112.1554436495446;
        Thu, 04 Apr 2019 20:54:55 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id i24sm4417633ljb.31.2019.04.04.20.54.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 20:54:54 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 0/3] Add QCS404 interconnect provider driver
Date:   Fri,  5 Apr 2019 10:54:43 +0700
Message-Id: <20190405035446.31886-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190405035443.DSJdkmFBtXkS6J_YBlnx_r7B4v0M0ymTMp7qrxq00QQ@z>

Add driver to support scaling of the on-chip interconnects on QCS404-based
platforms. Also add the necessary device-tree nodes, so that the driver for
each NoC can probe and register as interconnect-provider.

Bjorn Andersson (1):
  interconnect: qcom: Add QCS404 interconnect provider driver

Georgi Djakov (2):
  dt-bindings: interconnect: Add Qualcomm QCS404 DT bindings
  arm64: dts: qcs404: Add interconnect provider DT nodes

 .../bindings/interconnect/qcom,qcs404.txt     |  45 ++
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  25 +
 drivers/interconnect/qcom/Kconfig             |   8 +
 drivers/interconnect/qcom/Makefile            |   2 +
 drivers/interconnect/qcom/qcs404.c            | 488 ++++++++++++++++++
 drivers/interconnect/qcom/qcs404_ids.h        |  86 +++
 .../dt-bindings/interconnect/qcom,qcs404.h    |  88 ++++
 7 files changed, 742 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
 create mode 100644 drivers/interconnect/qcom/qcs404.c
 create mode 100644 drivers/interconnect/qcom/qcs404_ids.h
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs404.h

