Return-Path: <SRS0=+UCx=EJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F015C55179
	for <linux-pm@archiver.kernel.org>; Tue,  3 Nov 2020 15:13:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B51820780
	for <linux-pm@archiver.kernel.org>; Tue,  3 Nov 2020 15:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604416406;
	bh=BymlLEXMIZdkcZquq/SLhW58QSml7Tl5xLSXsPJMlaQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=QO934KU6hfgFPhvcLtRjgAdycQ6tfuyHEtJ6EkSU5fIJAuskjSXBgB+UjGzDxJTqW
	 EvuNthDnZF68iik0hTBxqs8+Q4HxbeAXJJ2IvdLmaHZ5Zen2YlUA6uDPVYQ6pzuFKE
	 qyk0okdnB5B2SWHyoX2uBkFni7c66i2XRyfdgOAA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728293AbgKCPNH (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 3 Nov 2020 10:13:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:56890 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728348AbgKCPMF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Nov 2020 10:12:05 -0500
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E7C42242C;
        Tue,  3 Nov 2020 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604416324;
        bh=BymlLEXMIZdkcZquq/SLhW58QSml7Tl5xLSXsPJMlaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=T3wBZLFzUKR02vTcEKoFzAYSBqNflxvWsshwGW3p+Ndij+a9tHZxf+DhvUrUhIG2C
         W/LLCo8cXC+oI2Yk7+4hqHPyPC4mC1/y1S72eVUep67sb6//JCUPbC7jmmSdcNGt0p
         XVvT516ArPcuKhuvI0TtQLr7ABeozvP0vhPpkio4=
Received: by pali.im (Postfix)
        id F40091C67; Tue,  3 Nov 2020 16:12:01 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] cpufreq: vexpress-spc: Add missing MODULE_ALIAS
Date:   Tue,  3 Nov 2020 16:11:39 +0100
Message-Id: <20201103151139.29690-10-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201103151139.29690-1-pali@kernel.org>
References: <20201103151139.29690-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch adds missing MODULE_ALIAS for automatic loading of this cpufreq
driver when it is compiled as an external module.

Signed-off-by: Pali Rohár <pali@kernel.org>
Fixes: 47ac9aa165540 ("cpufreq: arm_big_little: add vexpress SPC interface driver")
---
 drivers/cpufreq/vexpress-spc-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/vexpress-spc-cpufreq.c b/drivers/cpufreq/vexpress-spc-cpufreq.c
index e89b905754d2..f711d8eaea6a 100644
--- a/drivers/cpufreq/vexpress-spc-cpufreq.c
+++ b/drivers/cpufreq/vexpress-spc-cpufreq.c
@@ -591,6 +591,7 @@ static struct platform_driver ve_spc_cpufreq_platdrv = {
 };
 module_platform_driver(ve_spc_cpufreq_platdrv);
 
+MODULE_ALIAS("platform:vexpress-spc-cpufreq");
 MODULE_AUTHOR("Viresh Kumar <viresh.kumar@linaro.org>");
 MODULE_AUTHOR("Sudeep Holla <sudeep.holla@arm.com>");
 MODULE_DESCRIPTION("Vexpress SPC ARM big LITTLE cpufreq driver");
-- 
2.20.1

