Return-Path: <SRS0=+UCx=EJ=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB33CC388F9
	for <linux-pm@archiver.kernel.org>; Tue,  3 Nov 2020 15:13:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D75B221FB
	for <linux-pm@archiver.kernel.org>; Tue,  3 Nov 2020 15:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1604416410;
	bh=GnyvaB3CIoO3ENb2P26n4kskRM2MobqgcKQRTKcsjTE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=nVJNN3CD+a4zkJY6U7OEOvwDkkL6I7UeebT51l0vloz1h+7Fn00btHL3uwHe9mF7Q
	 JVr5HVjWJXpWA7fQxsI2CSg76EbFf5NX5MLjj992/xdQUFnB8YT4G2ZJknpHl0T2Y/
	 h4NV3kQC0SWopvCwNPDHjjQy2p7lCOTntQkHkIWU=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgKCPN3 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 3 Nov 2020 10:13:29 -0500
Received: from mail.kernel.org ([198.145.29.99]:56870 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728342AbgKCPME (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 3 Nov 2020 10:12:04 -0500
Received: from pali.im (pali.im [31.31.79.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 38717223EA;
        Tue,  3 Nov 2020 15:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1604416324;
        bh=GnyvaB3CIoO3ENb2P26n4kskRM2MobqgcKQRTKcsjTE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=2oBz9G542Z/agHXljbc07zwDGQqZX8XO8pftXthzpQg/m8TD65UHJPj1RDQytcR23
         G0p4hmuENID9oMXBxvzEPTdY6F5SRjw4VwJs0pnwvyAOeDr5Gwyr2LuAUYsMj4f9QF
         LfbKFQe1Dc9MXtun6AmxvPOn0uAPH84foOvXArbk=
Received: by pali.im (Postfix)
        id 348BD1A13; Tue,  3 Nov 2020 16:12:01 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 6/9] cpufreq: sun50i: Add missing MODULE_DEVICE_TABLE
Date:   Tue,  3 Nov 2020 16:11:36 +0100
Message-Id: <20201103151139.29690-7-pali@kernel.org>
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
Fixes: f328584f7bff8 ("cpufreq: Add sun50i nvmem based CPU scaling driver")
---
 drivers/cpufreq/sun50i-cpufreq-nvmem.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/sun50i-cpufreq-nvmem.c b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
index 9907a165135b..2deed8d8773f 100644
--- a/drivers/cpufreq/sun50i-cpufreq-nvmem.c
+++ b/drivers/cpufreq/sun50i-cpufreq-nvmem.c
@@ -167,6 +167,7 @@ static const struct of_device_id sun50i_cpufreq_match_list[] = {
 	{ .compatible = "allwinner,sun50i-h6" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, sun50i_cpufreq_match_list);
 
 static const struct of_device_id *sun50i_cpufreq_match_node(void)
 {
-- 
2.20.1

