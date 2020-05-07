Return-Path: <SRS0=udDz=6V=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C083C54E7E
	for <linux-pm@archiver.kernel.org>; Thu,  7 May 2020 11:30:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6AB0D208E4
	for <linux-pm@archiver.kernel.org>; Thu,  7 May 2020 11:30:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726558AbgEGLaO (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 7 May 2020 07:30:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726308AbgEGLaO (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 7 May 2020 07:30:14 -0400
Received: from andre.telenet-ops.be (andre.telenet-ops.be [IPv6:2a02:1800:120:4::f00:15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2066C05BD0C
        for <linux-pm@vger.kernel.org>; Thu,  7 May 2020 04:30:13 -0700 (PDT)
Received: from ramsan ([IPv6:2a02:1810:ac12:ed60:6572:4a1f:d283:9ae8])
        by andre.telenet-ops.be with bizsmtp
        id bnW3220063ZRV0X01nW3kJ; Thu, 07 May 2020 13:30:11 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jWej5-0006zH-0J; Thu, 07 May 2020 13:30:03 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1jWej5-00068P-03; Thu, 07 May 2020 13:30:03 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Jens Axboe <axboe@kernel.dk>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Amit Kucheria <amit.kucheria@verdurent.com>,
        Arnd Bergmann <arnd@arndb.de>, linux-ide@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH 2/4] cpufreq: qoriq: Add platform dependencies
Date:   Thu,  7 May 2020 13:29:53 +0200
Message-Id: <20200507112955.23520-3-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200507112955.23520-1-geert+renesas@glider.be>
References: <20200507112955.23520-1-geert+renesas@glider.be>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Freescale QorIQ clock controller is only present on Freescale E500MC
and Layerscape SoCs.  Add platform dependencies to the QORIQ_CPUFREQ
config symbol, to avoid asking the user about it when configuring a
kernel without E500MC or Layerscape support.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/cpufreq/Kconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index c3e6bd59e9208822..e917501325525f16 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -323,7 +323,8 @@ endif
 
 config QORIQ_CPUFREQ
 	tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
-	depends on OF && COMMON_CLK && (PPC_E500MC || ARM || ARM64)
+	depends on OF && COMMON_CLK
+	depends on PPC_E500MC || SOC_LS1021A || ARCH_LAYERSCAPE || COMPILE_TEST
 	select CLK_QORIQ
 	help
 	  This adds the CPUFreq driver support for Freescale QorIQ SoCs
-- 
2.17.1

