Return-Path: <SRS0=TEYo=SR=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28181C10F0E
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 10:44:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E41ED20883
	for <linux-pm@archiver.kernel.org>; Mon, 15 Apr 2019 10:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dfgi5Nl1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727238AbfDOKo0 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 15 Apr 2019 06:44:26 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33867 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727241AbfDOKoD (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 15 Apr 2019 06:44:03 -0400
Received: by mail-lf1-f67.google.com with SMTP id h5so9758789lfm.1
        for <linux-pm@vger.kernel.org>; Mon, 15 Apr 2019 03:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bnBZT6oTJP94HSPW3gA5hs6b68w49ZB4QExkm50FCn0=;
        b=Dfgi5Nl1Jb35xr1iYUviB50ng8FH5VRdxo1VWNqgSw8/Mi1CQ3pepCS74YCWgmoSHJ
         6zckXTR7c/hTUosd9ZSgRG8j/jClWyMjh1GuAOAtiV4onfFinVud9Fgd3CdE0SWD28Ny
         XcxrD6EVpjO8jgs0KIv8IQnOKOAsqyL+kBwFfpzlLO+W30SRmr6xQ0FWvNrvf5pfrXRM
         zhb0bfuV1cqyPGjlkBaIh7XRIh8c5RKoWtwVdZ96bECc7s16h5VQ8GfWNQxt/XAhkM5M
         6mEm9Qiec2DLUIwwe6CTcVfTUVLMQI9M6pXawP34pQUzXzUUCcibVuzS8siW0FW+HNvG
         nEkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bnBZT6oTJP94HSPW3gA5hs6b68w49ZB4QExkm50FCn0=;
        b=T0fILyZvIhTTGTWuVQHqPhoBa98+dQGI7lqeTe5lJQHrThHMWIm9ajbFNhIgIULerW
         Nd5kHJlp0jzcTOuAPuWu4lQ1HzSF3LNESqSKqLaoVfIHUMWMFbZvCVyJ4Np6jZVKsIiV
         szBmQHiNBSdxxXtDQcx8xGpJIWXnEJ9Jm9rWspfdJ20kpnJGyatDfClB1ZncYvMs3+2u
         KNNcIdXszB1CyvQmtdykQB4M31G9H2+ysTdmuI2oCitSoQnDWyv5RT2ZsO5CkmCGaFQk
         u1nWxYNLj/L3IMYOoOeseI2IVB3NYYP5zrov1N5QvYQ+nHW2nemBx1Ei0R1axqcuVbTf
         LTHg==
X-Gm-Message-State: APjAAAVo8R/RqbjlAFq0P+Wvb0hAFeUPvMP4+vWamD2YR/L5HZf+gc3H
        4LHH1t+Rv5m7imLWf3Kqx9CzFA==
X-Google-Smtp-Source: APXvYqzxqlMRnVaJXR1c6Tugs9ek3X4izXa7GkzownRs6Q39FY27FGDYNZo79oRc0VR7X+26ybATcg==
X-Received: by 2002:a19:ed10:: with SMTP id y16mr2634597lfy.82.1555325041344;
        Mon, 15 Apr 2019 03:44:01 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id k21sm9812596ljk.21.2019.04.15.03.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 15 Apr 2019 03:44:00 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, bjorn.andersson@linaro.org,
        georgi.djakov@linaro.org
Cc:     vkoul@kernel.org, evgreen@chromium.org, daidavid1@codeaurora.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: [PATCH v2 1/4] dt-bindings: interconnect: Add Qualcomm QCS404 DT bindings
Date:   Mon, 15 Apr 2019 13:43:54 +0300
Message-Id: <20190415104357.5305-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190415104357.5305-1-georgi.djakov@linaro.org>
References: <20190415104357.5305-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190415104354.aYxIVmEu8tK4wYcvb7rY5VbmKm7y2X92-GBpOUbF57A@z>

The Qualcomm QCS404 platform has several buses that could be controlled
and tuned according to the bandwidth demand.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---

v2:
- No changes.

 .../bindings/interconnect/qcom,qcs404.txt     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
new file mode 100644
index 000000000000..9befcd14a5b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
@@ -0,0 +1,45 @@
+Qualcomm QCS404 Network-On-Chip interconnect driver binding
+-----------------------------------------------------------
+
+Required properties :
+- compatible : shall contain only one of the following:
+			"qcom,qcs404-bimc"
+			"qcom,qcs404-pcnoc"
+			"qcom,qcs404-snoc"
+- #interconnect-cells : should contain 1
+
+Optional properties :
+clocks : list of phandles and specifiers to all interconnect bus clocks
+clock-names : clock names should include both "bus_clk" and "bus_a_clk"
+
+Example:
+
+rpm-glink {
+	...
+	rpm_requests: glink-channel {
+		...
+		bimc: interconnect@0 {
+			compatible = "qcom,qcs404-bimc";
+			#interconnect-cells = <1>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_BIMC_CLK>,
+				<&rpmcc RPM_SMD_BIMC_A_CLK>;
+		};
+
+		pnoc: interconnect@1 {
+			compatible = "qcom,qcs404-pcnoc";
+			#interconnect-cells = <1>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_PNOC_CLK>,
+				<&rpmcc RPM_SMD_PNOC_A_CLK>;
+		};
+
+		snoc: interconnect@2 {
+			compatible = "qcom,qcs404-snoc";
+			#interconnect-cells = <1>;
+			clock-names = "bus_clk", "bus_a_clk";
+			clocks = <&rpmcc RPM_SMD_SNOC_CLK>,
+				<&rpmcc RPM_SMD_SNOC_A_CLK>;
+		};
+	};
+};
