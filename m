Return-Path: <SRS0=m8DM=3F=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A44FC33CB3
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jan 2020 18:12:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3CC5E20684
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jan 2020 18:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579198366;
	bh=SWROlE7V+AegruKAe7uxseBPi+wqjEPbe+ipJHpRFn4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=j2i7UUlfh9K61t32RpzCOUWx23UcDUJwAB/xI15C2aD5Ob83+7cVaQTkNGFbbJqyF
	 +sGnHbbDLaC5w535JOQsQ4ynuZvHSj6K8BYKx9bRZIpK56+pT0ohsMd101t338bS1G
	 Bqs1AMfCK0G+m1e+8cCXfw7M7Iuc5esUrM1hJ5LY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730031AbgAPRhG (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:37:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:52132 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729883AbgAPRhF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jan 2020 12:37:05 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B046E246B1;
        Thu, 16 Jan 2020 17:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579196225;
        bh=SWROlE7V+AegruKAe7uxseBPi+wqjEPbe+ipJHpRFn4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Wu4ltGHwjAPvNfya3teGxRbeVkaeubH1UGQNZCSVybMmf61K8BiFkpnuPykUBtUxX
         TrBKVKKcj9PyNl+OB70BQTVOeO/o8XDitkxwJyJU5lJOdbl97HrCKMI7oeaDtwTGQi
         V+oxdJYld7gCMsa+z1Jwx7PbaW42iwUDd89rpeOY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Michael Kao <michael.kao@mediatek.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH AUTOSEL 4.9 058/251] thermal: mediatek: fix register index error
Date:   Thu, 16 Jan 2020 12:33:27 -0500
Message-Id: <20200116173641.22137-18-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116173641.22137-1-sashal@kernel.org>
References: <20200116173641.22137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Michael Kao <michael.kao@mediatek.com>

[ Upstream commit eb9aecd90d1a39601e91cd08b90d5fee51d321a6 ]

The index of msr and adcpnp should match the sensor
which belongs to the selected bank in the for loop.

Fixes: b7cf0053738c ("thermal: Add Mediatek thermal driver for mt2701.")
Signed-off-by: Michael Kao <michael.kao@mediatek.com>
Signed-off-by: Eduardo Valentin <edubezval@gmail.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/mtk_thermal.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 34169c32d495..ea9558679634 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -348,7 +348,8 @@ static int mtk_thermal_bank_temperature(struct mtk_thermal_bank *bank)
 	u32 raw;
 
 	for (i = 0; i < conf->bank_data[bank->id].num_sensors; i++) {
-		raw = readl(mt->thermal_base + conf->msr[i]);
+		raw = readl(mt->thermal_base +
+			    conf->msr[conf->bank_data[bank->id].sensors[i]]);
 
 		temp = raw_to_mcelsius(mt,
 				       conf->bank_data[bank->id].sensors[i],
@@ -485,7 +486,8 @@ static void mtk_thermal_init_bank(struct mtk_thermal *mt, int num,
 
 	for (i = 0; i < conf->bank_data[num].num_sensors; i++)
 		writel(conf->sensor_mux_values[conf->bank_data[num].sensors[i]],
-		       mt->thermal_base + conf->adcpnp[i]);
+		       mt->thermal_base +
+		       conf->adcpnp[conf->bank_data[num].sensors[i]]);
 
 	writel((1 << conf->bank_data[num].num_sensors) - 1,
 	       mt->thermal_base + TEMP_MONCTL0);
-- 
2.20.1

