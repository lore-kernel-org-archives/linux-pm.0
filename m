Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF17C8302C
	for <linux-pm@archiver.kernel.org>; Thu, 26 Nov 2020 18:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEEE121D1A
	for <linux-pm@archiver.kernel.org>; Thu, 26 Nov 2020 18:55:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405149AbgKZSzk (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 26 Nov 2020 13:55:40 -0500
Received: from relay06.th.seeweb.it ([5.144.164.167]:51493 "EHLO
        relay06.th.seeweb.it" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728937AbgKZSy5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 26 Nov 2020 13:54:57 -0500
Received: from IcarusMOD.eternityproject.eu (unknown [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 8323340622;
        Thu, 26 Nov 2020 19:46:36 +0100 (CET)
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
To:     linux-arm-msm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, ulf.hansson@linaro.org,
        jorge.ramirez-ortiz@linaro.org, broonie@kernel.org,
        lgirdwood@gmail.com, daniel.lezcano@linaro.org, nks@flawful.org,
        bjorn.andersson@linaro.org, agross@kernel.org, robh+dt@kernel.org,
        viresh.kumar@linaro.org, rjw@rjwysocki.net,
        konrad.dybcio@somainline.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org, phone-devel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Subject: [PATCH 09/13] MAINTAINERS: Add entry for Qualcomm CPRv3/v4/Hardened driver
Date:   Thu, 26 Nov 2020 19:45:55 +0100
Message-Id: <20201126184559.3052375-10-angelogioacchino.delregno@somainline.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
References: <20201126184559.3052375-1-angelogioacchino.delregno@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add maintainers entry for the Qualcomm CPR3/CPR4/CPRh driver.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c8c006f08dcc..a37c3ae91f2f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14461,6 +14461,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/soc/qcom/qcom,cpr.yaml
 F:	drivers/soc/qcom/cpr.c
 
+QUALCOMM CORE POWER REDUCTION v3/v4/Hardened AVS DRIVER
+M:	AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
+S:	Maintained
+F:	Documentation/devicetree/bindings/soc/qcom/qcom,cpr3.yaml
+F:	drivers/soc/qcom/cpr3.c
+
 QUALCOMM CPUFREQ DRIVER MSM8996/APQ8096
 M:	Ilia Lin <ilia.lin@kernel.org>
 L:	linux-pm@vger.kernel.org
-- 
2.29.2

