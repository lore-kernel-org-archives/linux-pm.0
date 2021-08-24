Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6845C432BE
	for <linux-pm@archiver.kernel.org>; Tue, 24 Aug 2021 15:23:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B60E661265
	for <linux-pm@archiver.kernel.org>; Tue, 24 Aug 2021 15:23:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238280AbhHXPYm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 24 Aug 2021 11:24:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238298AbhHXPYi (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 24 Aug 2021 11:24:38 -0400
Received: from xavier.telenet-ops.be (xavier.telenet-ops.be [IPv6:2a02:1800:120:4::f00:14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6934C0617A8
        for <linux-pm@vger.kernel.org>; Tue, 24 Aug 2021 08:23:52 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed20:fd1d:ce2:c16e:185a])
        by xavier.telenet-ops.be with bizsmtp
        id lTPg2500C4wgRL101TPgjF; Tue, 24 Aug 2021 17:23:51 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mIYH6-005TjI-5r; Tue, 24 Aug 2021 17:23:40 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1mIYH5-00D1YB-My; Tue, 24 Aug 2021 17:23:39 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rajendra Nayak <rnayak@codeaurora.org>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PM: domains: Fix domain attach for CONFIG_PM_OPP=n
Date:   Tue, 24 Aug 2021 17:23:38 +0200
Message-Id: <4fb42fa1b76b38c6628f056cfd804bb5b4e74d99.1629818532.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

If CONFIG_PM_OPP=n, of_get_required_opp_performance_state() always
returns -EOPNOTSUPP, and all drivers for devices that are part of a PM
Domain fail to probe with:

    failed to set required performance state for power-domain foo: -95
    probe of bar failed with error -95

Fix this by treating -EOPNOTSUPP the same as -ENODEV.

Fixes: c016baf7dc58e77a ("PM: domains: Add support for 'required-opps' to set default perf state")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/power/domain.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index a10d740c4f2a1c28..7b197690e6442911 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -2760,7 +2760,7 @@ static int __genpd_dev_pm_attach(struct device *dev, struct device *base_dev,
 
 	/* Set the default performance state */
 	pstate = of_get_required_opp_performance_state(dev->of_node, index);
-	if (pstate < 0 && pstate != -ENODEV) {
+	if (pstate < 0 && pstate != -ENODEV && pstate != -EOPNOTSUPP) {
 		ret = pstate;
 		goto err;
 	} else if (pstate > 0) {
-- 
2.25.1

