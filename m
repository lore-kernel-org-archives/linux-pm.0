Return-Path: <SRS0=fxtO=DU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9103C433E7
	for <linux-pm@archiver.kernel.org>; Tue, 13 Oct 2020 14:15:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85BAE247F7
	for <linux-pm@archiver.kernel.org>; Tue, 13 Oct 2020 14:15:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388541AbgJMOPI (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 13 Oct 2020 10:15:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388538AbgJMOPH (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Oct 2020 10:15:07 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70137C0613D0
        for <linux-pm@vger.kernel.org>; Tue, 13 Oct 2020 07:15:07 -0700 (PDT)
Received: from ramsan ([84.195.186.194])
        by albert.telenet-ops.be with bizsmtp
        id fSF52300Q4C55Sk06SF5rK; Tue, 13 Oct 2020 16:15:06 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan with esmtp (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kSL4z-0006XK-KS; Tue, 13 Oct 2020 16:15:05 +0200
Received: from geert by rox.of.borg with local (Exim 4.90_1)
        (envelope-from <geert@linux-m68k.org>)
        id 1kSL4z-0007S1-Hw; Tue, 13 Oct 2020 16:15:05 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] PM: Domains: Add curly braces to delimit comment + statement block
Date:   Tue, 13 Oct 2020 16:14:59 +0200
Message-Id: <20201013141459.28599-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

There is not strict need to group a comment and a single statement in an
if block, as comments are stripped by the pre-processor.  However,
adding curly braces does make the code easier to read, and may avoid
mistakes when changing the code later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/base/power/domain.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
index 05bb4d4401b26e44..f4a28c33fafa03b2 100644
--- a/drivers/base/power/domain.c
+++ b/drivers/base/power/domain.c
@@ -1270,13 +1270,14 @@ static int genpd_restore_noirq(struct device *dev)
 	 * first time for the given domain in the present cycle.
 	 */
 	genpd_lock(genpd);
-	if (genpd->suspended_count++ == 0)
+	if (genpd->suspended_count++ == 0) {
 		/*
 		 * The boot kernel might put the domain into arbitrary state,
 		 * so make it appear as powered off to genpd_sync_power_on(),
 		 * so that it tries to power it on in case it was really off.
 		 */
 		genpd->status = GENPD_STATE_OFF;
+	}
 
 	genpd_sync_power_on(genpd, true, 0);
 	genpd_unlock(genpd);
-- 
2.17.1

