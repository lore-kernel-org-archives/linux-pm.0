Return-Path: <SRS0=6BhR=SM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1410CC10F14
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 08:20:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8B27206B6
	for <linux-pm@archiver.kernel.org>; Wed, 10 Apr 2019 08:20:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LzBmjDNq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729404AbfDJIUp (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 10 Apr 2019 04:20:45 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:40112 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729258AbfDJIUp (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 10 Apr 2019 04:20:45 -0400
Received: by mail-lj1-f196.google.com with SMTP id q66so1254393ljq.7
        for <linux-pm@vger.kernel.org>; Wed, 10 Apr 2019 01:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LNxQpIwxT1JmfOXeE0uJOYnKkmng1Hu5UTgquERxi8o=;
        b=LzBmjDNqM0toMZ6MQV0QMz4tuK3eI+Dk/kmno1wkUgF4UOemy569Cb8QWNual2j2I0
         fwrPqSWdSGK1vtqWmhBLRrwMW1fie92JhFv6uL3FEfetCwFUArG+GrukzHqvz0vMYrgl
         H3whTMrBuUSGqMQyzh8kh4gVFlsSlYTAhsK6OQNw5OIDe7ChFT+2fZmNi0AS28FzPj+o
         M2cPPhEajT1C/dB3n5Rcu6KCaKtgSq1T+erasLTuKiadSMQXIZOhFSX/lc6foVyc4UFm
         REXdMGAttPTwCu12ZD4apcyyiX57VwEOmSzrzhJvGybMR1glUbRFZUzB0dEpcu+63Su1
         ovtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LNxQpIwxT1JmfOXeE0uJOYnKkmng1Hu5UTgquERxi8o=;
        b=IrPGSF2wg/IqXwwGtDGc49cPllaSSL2CSvoMrGKcQ0j1dZ8puEW/axlLuYjXmforTn
         22tlTjhOqSCyOuAQm016ms3gVZlO1ixf+ZCD41GNYsblv+edgcvM0zz1gpeJyMGOUhwc
         Re2jynR2Vp51sFE3tFryv++NoXE5QixQ9xGL3vtRd25LFYLOwhLyrWbQf9vbSjqRm71O
         9ZZ+XtiuMnyFChokT/Yn79rqutf/ME1btxQTgCVDeCs+ZJ+f/LTHVVPHX46Sei67hwTX
         0bgizmRxkeI8pLzZrVZagkaF4KqfEHbaDU31BCi6qbSd8t7jXuq7PoFxREmkM81zifNm
         HjiA==
X-Gm-Message-State: APjAAAXc1B2dCRZw2l3ufkOJ1k2u/gzOxxA1GVZNRucdZgT6oX8NNBgK
        q045u5sdwsCGJz1CxZXp9Ym3IQ==
X-Google-Smtp-Source: APXvYqy9Cwtfigxkyshi/JEXtF0oo1BptEUXXkD1CxuMtZg3yt+6xwg/hvhre3gF+ApqxCH7pW/swA==
X-Received: by 2002:a2e:8ec5:: with SMTP id e5mr12701296ljl.7.1554884442442;
        Wed, 10 Apr 2019 01:20:42 -0700 (PDT)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se. [158.174.22.210])
        by smtp.gmail.com with ESMTPSA id q6sm3385189lfj.36.2019.04.10.01.20.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Apr 2019 01:20:41 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
Cc:     Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Lina Iyer <ilina@codeaurora.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-arm-kernel@lists.infradead.org
Subject: [RESEND PATCH v2 1/5] drivers: firmware: psci: Move psci to separate directory
Date:   Wed, 10 Apr 2019 10:20:21 +0200
Message-Id: <20190410082025.5989-2-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190410082025.5989-1-ulf.hansson@linaro.org>
References: <20190410082025.5989-1-ulf.hansson@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190410082021.ko3D0OWbZv60s-K4inGw5BAoF0uWoUJsLW-NJRuRkfU@z>

Some following changes extends the PSCI driver with some additional new
files.  Let's avoid to continue cluttering the toplevel firmware directory
and first move the PSCI files into a PSCI sub-directory.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/firmware/Kconfig                   | 15 +--------------
 drivers/firmware/Makefile                  |  3 +--
 drivers/firmware/psci/Kconfig              | 13 +++++++++++++
 drivers/firmware/psci/Makefile             |  4 ++++
 drivers/firmware/{ => psci}/psci.c         |  0
 drivers/firmware/{ => psci}/psci_checker.c |  0
 6 files changed, 19 insertions(+), 16 deletions(-)
 create mode 100644 drivers/firmware/psci/Kconfig
 create mode 100644 drivers/firmware/psci/Makefile
 rename drivers/firmware/{ => psci}/psci.c (100%)
 rename drivers/firmware/{ => psci}/psci_checker.c (100%)

diff --git a/drivers/firmware/Kconfig b/drivers/firmware/Kconfig
index f754578414f0..e1385f47d4ac 100644
--- a/drivers/firmware/Kconfig
+++ b/drivers/firmware/Kconfig
@@ -5,20 +5,6 @@
 
 menu "Firmware Drivers"
 
-config ARM_PSCI_FW
-	bool
-
-config ARM_PSCI_CHECKER
-	bool "ARM PSCI checker"
-	depends on ARM_PSCI_FW && HOTPLUG_CPU && CPU_IDLE && !TORTURE_TEST
-	help
-	  Run the PSCI checker during startup. This checks that hotplug and
-	  suspend operations work correctly when using PSCI.
-
-	  The torture tests may interfere with the PSCI checker by turning CPUs
-	  on and off through hotplug, so for now torture tests and PSCI checker
-	  are mutually exclusive.
-
 config ARM_SCMI_PROTOCOL
 	bool "ARM System Control and Management Interface (SCMI) Message Protocol"
 	depends on ARM || ARM64 || COMPILE_TEST
@@ -270,6 +256,7 @@ config TI_SCI_PROTOCOL
 config HAVE_ARM_SMCCC
 	bool
 
+source "drivers/firmware/psci/Kconfig"
 source "drivers/firmware/broadcom/Kconfig"
 source "drivers/firmware/google/Kconfig"
 source "drivers/firmware/efi/Kconfig"
diff --git a/drivers/firmware/Makefile b/drivers/firmware/Makefile
index 80feb635120f..9a3909a22682 100644
--- a/drivers/firmware/Makefile
+++ b/drivers/firmware/Makefile
@@ -2,8 +2,6 @@
 #
 # Makefile for the linux kernel.
 #
-obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
-obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
 obj-$(CONFIG_ARM_SCPI_PROTOCOL)	+= arm_scpi.o
 obj-$(CONFIG_ARM_SCPI_POWER_DOMAIN) += scpi_pm_domain.o
 obj-$(CONFIG_ARM_SDE_INTERFACE)	+= arm_sdei.o
@@ -25,6 +23,7 @@ CFLAGS_qcom_scm-32.o :=$(call as-instr,.arch armv7-a\n.arch_extension sec,-DREQU
 obj-$(CONFIG_TI_SCI_PROTOCOL)	+= ti_sci.o
 
 obj-$(CONFIG_ARM_SCMI_PROTOCOL)	+= arm_scmi/
+obj-y				+= psci/
 obj-y				+= broadcom/
 obj-y				+= meson/
 obj-$(CONFIG_GOOGLE_FIRMWARE)	+= google/
diff --git a/drivers/firmware/psci/Kconfig b/drivers/firmware/psci/Kconfig
new file mode 100644
index 000000000000..26a3b32bf7ab
--- /dev/null
+++ b/drivers/firmware/psci/Kconfig
@@ -0,0 +1,13 @@
+config ARM_PSCI_FW
+	bool
+
+config ARM_PSCI_CHECKER
+	bool "ARM PSCI checker"
+	depends on ARM_PSCI_FW && HOTPLUG_CPU && CPU_IDLE && !TORTURE_TEST
+	help
+	  Run the PSCI checker during startup. This checks that hotplug and
+	  suspend operations work correctly when using PSCI.
+
+	  The torture tests may interfere with the PSCI checker by turning CPUs
+	  on and off through hotplug, so for now torture tests and PSCI checker
+	  are mutually exclusive.
diff --git a/drivers/firmware/psci/Makefile b/drivers/firmware/psci/Makefile
new file mode 100644
index 000000000000..1956b882470f
--- /dev/null
+++ b/drivers/firmware/psci/Makefile
@@ -0,0 +1,4 @@
+# SPDX-License-Identifier: GPL-2.0
+#
+obj-$(CONFIG_ARM_PSCI_FW)	+= psci.o
+obj-$(CONFIG_ARM_PSCI_CHECKER)	+= psci_checker.o
diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci/psci.c
similarity index 100%
rename from drivers/firmware/psci.c
rename to drivers/firmware/psci/psci.c
diff --git a/drivers/firmware/psci_checker.c b/drivers/firmware/psci/psci_checker.c
similarity index 100%
rename from drivers/firmware/psci_checker.c
rename to drivers/firmware/psci/psci_checker.c
-- 
2.17.1

