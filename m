Return-Path: <SRS0=TEYo=SR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83A38C10F12
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 10:44:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 51FF220674
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 10:44:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d7QEJ0pM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727179AbfDOKoB (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:44:01 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36162 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727118AbfDOKoB (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Apr 2019 06:44:01 -0400
Received: by mail-lf1-f66.google.com with SMTP id u17so12697305lfi.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2019 03:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zPcRJN1/NzE6gNtSRy+MJcIXRb2hexYCT1b0WmO6hYU=;
        b=d7QEJ0pMzQFYzjYWTgqOtQJwQwjwhewLQeVGN+jM39bsQV6azez2oVHqnEWLxx9fzQ
         tOjpYoc33JOP7aVJFwx1T686wASmefpvDwD1bi8xpeRuL0dv9QENmeqJFznFMUjQ9mdC
         jgZz3/2HRmifykVsczRQh6YguYMsBsD39JrQh7JIJHZ+EC27W7DfL9ivuHETD12NkDAs
         RqSBDEwV4hfvp7m7ZEaeTPUEGbiMnXNP5ycetYQho6qgvOr5puPLbmzvGaB99jQQPst2
         wpK3PqbH4+Jj96OflWAWi0QRNvlUGXaZDgVn1M+dA6ltFpMcVEDpMDNIylad6z61e9e3
         e1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zPcRJN1/NzE6gNtSRy+MJcIXRb2hexYCT1b0WmO6hYU=;
        b=AItyu4oilHp6UxCthvbPN1K4PxqLpALwniaY7QmspvXyyZJY2cKeqirSahBmExHHNL
         idQgWW8HK5nulPfX/6TR2UXfDIqvcEtVaaOeHXzaaYK9Mumn0MZO2lSw6llHwLeroo67
         a6QETHfATZyCu/wAYObo2R0iEo74pRhWMSvb2x3Hzr2DGKMDXaQklDI/xXWqvP+83Hx6
         FDd7ptNEN58S+e1zRxgUDFMDE/kch2V84pzS7nitrv25MKiAojYQvGVlLBvfOQHHF1l+
         1b1Krhpb5GzFi7q9iwj2mhKYfqNbYiRSPoO+/tta49LrEeLtMGf4JeJyTAFXTFTLJf0G
         A9kA==
X-Gm-Message-State: APjAAAVsdZS1gAMi3CrXpOPfMAES4gFCOnpLxHW40l9a0QVoTbRidoQI
        3gJxbDCw/TUEdsQm/3Fd/5FfSQ==
X-Google-Smtp-Source: APXvYqyNF/HpuYaU+UlhbmnAZcs5XpnjKSAXfr2SBu04i9RHrTGytce2b64rWTzCtwc0TZi+JqYwng==
X-Received: by 2002:a19:f81a:: with SMTP id a26mr7861013lff.63.1555325039504;
        Mon, 15 Apr 2019 03:43:59 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id k21sm9812596ljk.21.2019.04.15.03.43.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 03:43:58 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, bjorn.andersson@linaro.org,
        georgi.djakov@linaro.org
Cc:     vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 0/4] Add QCS404 interconnect provider driver
Date:   Mon, 15 Apr 2019 13:43:53 +0300
Message-Id: <20190415104357.5305-1-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415104353.1GYXuxMzbBnojHE9i_EDOtHRi0-BYEnJ7QkaeaeaPYo@z>

Add driver to support scaling of the on-chip interconnects on QCS404-based
platforms. Also add the necessary device-tree nodes, so that the driver for
each NoC can probe and register as interconnect-provider.

v2:
- Use the clk_bulk API. (Bjorn)
- Move the port IDs into the provider file. (Bjorn)
- Use ARRAY_SIZE in the macro to automagically count the num_links. (Bjorn)
- Improve code readability. (Bjorn)
- Add patch [4/4] introducing a qcom,qos DT property to represent the link to
  the MMIO QoS registers HW block.

v1: https://lore.kernel.org/lkml/20190405035446.31886-1-georgi.djakov@linaro.org/

Bjorn Andersson (1):
  interconnect: qcom: Add QCS404 interconnect provider driver

Georgi Djakov (3):
  dt-bindings: interconnect: Add Qualcomm QCS404 DT bindings
  arm64: dts: qcs404: Add interconnect provider DT nodes
  dt-bindings: interconnect: qcs404: Introduce qcom,qos DT property

 .../bindings/interconnect/qcom,qcs404.txt     |  76 +++
 arch/arm64/boot/dts/qcom/qcs404.dtsi          |  25 +
 drivers/interconnect/qcom/Kconfig             |   8 +
 drivers/interconnect/qcom/Makefile            |   2 +
 drivers/interconnect/qcom/qcs404.c            | 559 ++++++++++++++++++
 .../dt-bindings/interconnect/qcom,qcs404.h    |  88 +++
 6 files changed, 758 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
 create mode 100644 drivers/interconnect/qcom/qcs404.c
 create mode 100644 include/dt-bindings/interconnect/qcom,qcs404.h

