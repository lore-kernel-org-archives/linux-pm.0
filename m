Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94975C56202
	for <linux-pm@archiver.kernel.org>; Tue, 24 Nov 2020 01:31:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36AB4206FA
	for <linux-pm@archiver.kernel.org>; Tue, 24 Nov 2020 01:31:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="c6g0+9uS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgKXBbI (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 23 Nov 2020 20:31:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725952AbgKXBbH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Mon, 23 Nov 2020 20:31:07 -0500
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66026C0613CF;
        Mon, 23 Nov 2020 17:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=5eB7ObEwUQl2o1ItNTEpiPl8n5x4qWjBztHqstTMJ4c=; b=c6g0+9uSNQeYHtltK0I7LsS78G
        tAA8AIZ6bk67fZ4D6gXZyb/BxVbphM5zm9Y99hmPSi/an2jqJeV4qXeKbQ1qm5VyIQZgmVnU0rE1j
        7HRSfLOw+onqYnfmxOFwoKOH4JEDzqrXHxpSPVSeZHCvBigC6AaHZ7DIQDyrq+TA/QW29RantSwvT
        a/UqhNl0Zxe1Yts5ACcmKxcA5dZKn1Y/r087WSwMP9t6CDwdn9SwFoOGE6PxGy1D4sfSFhC3V162+
        ePHhgYFTOFELJ8yPSkxm6NcwOqRnyhysdtx8dShUk6b1vIiNJZfgjFwYUZd2DIGzIgwtJr+mDpclz
        W1RKIR1Q==;
Received: from [2601:1c0:6280:3f0::cc1f] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1khNAa-0000O8-AQ; Tue, 24 Nov 2020 01:31:00 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        kernel test robot <lkp@intel.com>, linux-pm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH] cpuidle: arm: qcom: fix Kconfig problems
Date:   Mon, 23 Nov 2020 17:30:53 -0800
Message-Id: <20201124013053.11502-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

The Kconfig symbol ARM_QCOM_SPM_CPUIDLE wildly selects other
Kconfig symbols when it should not.
This causes kconfig warnings and subsequent build errors,
as listed below, so modify this symbol's Kconfig entry to
constrain and tame it.

WARNING: unmet direct dependencies detected for QCOM_SCM
  Depends on [n]: ARM [=y] && HAVE_ARM_SMCCC [=n] || ARM64
  Selected by [y]:
  - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64

WARNING: unmet direct dependencies detected for ARM_CPU_SUSPEND
  Depends on [n]: ARCH_SUSPEND_POSSIBLE [=n]
  Selected by [y]:
  - ARM_QCOM_SPM_CPUIDLE [=y] && CPU_IDLE [=y] && (ARM [=y] || ARM64) && (ARCH_QCOM [=n] || COMPILE_TEST [=y]) && !ARM64

and

arm-linux-gnueabi-ld: arch/arm/kernel/sleep.o: in function `__cpu_suspend':
(.text+0x68): undefined reference to `cpu_sa110_suspend_size'
arm-linux-gnueabi-ld: arch/arm/kernel/suspend.o: in function `__cpu_suspend_save':
suspend.c:(.text+0x138): undefined reference to `cpu_sa110_do_suspend'
arm-linux-gnueabi-ld: suspend.c:(.text+0x170): undefined reference to `cpu_sa110_do_resume'
arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-smc.o: in function `__scm_smc_do_quirk':
qcom_scm-smc.c:(.text+0x54): undefined reference to `__arm_smccc_smc'
arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call':
qcom_scm-legacy.c:(.text+0x168): undefined reference to `__arm_smccc_smc'
arm-linux-gnueabi-ld: drivers/firmware/qcom_scm-legacy.o: in function `scm_legacy_call_atomic':
qcom_scm-legacy.c:(.text+0x2e0): undefined reference to `__arm_smccc_smc'

Fixes: a871be6b8eee ("cpuidle: Convert Qualcomm SPM driver to a generic CPUidle driver")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kernel test robot <lkp@intel.com>
Cc: linux-pm@vger.kernel.org
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Stephan Gerhold <stephan@gerhold.net>
Cc: Lina Iyer <ilina@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/cpuidle/Kconfig.arm |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- linux-next-20201123.orig/drivers/cpuidle/Kconfig.arm
+++ linux-next-20201123/drivers/cpuidle/Kconfig.arm
@@ -108,10 +108,11 @@ config ARM_TEGRA_CPUIDLE
 config ARM_QCOM_SPM_CPUIDLE
 	bool "CPU Idle Driver for Qualcomm Subsystem Power Manager (SPM)"
 	depends on (ARCH_QCOM || COMPILE_TEST) && !ARM64
+	depends on PM
 	select ARM_CPU_SUSPEND
 	select CPU_IDLE_MULTIPLE_DRIVERS
 	select DT_IDLE_STATES
-	select QCOM_SCM
+	select QCOM_SCM if HAVE_ARM_SMCCC
 	help
 	  Select this to enable cpuidle for Qualcomm processors.
 	  The Subsystem Power Manager (SPM) controls low power modes for the
