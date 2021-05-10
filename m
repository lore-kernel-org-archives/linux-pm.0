Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 789D4C4360C
	for <linux-pm@archiver.kernel.org>; Mon, 10 May 2021 21:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 48DFA6143C
	for <linux-pm@archiver.kernel.org>; Mon, 10 May 2021 21:11:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231414AbhEJVM7 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 10 May 2021 17:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231310AbhEJVM5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 10 May 2021 17:12:57 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1685C061760;
        Mon, 10 May 2021 14:11:51 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id z9so25442999lfu.8;
        Mon, 10 May 2021 14:11:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GQ2M+eZzU/1PiW9MJgPZXEsaqUdAgzr+AsgIN6calq4=;
        b=sm7XPvsPLsYJeiLoXtm9K3yqLdoh6VaZWudqVtlltSgXnrD76N/kSrBlDkXhQPrVAL
         R+xat50e7DU+o9cD1BAdVO/kWfyAvzGSRXNNXLdg/sDTGx5nsUCGRKryP72vCEyiAqTq
         qxLtEE+uY6U75vM6XLuEN0cbEMQ/vS0FMHo/oPHbsvdYGyqxI228Wg/FIKM4w8U0BJka
         bXPEc5VxjHg3rK415QFFbGGEkCoUjtLETuvKIrVTBalDh7FXRqic3JeqCxI8fmZ1U9Tj
         CLx+ONReDI5c0+aC+bl06F+AnkOcekqo8uAiDFZr0tAW7T5odQTAhxaZgSXyTQDA0X/E
         zFdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GQ2M+eZzU/1PiW9MJgPZXEsaqUdAgzr+AsgIN6calq4=;
        b=kb/WLbDiyynytMDbIzjU/cFqV8CYRY5jun4qO+lB8H/cb9Qgp4NjnI+O5fpOWNWNUq
         SoFayy5Mz/2lVeW0+JR5yjcm4UjhOP0bdPU9crF2Iz6diR/eSr+AVfhMmMKjTvVqOxGk
         yeebPKc/C5iUKKpxmeCc5oeMYoThio75uywHLXfjbnLvYuC9E/jg77PX6Dt4/h6XGXtl
         0OyktJ8SczS2++YGRDKyWHKUB7GuR7hPPyEFp1dUDuv8waBedRamFGcYhKD1mfxNhkRt
         /5pEoykF+R1dVG4xzeoZBSFTpPjJdtVXei1UFggtNCytA4bNfVc7wFenciM2tTZcqGTs
         vYEA==
X-Gm-Message-State: AOAM532JGf+wauDAkQvYgfJDlXNxvhSoOwnU98U/79haPpQS0Rx0S53d
        WyjfRe3RnCPtS7bKXPfCFiMrWdhNPgs=
X-Google-Smtp-Source: ABdhPJxCstkRyjaQmTvbNIf/ZKsi8cw1NsrC4MQ/oXU3qzz5Gy2nkl6Y1UkWX0ajp2iMsMO/8IiYaA==
X-Received: by 2002:ac2:5a4c:: with SMTP id r12mr12365304lfn.632.1620681110495;
        Mon, 10 May 2021 14:11:50 -0700 (PDT)
Received: from localhost.localdomain (109-252-193-91.dynamic.spd-mgts.ru. [109.252.193.91])
        by smtp.gmail.com with ESMTPSA id x4sm2365339lfa.173.2021.05.10.14.11.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 14:11:50 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Rob Herring <robh+dt@kernel.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Matt Merhar <mattmerhar@protonmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: [PATCH v1 2/7] ARM: tegra_defconfig: Enable CONFIG_DEVFREQ_THERMAL
Date:   Tue, 11 May 2021 00:10:03 +0300
Message-Id: <20210510211008.30300-3-digetx@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210510211008.30300-1-digetx@gmail.com>
References: <20210510211008.30300-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Memory-related Tegra devfreq devices now could be used as a cooling
devices. Enable CONFIG_DEVFREQ_THERMAL by default since this option
enables cooling functionality of the devfreq drivers.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/tegra_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index 13ef3e4dcbb7..3d8d8af9524d 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -167,6 +167,7 @@ CONFIG_SENSORS_LM95245=y
 CONFIG_THERMAL=y
 CONFIG_THERMAL_STATISTICS=y
 CONFIG_CPU_THERMAL=y
+CONFIG_DEVFREQ_THERMAL=y
 CONFIG_TEGRA_SOCTHERM=m
 CONFIG_WATCHDOG=y
 CONFIG_MAX77620_WATCHDOG=y
-- 
2.30.2

