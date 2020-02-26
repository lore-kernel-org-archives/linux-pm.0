Return-Path: <SRS0=X62Z=4O=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 856B6C4BA10
	for <linux-pm@archiver.kernel.org>; Wed, 26 Feb 2020 11:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5241824656
	for <linux-pm@archiver.kernel.org>; Wed, 26 Feb 2020 11:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XlmcE8LW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgBZL6U (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:58:20 -0500
Received: from mail-pl1-f177.google.com ([209.85.214.177]:33139 "EHLO
        mail-pl1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgBZL6T (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 26 Feb 2020 06:58:19 -0500
Received: by mail-pl1-f177.google.com with SMTP id ay11so1223428plb.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Feb 2020 03:58:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5YMRvV+08eDz1zTAqAh41qKWUj9Ta+YFrJ/4O+JaQ+E=;
        b=XlmcE8LWadGLnbLkM6boQYBuEwDqamO2pB8rpBi9J0f4ffdx6t/8w/w0ns/yX3ZUOZ
         v3sGKC51IA7PqAV5dJ7VY/Ni/mWLfrQTyU/O2qYXtfPSskVOJJdEDXffvi4PJL15pIHr
         bdaK+Y/NacnkuQcgNvLWjQG97HLFnD0hnjOzoZT+TQw6rNoVmzbx9iRVos00rh7iG3iI
         siWMsJWAzl5YlPXH1GAlM+YxKb/u2406l8BL8pBO2FqqN8Yt2WtslbJNpmGHh9RmSDxf
         xZKUAWedusMDKR4J9+bNoj2woELORkGPJoMD/I+3xYTQYphSSo+6JZlhxroYKnueD1T4
         8kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5YMRvV+08eDz1zTAqAh41qKWUj9Ta+YFrJ/4O+JaQ+E=;
        b=nLBDt6PCyg119IL8i4qtCC+WrmwjY4fBvfPUUm1F4IX75m+Ty5K/PjR9YyVKm6T6wA
         ezVfJMncKiVXuLQVSvkkUFRZS92nxMgyibS1WMLmdHb6zrP5qNOApuDr3U8YaBanOw58
         2T2zxmC6d7dh3rm3NMTXlZxXeBt7NlbbcYQMgK7qYARtAkeZiXk8fTZKdoh0w+grVspY
         bcpV/+6wwLx4JgloL3lrQ8T517U9h7XXZPs5yOwthQUkW+kEHgPxT5lOuHl0XMA5UDU5
         PUlANR+QwkYO6//s6EBu3QwjWAbKPZhm0uBsIXCNBTb75czJL5zrXEXccy39hrT77Y5f
         xrLQ==
X-Gm-Message-State: APjAAAUNi355Ehn6YcoLqVB+k65Kabu9gac8HqyXT1qiewRCqAjuKwz/
        3XxIkY6UMlCIzf7acgxKGi309w==
X-Google-Smtp-Source: APXvYqy6SK3++pCleI5HCCFb8UN6ntnevHnMXBkL9kYIs0aj2I8qBTp78k6t6H0wMoJRCryfMW8vgA==
X-Received: by 2002:a17:902:426:: with SMTP id 35mr3709323ple.302.1582718298449;
        Wed, 26 Feb 2020 03:58:18 -0800 (PST)
Received: from localhost ([2401:4900:1b38:7f42:3530:df3:7e53:a029])
        by smtp.gmail.com with ESMTPSA id c188sm2893183pfb.151.2020.02.26.03.58.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 03:58:17 -0800 (PST)
From:   Amit Kucheria <amit.kucheria@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        vkoul@kernel.org, daniel.lezcano@linaro.org,
        bjorn.andersson@linaro.org, sivaa@codeaurora.org,
        Andy Gross <agross@kernel.org>, Zhang Rui <rui.zhang@intel.com>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org
Subject: [PATCH v3 0/3] Cleanup dtbs_check warnings for tsens
Date:   Wed, 26 Feb 2020 15:01:10 +0530
Message-Id: <cover.1582705101.git.amit.kucheria@linaro.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Make dtbs_check pass for tsens bits. I'm working on another series to
cleanup other DT warnings for QC platforms.

Amit Kucheria (3):
  dt-bindings: thermal: tsens: Add entry for sc7180 tsens to binding
  dt-bindings: thermal: tsens: Add qcom,tsens-v0_1 to msm8916.dtsi
    compatible
  dt-bindings: thermal: tsens: Add qcom,tsens-v2 to msm8996.dtsi
    compatible

 Documentation/devicetree/bindings/thermal/qcom-tsens.yaml | 1 +
 arch/arm64/boot/dts/qcom/msm8916.dtsi                     | 2 +-
 arch/arm64/boot/dts/qcom/msm8996.dtsi                     | 4 ++--
 3 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.20.1

