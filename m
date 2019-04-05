Return-Path: <SRS0=/XJp=SH=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D81C10F0F
	for <linux-pm@archiver.kernel.org>; Fri,  5 Apr 2019 03:55:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 042BA21855
	for <linux-pm@archiver.kernel.org>; Fri,  5 Apr 2019 03:55:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PNIp5mY8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbfDEDzH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 4 Apr 2019 23:55:07 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:44916 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729943AbfDEDzE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 4 Apr 2019 23:55:04 -0400
Received: by mail-lj1-f194.google.com with SMTP id h16so3946899ljg.11
        for <linux-pm@vger.kernel.org>; Thu, 04 Apr 2019 20:55:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P3XpvpcPM6aalE4O70WUMUyv+99IpY35hhzUG6m2EPY=;
        b=PNIp5mY8g3SL/N4L3eRsFQ8l8JECobVd1SG8BBw8ali/kPfaFyt8DCoIoi4nKv6Ypo
         TWS/eyBNL4Ob+qe4nu+xgrV030S7WdXH7JwTXPUFWn3JR8sWETN6sXtO09RhhXLPdO4D
         dCzCsHclqyZceRzFu61fipd4OcFqZpcCmR2k/Nu/hMW9pGZb570XuVXSttPI8jSlCn8T
         vJ7EpkZgx4j82Kqf2W0dr4rKBtbEmwAagZWMdfDKnD05/6uMl+0ge97e6cwYVfsmMYbW
         fry38pErEByfYEzAAQl4Bw93MzXKbxcvAigswK2Id+Vi9FuXlziIsK0iFwdsdiumI2h1
         yO9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P3XpvpcPM6aalE4O70WUMUyv+99IpY35hhzUG6m2EPY=;
        b=hTScjNEPDjiIxSCOaxHsSsM9pN069UlmJ/njyydRn7TuIP1/UgjIEwp4pWFWCMKMeJ
         FNFXpXapYJL9ROHqR0G0rm6oliGSVCvt83mrF+KVdkytOpQ9o+BpQEk3/m9Pr8pEhrnl
         v4Up4vxQC+ZnfAPB80Ddgp7eSY0o+22aJhYGKl+jvXKL6xDWxFNoysoLWV2rSLxe/zLx
         /NVv386qYraCkfQraXdjINHj7zJB7ceMeFiHvtOkMINZ+kdNhGq29Acm5qOYyz+0fGt6
         37H/xbKFC7+QPkcUjWx956acIzpLt6qSyNqulsHDt6jnIAOJjQdVK3F+G7Jphs9xIXLA
         wQLA==
X-Gm-Message-State: APjAAAUUlcmRxNzIo1/1b8YgkRzynlv74oLQjJ5e8O8LQSSwF8140Hms
        5odTD2O6k28P6cRDIuns857Ziw==
X-Google-Smtp-Source: APXvYqzNZDyhQKaAlc7Zu3BRyRzDnNylIC+OxIZL176I8ek9lLkfW95awzyC+XrgDTjmblSQcYq4tw==
X-Received: by 2002:a2e:8156:: with SMTP id t22mr5317625ljg.77.1554436501800;
        Thu, 04 Apr 2019 20:55:01 -0700 (PDT)
Received: from localhost.localdomain ([212.45.67.2])
        by smtp.googlemail.com with ESMTPSA id i24sm4417633ljb.31.2019.04.04.20.54.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 04 Apr 2019 20:55:01 -0700 (PDT)
From:   Georgi Djakov <georgi.djakov@linaro.org>
To:     robh+dt@kernel.org, georgi.djakov@linaro.org
Cc:     bjorn.andersson@linaro.org, vkoul@kernel.org, evgreen@chromium.org,
        daidavid1@codeaurora.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: [PATCH 1/3] dt-bindings: interconnect: Add Qualcomm QCS404 DT bindings
Date:   Fri,  5 Apr 2019 10:54:44 +0700
Message-Id: <20190405035446.31886-2-georgi.djakov@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190405035446.31886-1-georgi.djakov@linaro.org>
References: <20190405035446.31886-1-georgi.djakov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190405035444.RoBCZ8KfkHv-ECIaLMGTO3jTVWx5Gamk1b4eHna2PMw@z>

The Qualcomm QCS404 platform has several buses that could be controlled
and tuned according to the bandwidth demand.

Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>
---
 .../bindings/interconnect/qcom,qcs404.txt     | 45 +++++++++++++++++++
 1 file changed, 45 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt

diff --git a/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt b/Documentation/devicetree/bindings/interconnect/qcom,qcs404.txt
new file mode 100644
index 000000000000..2ea63ea827d7
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
