Return-Path: <SRS0=akx2=AV=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5AE9C433E2
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jul 2020 08:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92164207FC
	for <linux-pm@archiver.kernel.org>; Fri, 10 Jul 2020 08:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FmaTl3k2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgGJIvS (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 10 Jul 2020 04:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726644AbgGJIvR (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 10 Jul 2020 04:51:17 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D3AC08C5CE;
        Fri, 10 Jul 2020 01:51:17 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id l63so2223041pge.12;
        Fri, 10 Jul 2020 01:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X5TRaJebZJRFR5L+fFPIipnzmf8UmSruuRfUXNAdAtk=;
        b=FmaTl3k2rSgT24+2sQAfnuWCjl5OhYgM4xYkkXPGgkbJHhNmKQSyjKSbVky4313RyN
         C9wbokGlQnrDxpVz159hIx4s9o6davTEh2RRctKCWfP2MJa5zyNYN/Z7RP41JdjjvekM
         Kx3udgWlFO1+EDwpK2ofGVEpi+Zl5+KndZsLl52oQ9+C5R2oSErWHhJlE2cnPZzWTHyi
         u/P2t0DqoV8vHYZ7P8blS3+PsWlZqd54FRR1j+/jNw1KBJRmfElde2j10+HlF8NLZZc9
         JWt5CKrrq6OnWiFcm2J19omBWS41eIzu74D74JyvoLL8L3ou9PX+RmW41P7NwbH7nzu5
         /ZZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X5TRaJebZJRFR5L+fFPIipnzmf8UmSruuRfUXNAdAtk=;
        b=TFAgm1d/bVB12akPL3XQOOcpyZDzUT+c3cX4ejcxm8MRofv/o6exdAY+UI0Ivtij3F
         UpI0QQZeThPv1HmFk3Cjt57Dt0dvnB+bqz4+2sdsyExlFQdlil0HioHLgvMwSdFY3aUu
         Dbv1cqUy0hs0qXvvo8VjgbYIT5E7O1Z9/FkqsZLymamYuv2FMOauL6TC8BU/ZqnRwN5X
         OStjcbC3veRqLHlufF+lvfu80wRI3l8H5sD7jm18oceYYMCCpUDROxAOWeuPPMTlPaW+
         w1CIKeH5rU62enul0krPaCum20VdUwoawtJM0BU8f57HYcSx76dAOd6TtQ4krK4BL6qk
         Sr7A==
X-Gm-Message-State: AOAM532DNq1lvsijBE2INTFlKnTrvwu7V4SkleecacnW/vUYU0pms7Bt
        n0KDeXd9MluG6nCvzQhdoY0=
X-Google-Smtp-Source: ABdhPJyuKGFIswQTcD5OVGU78DKOvd7akdjfhZW++U7HUuKTDiEmFpXJ3jgkBWsrW265wy27crpx5w==
X-Received: by 2002:a63:ac53:: with SMTP id z19mr55857410pgn.181.1594371077500;
        Fri, 10 Jul 2020 01:51:17 -0700 (PDT)
Received: from xiaomi.mioffice.cn ([43.224.245.179])
        by smtp.gmail.com with ESMTPSA id e8sm4734273pff.185.2020.07.10.01.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2020 01:51:16 -0700 (PDT)
From:   Qiwu Huang <yanziily@gmail.com>
To:     sre@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        gregkh@linuxfoundation.org, jiangfei1@xiaomi.com,
        Qiwu Huang <huangqiwu@xiaomi.com>
Subject: [PATCH 4/5] power: supply: core: property to control reverse charge
Date:   Fri, 10 Jul 2020 16:48:40 +0800
Message-Id: <20200710084841.1933254-4-yanziily@gmail.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200710084841.1933254-1-yanziily@gmail.com>
References: <20200710084841.1933254-1-yanziily@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Qiwu Huang <huangqiwu@xiaomi.com>

Interface to control wireless reverse charge.
Supply reverse charge function when enabled.

Signed-off-by: Qiwu Huang <huangqiwu@xiaomi.com>
---
 Documentation/ABI/testing/sysfs-class-power | 13 ++++++++++++-
 drivers/power/supply/power_supply_sysfs.c   |  1 +
 include/linux/power_supply.h                |  1 +
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
index 1f42aa0c071e..1f489a250c19 100644
--- a/Documentation/ABI/testing/sysfs-class-power
+++ b/Documentation/ABI/testing/sysfs-class-power
@@ -737,4 +737,15 @@ Date:		Jul 2020
 Contact:	Fei Jiang <jiangfei1@xiaomi.com>
 Description:
 		Reports wireless signal strength.
-		The value show degree of coupling.
\ No newline at end of file
+		The value show degree of coupling.
+What:		/sys/class/power_supply/<supply_name>/reverse_chg_mode
+Date:		Jul 2020
+Contact:	Fei Jiang <jiangfei1@xiaomi.com>
+Description:
+		The property supply interface to control wireless
+		reverse charge mode.
+
+		Valid values:
+		- 1: enabled
+		- 0: disabled
+
diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 42fbe1b68255..4be762abba89 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -209,6 +209,7 @@ static struct power_supply_attr power_supply_attrs[] = {
 	POWER_SUPPLY_ATTR(quick_charge_type),
 	POWER_SUPPLY_ATTR(tx_adapter),
 	POWER_SUPPLY_ATTR(signal_strength),
+	POWER_SUPPLY_ATTR(reverse_chg_mode),
 };
 
 static struct attribute *
diff --git a/include/linux/power_supply.h b/include/linux/power_supply.h
index 397fb8e96b03..319bf6456867 100644
--- a/include/linux/power_supply.h
+++ b/include/linux/power_supply.h
@@ -170,6 +170,7 @@ enum power_supply_property {
 	POWER_SUPPLY_PROP_QUICK_CHARGE_TYPE,
 	POWER_SUPPLY_PROP_TX_ADAPTER,
 	POWER_SUPPLY_PROP_SIGNAL_STRENGTH,
+	POWER_SUPPLY_PROP_REVERSE_CHG_MODE,
 };
 
 enum power_supply_type {
-- 
2.26.0

