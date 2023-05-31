Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73558C7EE2E
	for <linux-pm@archiver.kernel.org>; Wed, 31 May 2023 13:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237210AbjEaNvT (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 31 May 2023 09:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237479AbjEaNun (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 31 May 2023 09:50:43 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05C2D1BFF;
        Wed, 31 May 2023 06:46:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D880863B7F;
        Wed, 31 May 2023 13:46:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86E1FC433EF;
        Wed, 31 May 2023 13:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685540773;
        bh=zbqPbSENyw3DdOvFt3+ZGl33ytCQkw9IgcL13hy02bQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sjICuIEGehnCrcPO4hNxskQeDaet4ANjSG9ltT3A14J9Ho3FI2lEJi68zbiSfqI1N
         zk40btF+AMGmV27rCMe1N7bCnWMosKPt01ULqWrWnoMeRE6yODzV0VzRxtQFGaHqEX
         IXROasmnGHpIiXDcALEO+rH0ll7SqGTsTIniSW8Yb3bYat8MIqGILne5j9DL6KP0E+
         e1NP43iEbIM2VPD4m9hx1kaW2FjTm4JtrVk3VGz95QMp/N/2v5yT3Re68XB/M7E476
         8Kk2oBh+IVDAe8tXrrWfD7/W2rOCaAMNjZO9o1N9vpX7023QrL1sSEKXsaK1T513fX
         CqLlpvcLL/Mog==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Marek Vasut <marex@denx.de>, Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, sre@kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 04/10] power: supply: Ratelimit no data debug output
Date:   Wed, 31 May 2023 09:46:00 -0400
Message-Id: <20230531134606.3385210-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230531134606.3385210-1-sashal@kernel.org>
References: <20230531134606.3385210-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Marek Vasut <marex@denx.de>

[ Upstream commit 155c45a25679f571c2ae57d10db843a9dfc63430 ]

Reduce the amount of output this dev_dbg() statement emits into logs,
otherwise if system software polls the sysfs entry for data and keeps
getting -ENODATA, it could end up filling the logs up.

This does in fact make systemd journald choke, since during boot the
sysfs power supply entries are polled and if journald starts at the
same time, the journal is just being repeatedly filled up, and the
system stops on trying to start journald without booting any further.

Signed-off-by: Marek Vasut <marex@denx.de>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/power_supply_sysfs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index 2ccaf4ff4be47..2cb8a31e9dac0 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -88,7 +88,8 @@ static ssize_t power_supply_show_property(struct device *dev,
 
 		if (ret < 0) {
 			if (ret == -ENODATA)
-				dev_dbg(dev, "driver has no data for `%s' property\n",
+				dev_dbg_ratelimited(dev,
+					"driver has no data for `%s' property\n",
 					attr->attr.name);
 			else if (ret != -ENODEV && ret != -EAGAIN)
 				dev_err_ratelimited(dev,
-- 
2.39.2

