Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9ED7C77B75
	for <linux-pm@archiver.kernel.org>; Fri, 19 May 2023 23:01:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230450AbjESXB3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 19 May 2023 19:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjESXB0 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 19 May 2023 19:01:26 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56245B2
        for <linux-pm@vger.kernel.org>; Fri, 19 May 2023 16:01:25 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2ac89e6a5a1so43000621fa.0
        for <linux-pm@vger.kernel.org>; Fri, 19 May 2023 16:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684537283; x=1687129283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=whjoB8+AwiqA7+70a36lCoTmCMz777BLaNAel3mMFt4=;
        b=TSXPQdiZ2cyWIUnmEcQhEc8SxIJFDauWf09xQkGSgrwXZHiDXkah9hjYq8runmir9g
         VlVdloXTxtSAB8WfM0/oGP8tRWimooNeXiVQVfEVtOoBh7iLiZabqi8ATUQpmInE11YW
         Ok1M29MiUm2tHEgW+j9HAT/kiQG8CJ2jJbCFYlnf68/Okt1WbkRQWbdCP5B1Sk+UWldU
         hG1QMIrEuXuScMGiI4TR/sqkV4Rmi/YAC3VDLr/2h7nDwRKFnRtQLKuPuvIrJloUfIwE
         DrJ8eRV4A20tk7ITmKcpYMqMTdzKGB7NIR4+7Bz211I7Vvh+vfBNZQmSI8G+Q2Xf+1DD
         kl1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684537283; x=1687129283;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whjoB8+AwiqA7+70a36lCoTmCMz777BLaNAel3mMFt4=;
        b=TkwxgSNHPfOJV92BSCKInL4YZTJvzoSr3/7sootTOeN2SosKCSp/thvTPIbIIpmEnR
         HiAO6tlsEqAIcmTBgifA5c/I2pTyZqsq6ogMuf6IzjUKqIHisy1FETh2/dTLe1Rb/JCd
         19ICqrCL5VzFk7S4Q0PIdhK0ysqDS2rjIgx9kFbR6I/GfrW9bzKEW0z1DCFbctn2VxXQ
         Q1otZoos8bOlnnkskCkPLhbjE2b3cjCA2NPrGhe04jjwMl4iUItOw4az+qKOZklCKhio
         0EVNiwX+w+6YtaAHWNVe2+dxt2l3eI9EYeA/Wu95VJml3p4Zvh8kIaI54PJxK6nt4Ycj
         dF0g==
X-Gm-Message-State: AC+VfDxmoRK2WUMt1FWtq+X/wA6JqpoSzdBsHTr9Xnz7PNSYcvfa7FRx
        2OCxNR0mEcUOAESe+gCDBG3cbg==
X-Google-Smtp-Source: ACHHUZ6kXnm0MErYuqg0PyS4tsiUeKNRFO162N5vwfZ17Rj2YwvYjMbGHhj0Ic/CZyw/bJ1Msm8XWw==
X-Received: by 2002:a2e:96c7:0:b0:2ad:cd36:3379 with SMTP id d7-20020a2e96c7000000b002adcd363379mr1407059ljj.39.1684537283591;
        Fri, 19 May 2023 16:01:23 -0700 (PDT)
Received: from umbar.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id o8-20020a2e9b48000000b002ad8cbb7349sm31335ljj.98.2023.05.19.16.01.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 16:01:23 -0700 (PDT)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH] interconnect: icc-clk: fix modular build
Date:   Sat, 20 May 2023 02:01:22 +0300
Message-Id: <20230519230122.3958816-1-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix building interconnect-clk as a module:
- Add EXPORT_SYMBOL_GPL to the exported functions
- Add MODULE_DESCRIPTION/_LICENSE/_AUTHOR

Reported-by: Nick Desaulniers <ndesaulniers@google.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/interconnect/icc-clk.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/interconnect/icc-clk.c b/drivers/interconnect/icc-clk.c
index 0db3b654548b..4d43ebff4257 100644
--- a/drivers/interconnect/icc-clk.c
+++ b/drivers/interconnect/icc-clk.c
@@ -146,6 +146,7 @@ struct icc_provider *icc_clk_register(struct device *dev,
 
 	return ERR_PTR(ret);
 }
+EXPORT_SYMBOL_GPL(icc_clk_register);
 
 /**
  * icc_clk_unregister() - unregister a previously registered clk interconnect provider
@@ -166,3 +167,8 @@ void icc_clk_unregister(struct icc_provider *provider)
 			clk_disable_unprepare(qn->clk);
 	}
 }
+EXPORT_SYMBOL_GPL(icc_clk_unregister);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Interconnect wrapper for clocks");
+MODULE_AUTHOR("Dmitry Baryshkov <dmitry.baryshkov@linaro.org>");
-- 
2.39.2

