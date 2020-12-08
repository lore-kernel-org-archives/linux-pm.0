Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EA6EC2BBD4
	for <linux-pm@archiver.kernel.org>; Tue,  8 Dec 2020 17:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7742C23B88
	for <linux-pm@archiver.kernel.org>; Tue,  8 Dec 2020 17:42:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730782AbgLHRm1 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 8 Dec 2020 12:42:27 -0500
Received: from foss.arm.com ([217.140.110.172]:52434 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727998AbgLHRm0 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 8 Dec 2020 12:42:26 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 030CC142F;
        Tue,  8 Dec 2020 09:41:41 -0800 (PST)
Received: from ubuntu.cambridge.arm.com (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id E15EB3F68F;
        Tue,  8 Dec 2020 09:41:37 -0800 (PST)
From:   Nicola Mazzucato <nicola.mazzucato@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        sudeep.holla@arm.com, rjw@rjwysocki.net, vireshk@kernel.org,
        robh+dt@kernel.org, sboyd@kernel.org, nm@ti.com
Cc:     daniel.lezcano@linaro.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com, nicola.mazzucato@arm.com
Subject: [PATCH v5 4/4] cpufreq: blacklist Arm Vexpress platforms in cpufreq-dt-platdev
Date:   Tue,  8 Dec 2020 17:42:29 +0000
Message-Id: <20201208174229.24323-5-nicola.mazzucato@arm.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20201208174229.24323-1-nicola.mazzucato@arm.com>
References: <20201208174229.24323-1-nicola.mazzucato@arm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Sudeep Holla <sudeep.holla@arm.com>

Add "arm,vexpress" to cpufreq-dt-platdev blacklist since the actual
scaling is handled by the firmware cpufreq drivers(scpi, scmi and
vexpress-spc).

Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index bd2db0188cbb..91e6a0c10dbf 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -103,6 +103,8 @@ static const struct of_device_id whitelist[] __initconst = {
 static const struct of_device_id blacklist[] __initconst = {
 	{ .compatible = "allwinner,sun50i-h6", },
 
+	{ .compatible = "arm,vexpress", },
+
 	{ .compatible = "calxeda,highbank", },
 	{ .compatible = "calxeda,ecx-2000", },
 
-- 
2.27.0

