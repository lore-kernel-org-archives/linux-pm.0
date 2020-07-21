Return-Path: <SRS0=i/1K=BA=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD64AC433E1
	for <linux-pm@archiver.kernel.org>; Tue, 21 Jul 2020 06:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8783B207DD
	for <linux-pm@archiver.kernel.org>; Tue, 21 Jul 2020 06:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QlO/ZsGg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726022AbgGUGBq (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 21 Jul 2020 02:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725294AbgGUGBq (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 21 Jul 2020 02:01:46 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8033AC061794;
        Mon, 20 Jul 2020 23:01:46 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id p1so9790129pls.4;
        Mon, 20 Jul 2020 23:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KalL12U8jxOBVqP8PHbv6nTACYFYFiF1qxSnMyEE5hA=;
        b=QlO/ZsGghWQu/zZez41FEtB5swaHL2vFcaf5WLGFFLAt5mgWFleMKPBb63iR8Ylhpw
         rtAtTLaxVIKUrLLu6DuvRnFioFgqfZoufq6ORvh0cU3c2KGiZSNjxynS5IAJ3lneDqeq
         SJ2PjS2hbd4yLWY4xj+QwCRFHCCTcG1i1aQcvwB6tAGUnvEfJq5UaZfpwe3Pxx/qYhMq
         M8uTx9qngEN/W7k0HyGqgC6eO/boJtnpAlq+iP3gAOkscUkIdmNTU9rKSwGA1vuspCbC
         kGnSNKg34vO5OZoq7qD0b0JZjuaszx907qXWlVJirVE2bMqBOJ8i35LfUw5l9lHb4jks
         27Qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=KalL12U8jxOBVqP8PHbv6nTACYFYFiF1qxSnMyEE5hA=;
        b=Rrtrcif48rXX3SpwIznpj0/Vww3EB4eyE9gbCTj+GR7aWJmDPvty4M55CLvTT1Wtuy
         eWuv7tfZVMmrS6S4rJpQoLA9QZAol0dJGrjdirZWFmQdDgO0aI6lTstKxMTp4QQT4J3c
         eZ2dZ2hxA63Cf1sMqu7b622EPBEZCq6K+7YwHE5gn9tx/IkPp8PxcxaLxufM0G2Vr3r1
         cTv17M0SdNZYv9CTPfiwGRU1sAnXZPw0chdc+iEfbvBwE0KoOwUsEnRUx6PnA6aNYza9
         gPKhhcsvHJHeFGF7r+VeLXOyk+zQ9z82pnmWoBlAzjGZtHWsyOsioFB2HHqZiDHAwrNe
         UemQ==
X-Gm-Message-State: AOAM532OP79BWxe+pkFR5WQjfnWnTYrVyADRjZoWPIc7+w2d253nsYIf
        wH/frayYxwtL+lec/FpT/88=
X-Google-Smtp-Source: ABdhPJxTnilrVLFkWWaJQu9ghZFnh2B8/3fYh82QvFXgAhVXXJAjd70Ap4xZm9O8JyJ5UBr3KKvrWA==
X-Received: by 2002:a17:90a:9285:: with SMTP id n5mr2825539pjo.27.1595311306059;
        Mon, 20 Jul 2020 23:01:46 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([209.9.72.214])
        by smtp.gmail.com with ESMTPSA id 129sm18368833pfv.161.2020.07.20.23.01.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2020 23:01:43 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH v5 0/4] add some power supply properties about wireless/wired charging
Date:   Tue, 21 Jul 2020 13:59:33 +0800
Message-Id: <cover.1595301250.git.huangqiwu@xiaomi.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

This patchset aims to provide power supply properties about wireless/wired charging.
"quick_charge_type" reports different types of quick charge based on the charging power;
"tx_adapter" shows" the type of wireless charging adapter;
"signal_strength" shows the coupling level between TX and RX;
"reverse_chg_mode" provides the interface of enabling/disabling wireless reverse charging.

Changes in v5
 - Add details in 0/X email

Changes in v4
 - Exclude the patch of "power: supply: supply battery soc with decimal form"
 - Fix some typo

Changes in v3
 - Add enumederated for quick charge type
 - Add enumederated for tx adapter type
 - Update the return type and description in ABI

Changes in v2
 - modify to capital letters for "power_supply_attrs"
 - Update the return type and description in ABI

Qiwu Huang (4):
  power: supply: core: add quick charge type property
  power: supply: core: add wireless charger adapter type property
  power: supply: core: add wireless signal strength property
  power: supply: core: property to control reverse charge

 Documentation/ABI/testing/sysfs-class-power | 71 +++++++++++++++++++++
 drivers/power/supply/power_supply_sysfs.c   |  4 ++
 include/linux/power_supply.h                | 31 +++++++++
 3 files changed, 106 insertions(+)


-- 
2.27.0

