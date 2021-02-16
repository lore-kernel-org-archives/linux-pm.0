Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02542C433E6
	for <linux-pm@archiver.kernel.org>; Tue, 16 Feb 2021 11:13:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA6DA64E02
	for <linux-pm@archiver.kernel.org>; Tue, 16 Feb 2021 11:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbhBPLNm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 Feb 2021 06:13:42 -0500
Received: from mail.kernel.org ([198.145.29.99]:36392 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229958AbhBPLNl (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Feb 2021 06:13:41 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D60B164DA1;
        Tue, 16 Feb 2021 11:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613473981;
        bh=U/9Xwrg8bAM2A5MgFUI0Cfy5+k8D9Ryv+uAjX8R5bJc=;
        h=From:To:Cc:Subject:Date:From;
        b=EL9Vm+9ChSDdG5fjYVCPwkyPUDDjSSq5lq33Yb7r4Fgka+MaEcYgR9NcjdQkEH52a
         E81VRuJsw7LAnC2ytlqxnIybr8vPtu23pUES+KN9WWRuXmOHlz1tbXLm5k0vz9j9TT
         qZkfZUDo5P5H3UeMFAGbeuarm3CKzErWoLEl28piSh5who7BNxuu5BDrX39TVDyj0F
         eRLwxkPaQNoYY6HwzwYOrKPCpWs2gThBrUdRQ6IY3Gg9qPBScEqAwoF4XD+0f7I4aS
         yLSU1/89bMfyD1ep74tW1KypH3mKi8oWXBig+luvW5Z46RDOe0Us+rCJg25c40GAlU
         a6EDbW2/PuFKA==
From:   Vinod Koul <vkoul@kernel.org>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rob Herring <robh+dt@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: cpufreq: cpufreq-qcom-hw: Document SM8350 CPUfreq compatible
Date:   Tue, 16 Feb 2021 16:42:51 +0530
Message-Id: <20210216111251.1838149-1-vkoul@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add the CPUfreq compatible for SM8350 SoC along with note for using the
specific compatible for SoCs

Signed-off-by: Vinod Koul <vkoul@kernel.org>
---
 Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
index 9299028ee712..3eb3cee59d79 100644
--- a/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
+++ b/Documentation/devicetree/bindings/cpufreq/cpufreq-qcom-hw.txt
@@ -8,7 +8,9 @@ Properties:
 - compatible
 	Usage:		required
 	Value type:	<string>
-	Definition:	must be "qcom,cpufreq-hw" or "qcom,cpufreq-epss".
+	Definition:	must be "qcom,cpufreq-hw" or "qcom,cpufreq-epss"
+			along with SoC specific compatible:
+			  "qcom,sm8350-cpufreq-epss", "qcom,cpufreq-epss"
 
 - clocks
 	Usage:		required
-- 
2.26.2

