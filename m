Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF220C433B4
	for <linux-pm@archiver.kernel.org>; Wed, 21 Apr 2021 13:57:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 956126144D
	for <linux-pm@archiver.kernel.org>; Wed, 21 Apr 2021 13:57:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239318AbhDUN6D (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 21 Apr 2021 09:58:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:34662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S242313AbhDUN6D (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 21 Apr 2021 09:58:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 0E17D61445;
        Wed, 21 Apr 2021 13:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1619013450;
        bh=xnD3YJ0KiYDjoH+p5AyJhLNba8qMmfteiSz9TACtVIU=;
        h=From:To:Cc:Subject:Date:From;
        b=YLBt8aAF7m3MrFrtRGu9+0ydGNwfrcSNoKbWvhXXxURyqmG52v/eT8K1wUnuxrWNg
         khtBSwaln7ZNI2JJ88HpAD5Om1InqrWBXIhKM6y/cXGK/ZP+zVNG+rIbLukUSszt9v
         1ZJ2/gIwDEea0u0zQ9QF3np/oa//ZNzD8horCTboOV/m/lsQlM/zoZ3fkKUwN7O3QV
         7pTOFykOtvLJvu4XkdP45/Oud/cVj2bpNaatEF2tXjCRctVEGJZ0997+Rv2bH1pQVg
         NZCi3byvl8aqDKHADt1OKYDDFt8cJc6QWPa52JudKN9pW07GZwLqbvE/A4f4ZCZFkQ
         f0YW85kW/qWkA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        He Ying <heying24@huawei.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cpuidle: qcom_scm: fix Kconfig dependencies again
Date:   Wed, 21 Apr 2021 15:57:13 +0200
Message-Id: <20210421135723.3601743-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The previous compile time fix was incomplete and still results in
warnings like:

WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
  Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
  Selected by [y]:
  - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]

WARNING: unmet direct dependencies detected for QCOM_SCM
  Depends on [n]: (ARM [=y] || ARM64) && HAVE_ARM_SMCCC [=n]
  Selected by [y]:
  - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64 && MMU [=y]

Use a dependency on ARCH_SUSPEND_POSSIBLE as a prerequisite for
selecting ARM_CPU_SUSPEND, and a dependency on HAVE_ARM_SMCCC
for QCOM_SCM.

Fixes: 498ba2a8a275 ("cpuidle: Fix ARM_QCOM_SPM_CPUIDLE configuration")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/cpuidle/Kconfig.arm | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/Kconfig.arm b/drivers/cpuidle/Kconfig.arm
index 334f83e56120..fc596494251c 100644
--- a/drivers/cpuidle/Kconfig.arm
+++ b/drivers/cpuidle/Kconfig.arm
@@ -107,7 +107,8 @@ config ARM_TEGRA_CPUIDLE
 
 config ARM_QCOM_SPM_CPUIDLE
 	bool "CPU Idle Driver for Qualcomm Subsystem Power Manager (SPM)"
-	depends on (ARCH_QCOM || COMPILE_TEST) && !ARM64 && MMU
+	depends on ARCH_QCOM || (ARCH_SUSPEND_POSSIBLE && COMPILE_TEST)
+	depends on ARM && HAVE_ARM_SMCCC
 	select ARM_CPU_SUSPEND
 	select CPU_IDLE_MULTIPLE_DRIVERS
 	select DT_IDLE_STATES
-- 
2.29.2

