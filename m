Return-Path: <SRS0=GzKS=ZU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A8D0C432C3
	for <linux-pm@archiver.kernel.org>; Thu, 28 Nov 2019 22:38:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1DA382176D
	for <linux-pm@archiver.kernel.org>; Thu, 28 Nov 2019 22:38:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UbOLwMOX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbfK1WiF (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 28 Nov 2019 17:38:05 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46704 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726569AbfK1WiF (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 28 Nov 2019 17:38:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=f3rjvT6j+bT26WVJqnERf3RXYSJGnbAkdL5QvBotJac=; b=UbOLwMOXvmPhk3YPbXXwYcUS2
        21Hs9wjGAi4YX0ezggz+uYhPoFK0YJPWi9+24Z1AY2uqsneaNS+jWnR67reK7yeLTBIacAOdltLuL
        aUnw/xJjk9SkeXoutf4U8OxXDh24FZEJcyxNYugiwROhIZUn68XcHSU/nimgsYJoeT+ckBs3R3++7
        1lZI0YmpKxDRjCr7qW/KfqJhb12zHR5WmSuzKxDNDQCmu+MicqK6Rg8bFrLDoeV0plEwfbmnWjt51
        67fdPTwBFTeqaqoQOKYTY6S6oonaXE359KJSlrYm26f7JtupKkhaDHkhtxTl1iRZIlPAsXEnZHdwf
        kpLvEr99Q==;
Received: from [2601:1c0:6280:3f0::5a22]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1iaSQF-00079Q-PF; Thu, 28 Nov 2019 22:38:03 +0000
To:     Linux PM list <linux-pm@vger.kernel.org>,
        LAK <linux-arm-kernel@lists.infradead.org>
Cc:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] cpuidle: minor Kconfig help text fixes
Message-ID: <b0e9d1df-8bb9-9eee-f433-c7a8e8269e06@infradead.org>
Date:   Thu, 28 Nov 2019 14:38:03 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

End sentences in help text with a period (aka full stop).

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
---
 drivers/cpuidle/Kconfig.arm |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- lnx-54.orig/drivers/cpuidle/Kconfig.arm
+++ lnx-54/drivers/cpuidle/Kconfig.arm
@@ -65,21 +65,21 @@ config ARM_U8500_CPUIDLE
 	bool "Cpu Idle Driver for the ST-E u8500 processors"
 	depends on ARCH_U8500 && !ARM64
 	help
-	  Select this to enable cpuidle for ST-E u8500 processors
+	  Select this to enable cpuidle for ST-E u8500 processors.
 
 config ARM_AT91_CPUIDLE
 	bool "Cpu Idle Driver for the AT91 processors"
 	default y
 	depends on ARCH_AT91 && !ARM64
 	help
-	  Select this to enable cpuidle for AT91 processors
+	  Select this to enable cpuidle for AT91 processors.
 
 config ARM_EXYNOS_CPUIDLE
 	bool "Cpu Idle Driver for the Exynos processors"
 	depends on ARCH_EXYNOS && !ARM64
 	select ARCH_NEEDS_CPU_IDLE_COUPLED if SMP
 	help
-	  Select this to enable cpuidle for Exynos processors
+	  Select this to enable cpuidle for Exynos processors.
 
 config ARM_MVEBU_V7_CPUIDLE
 	bool "CPU Idle Driver for mvebu v7 family processors"


