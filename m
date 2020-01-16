Return-Path: <SRS0=m8DM=3F=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A234C33CB3
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jan 2020 16:49:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB1FE2081E
	for <linux-pm@archiver.kernel.org>; Thu, 16 Jan 2020 16:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193339;
	bh=AmWo+liNG81NoGv2cQFWagdPVrvxxbqAsN7zg28/WJ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EHUQQtUDW1kDyQisSxLuoGe98cipy6kCPTDawgcFAzAeQcWUu8C7/ybCvpesINgzc
	 +2E6zn6wpUFQfgPbmqYblSREMmkb0jwa2T99tWF9dbehWcgivjT7v/uNbfuyoDxxpg
	 rvnwWF/CU9jMcdzLWQC/yj8mEP/yn8yh1yCgTVfQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729144AbgAPQsZ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:48:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:58658 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729058AbgAPQsZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 16 Jan 2020 11:48:25 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 35C1220663;
        Thu, 16 Jan 2020 16:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193304;
        bh=AmWo+liNG81NoGv2cQFWagdPVrvxxbqAsN7zg28/WJ8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BPofgXN6Ku9HHlw8K1MxchZVgJnUycv3uw60vmmpvHbIpLjo4BNfNoQw8oK1ByPxr
         ZiIpkueyBpzHnhstgDVlVsRNt/8m4A3/qf+qXDcCH6hzQeqg/XkmMh3DeFjDSlwu2F
         pqy0I+D4W/bB8DYd+gC2I25GhZirbvomwI+kIelk=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 070/205] power: supply: bd70528: Add MODULE_ALIAS to allow module auto loading
Date:   Thu, 16 Jan 2020 11:40:45 -0500
Message-Id: <20200116164300.6705-70-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>

[ Upstream commit 9480029fe5c24d482efad38dc631bd555fc7afe2 ]

The bd70528 charger driver is probed by MFD driver. Add MODULE_ALIAS
in order to allow udev to load the module when MFD sub-device cell for
charger is added.

Fixes: f8c7f7ddd8ef0 ("power: supply: Initial support for ROHM BD70528 PMIC charger block")
Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/bd70528-charger.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/bd70528-charger.c b/drivers/power/supply/bd70528-charger.c
index 1bb32b7226d7..b8e1ec106627 100644
--- a/drivers/power/supply/bd70528-charger.c
+++ b/drivers/power/supply/bd70528-charger.c
@@ -741,3 +741,4 @@ module_platform_driver(bd70528_power);
 MODULE_AUTHOR("Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>");
 MODULE_DESCRIPTION("BD70528 power-supply driver");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:bd70528-power");
-- 
2.20.1

