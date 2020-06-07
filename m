Return-Path: <SRS0=imOP=7U=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E86C433DF
	for <linux-pm@archiver.kernel.org>; Sun,  7 Jun 2020 18:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2F3B2078B
	for <linux-pm@archiver.kernel.org>; Sun,  7 Jun 2020 18:58:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uaKuXbv4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgFGS6F (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sun, 7 Jun 2020 14:58:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729970AbgFGS6D (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sun, 7 Jun 2020 14:58:03 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71EA2C08C5C3;
        Sun,  7 Jun 2020 11:58:03 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id c21so8860679lfb.3;
        Sun, 07 Jun 2020 11:58:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5WrxJdQGGJp0h0CB+IuS493cV6Sm3/0MyVvkHgYGkIo=;
        b=uaKuXbv4NPCMAB5PWw36K78TOvjq8+B5CEINpv0g86H4gsbK8SiR3wpwyYUwYx2QHO
         cOGczfOcfJ3JZp7X+U6ysfHmLuYRo1bDaM7zaB8PfhJ5BtENQ8Oe2ev6zBlRgnbyQ5XC
         DfOvK1n3gsVo5boBFUMcrl+bs9k6AXpc7Q3bm+dZnJ3/EZDnz+2+ba1/NAuUYVrO/8ta
         W1CA0glXMzKOI+epW+OoKM+y4Ev8D/Sn/NvlgLthGcj6wzaYMI3IeY2Jf4oIiJYutUSN
         ourQOypLAMqeFGoXX6Y641io2ItZJ1EmE8USSQLE29TelRyxoyqNlCOtCbEeG66iSTEm
         gQOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5WrxJdQGGJp0h0CB+IuS493cV6Sm3/0MyVvkHgYGkIo=;
        b=W9hTPdbqz8GS7BSDbPwEx0Hovk4Appa61MByGLcrTUrMBDJfwU5MHSClIEs96U5Dm3
         ff4gt5JQYj/9pQCdLzVdk3+kwuhEiyKycMJksg+tXXbNzoVOP3EfU7rCCelEjzZNtfmc
         XaXg+JNNRKEHkul4EFwpLIhyuLwVvARiCydHSVMWgid9TVwhNueMAw0v+IOkgUXZwFMy
         Ts2OfvreXjZmEno/I7dQfk4X3lm51Smlq+t+PPz0XbzyzdPenJb9ROByxCiLFUj26QU0
         cyttapPIk2/tY+OKoWVjNb7EhlfUTp9w2nNa0Uz2LmtzOYAfYP59MVwHPTNMJ4zjPlKh
         bi7g==
X-Gm-Message-State: AOAM5305CZIKwrqCLlwiPRD8Z2VqRZqyTVcRkPCEaRkvh6v/9W0oAatL
        ofFB6NNe3lHLkj2fXvQD3GQ=
X-Google-Smtp-Source: ABdhPJyolUdnd0FXTN33twcK0bltOioVetEv1cEk9SDsT3GY6Y9PN4k3i74XwSmZQuCoGrUPHJYBaQ==
X-Received: by 2002:ac2:5dcb:: with SMTP id x11mr10646127lfq.110.1591556282023;
        Sun, 07 Jun 2020 11:58:02 -0700 (PDT)
Received: from localhost.localdomain (79-139-237-54.dynamic.spd-mgts.ru. [79.139.237.54])
        by smtp.gmail.com with ESMTPSA id e21sm3650953ljb.135.2020.06.07.11.58.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 11:58:01 -0700 (PDT)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Georgi Djakov <georgi.djakov@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Mikko Perttunen <cyndis@kapsi.fi>
Cc:     =?UTF-8?q?Artur=20=C5=9Awigo=C5=84?= <a.swigon@samsung.com>,
        linux-tegra@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org
Subject: [PATCH v3 39/39] ARM: multi_v7_defconfig: Enable interconnect API
Date:   Sun,  7 Jun 2020 21:55:30 +0300
Message-Id: <20200607185530.18113-40-digetx@gmail.com>
X-Mailer: git-send-email 2.26.0
In-Reply-To: <20200607185530.18113-1-digetx@gmail.com>
References: <20200607185530.18113-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

NVIDIA Tegra now has interconnect providers that are used for memory
bandwidth allocation.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/configs/multi_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 95543914d3c7..d3b554045dbe 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -1086,6 +1086,7 @@ CONFIG_FSI_MASTER_ASPEED=m
 CONFIG_FSI_SCOM=m
 CONFIG_FSI_SBEFIFO=m
 CONFIG_FSI_OCC=m
+CONFIG_INTERCONNECT=y
 CONFIG_EXT4_FS=y
 CONFIG_AUTOFS4_FS=y
 CONFIG_MSDOS_FS=y
-- 
2.26.0

