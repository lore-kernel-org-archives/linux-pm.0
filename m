Return-Path: <SRS0=+UCx=EJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45726C2D0A3
	for <linux-pm@archiver.kernel.org>; Tue,  3 Nov 2020 15:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3FF120780
	for <linux-pm@archiver.kernel.org>; Tue,  3 Nov 2020 15:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604416430;
	bh=38vPNr6db3yi7DNxmKP0IP1vtoZboPOUjAF9sFfB3dU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Jed4yF/0E3n+wWmo57177EXxzeOyBQAbQu1amEWiULPtbDG2YAXvT6KXmGtvv4+on
	 GBtGM4r0LX8mKwPEoM/p5PlHdKydv628zPycNym4mbDZJ0SoOA06+tjCmG5dy44Ixl
	 JyNkZDldLnsrnvLJrOqGLIGywtQUy9HHswhsOyOs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728427AbgKCPNa (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 3 Nov 2020 10:13:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:56776 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728317AbgKCPMC (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Nov 2020 10:12:02 -0500
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4579F20757;
        Tue,  3 Nov 2020 15:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604416322;
        bh=38vPNr6db3yi7DNxmKP0IP1vtoZboPOUjAF9sFfB3dU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rw68FLCkurAZB6896nf0wNsrAjGp4t93yU4vIRdYWMMj43Qw1s8Jw3uRqfTEbH8Ha
         yq8vaAwUEG3KsaFXFBrpSLIs6A0LPlCGKtC/qs2vNdk8ixg9NOUPwH0eYSNjGe4rl4
         e5qTaHhSVWlRrbAHDa1/TgCVxp3bkrUSaoxSQhm8=
Received: by pali.im (Postfix)
        id DA648133E; Tue,  3 Nov 2020 16:11:59 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/9] cpufreq: ap806: Add missing MODULE_DEVICE_TABLE
Date:   Tue,  3 Nov 2020 16:11:31 +0100
Message-Id: <20201103151139.29690-2-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201103151139.29690-1-pali@kernel.org>
References: <20201103151139.29690-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this cpufreq driver when it is
compiled as an external module.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: f525a670533d9 ("cpufreq: ap806: add cpufreq driver for Armada 8K")
---
 drivers/cpufreq/armada-8k-cpufreq.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/cpufreq/armada-8k-cpufreq.c b/drivers/cpufreq/armada-8k-cpufreq.c
index 39e34f5066d3..b0fc5e84f857 100644
--- a/drivers/cpufreq/armada-8k-cpufreq.c
+++ b/drivers/cpufreq/armada-8k-cpufreq.c
@@ -204,6 +204,12 @@ static void __exit armada_8k_cpufreq_exit(void)
 }
 module_exit(armada_8k_cpufreq_exit);
 
+static const struct of_device_id __maybe_unused armada_8k_cpufreq_of_match[] = {
+	{ .compatible = "marvell,ap806-cpu-clock" },
+	{ },
+};
+MODULE_DEVICE_TABLE(of, armada_8k_cpufreq_of_match);
+
 MODULE_AUTHOR("Gregory Clement <gregory.clement@bootlin.com>");
 MODULE_DESCRIPTION("Armada 8K cpufreq driver");
 MODULE_LICENSE("GPL");
-- 
2.20.1

