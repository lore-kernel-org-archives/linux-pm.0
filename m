Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C781C4361B
	for <linux-pm@archiver.kernel.org>; Thu,  3 Dec 2020 22:54:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCDBB22482
	for <linux-pm@archiver.kernel.org>; Thu,  3 Dec 2020 22:54:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387740AbgLCWy3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 3 Dec 2020 17:54:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:59420 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727278AbgLCWy3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 3 Dec 2020 17:54:29 -0500
From:   Arnd Bergmann <arnd@kernel.org>
Authentication-Results: mail.kernel.org; dkim=permerror (bad message/signature format)
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Walter Lozano <walter.lozano@collabora.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Ansuel Smith <ansuelsmth@gmail.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpufreq: imx: fix NVMEM_IMX_OCOTP dependency
Date:   Thu,  3 Dec 2020 23:53:32 +0100
Message-Id: <20201203225344.1477350-1-arnd@kernel.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A driver should not 'select' drivers from another subsystem.
If NVMEM is disabled, this one results in a warning:

WARNING: unmet direct dependencies detected for NVMEM_IMX_OCOTP
  Depends on [n]: NVMEM [=n] && (ARCH_MXC [=y] || COMPILE_TEST [=y]) && HAS_IOMEM [=y]
  Selected by [y]:
  - ARM_IMX6Q_CPUFREQ [=y] && CPU_FREQ [=y] && (ARM || ARM64 [=y]) && ARCH_MXC [=y] && REGULATOR_ANATOP [=y]

Change the 'select' to 'depends on' to prevent it from going wrong,
and allow compile-testing without that driver, since it is only
a runtime dependency.

Fixes: 2782ef34ed23 ("cpufreq: imx: Select NVMEM_IMX_OCOTP")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpufreq/Kconfig.arm | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.arm
index 0732854d94ec..434ef03d2762 100644
--- a/drivers/cpufreq/Kconfig.arm
+++ b/drivers/cpufreq/Kconfig.arm
@@ -94,7 +94,7 @@ config ARM_IMX6Q_CPUFREQ
 	tristate "Freescale i.MX6 cpufreq support"
 	depends on ARCH_MXC
 	depends on REGULATOR_ANATOP
-	select NVMEM_IMX_OCOTP
+	depends on NVMEM_IMX_OCOTP || COMPILE_TEST
 	select PM_OPP
 	help
 	  This adds cpufreq driver support for Freescale i.MX6 series SoCs.
-- 
2.27.0

