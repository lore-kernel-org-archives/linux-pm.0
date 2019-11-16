Return-Path: <SRS0=VRae=ZI=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8F6C432C3
	for <linux-pm@archiver.kernel.org>; Sat, 16 Nov 2019 16:10:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7BDAD2089D
	for <linux-pm@archiver.kernel.org>; Sat, 16 Nov 2019 16:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1573920631;
	bh=Dr/MgV0CT6e61/f8fbdA16ZEvfZhrv4OxigPBFLptW0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=qUvMF8RA7r5H1rOYO0aR+lBChitkTBuOZcusha3iQg7i8uc6C56k+t1IFNzBs36Q+
	 5XNLgLELmoSlfvR5idx2/lm7CE4fla7eIPNlQTGrZMzoTJUev5yDcAcjaA7FfN4i33
	 LxU39wx1bry3fEbO1NiylQE8ODyimmEzMnoVjiKk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730219AbfKPPsy (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 16 Nov 2019 10:48:54 -0500
Received: from mail.kernel.org ([198.145.29.99]:56252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730208AbfKPPsy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 16 Nov 2019 10:48:54 -0500
Received: from sasha-vm.mshome.net (unknown [50.234.116.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E8B822086A;
        Sat, 16 Nov 2019 15:48:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1573919333;
        bh=Dr/MgV0CT6e61/f8fbdA16ZEvfZhrv4OxigPBFLptW0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjMish9SvTdNTUQDc+xXENSbndt8dydOwnXokEvvHifxvXt7OjgnaEK+uBsmCgxli
         pGafN/YoDpd+3LtsHVkV1IVlON4ZDxS6OwXX+YyWpI8n3rt6OJWKFBWEJfuNCDuVCb
         MQYa4gdU+AXQ4ige0PMXlT+qXN2bK6js9m0AQZMc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 074/150] thermal: rcar_thermal: Prevent hardware access during system suspend
Date:   Sat, 16 Nov 2019 10:46:12 -0500
Message-Id: <20191116154729.9573-74-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191116154729.9573-1-sashal@kernel.org>
References: <20191116154729.9573-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

[ Upstream commit 3a31386217628ffe2491695be2db933c25dde785 ]

On r8a7791/koelsch, sometimes the following message is printed during
system suspend:

    rcar_thermal e61f0000.thermal: thermal sensor was broken

This happens if the workqueue runs while the device is already
suspended.  Fix this by using the freezable system workqueue instead,
cfr. commit 51e20d0e3a60cf46 ("thermal: Prevent polling from happening
during system suspend").

Fixes: e0a5172e9eec7f0d ("thermal: rcar: add interrupt support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/rcar_thermal.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/rcar_thermal.c b/drivers/thermal/rcar_thermal.c
index 73e5fee6cf1d5..83126e2dce36d 100644
--- a/drivers/thermal/rcar_thermal.c
+++ b/drivers/thermal/rcar_thermal.c
@@ -401,8 +401,8 @@ static irqreturn_t rcar_thermal_irq(int irq, void *data)
 	rcar_thermal_for_each_priv(priv, common) {
 		if (rcar_thermal_had_changed(priv, status)) {
 			rcar_thermal_irq_disable(priv);
-			schedule_delayed_work(&priv->work,
-					      msecs_to_jiffies(300));
+			queue_delayed_work(system_freezable_wq, &priv->work,
+					   msecs_to_jiffies(300));
 		}
 	}
 
-- 
2.20.1

