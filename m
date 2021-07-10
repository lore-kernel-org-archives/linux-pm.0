Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8585C07E9B
	for <linux-pm@archiver.kernel.org>; Sat, 10 Jul 2021 23:52:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6217613F0
	for <linux-pm@archiver.kernel.org>; Sat, 10 Jul 2021 23:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234001AbhGJXzK (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 10 Jul 2021 19:55:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40800 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233322AbhGJXyJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 10 Jul 2021 19:54:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 82975613F0;
        Sat, 10 Jul 2021 23:51:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1625961075;
        bh=vlhTaWuRPTY+zCBeoALKBFA9mfR5UqFCjXRXlrpTVbk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OI+I3IB+4Vl2KkaDf16BB6SZnbIJCIaB/K1fKprP2hGzzbYmydDwKcLe5istfrV1Y
         mOU2c4nlpbD6zi5/VRzMk9FjK7Cq7gh0ItyTYmC9ar9QXGmJTXwJdtIlpUzy10hI8b
         dMPl3cobQWrGJKyDYMwxaMMAXZ9XXoAqg3+eqUmkaw3TB/ca0JdUbJ5XcIjMxlDudU
         GcxnMBvL0XAJFZl+Lo8c8TOm+WWJ2h1A1kMWkVly7aVhYCkx5JQFjKygGYgmEzJ8Fm
         YeZ+3VWfmkh2d6NF4r1RiK20IX/2axliW8BLvR2LhnFStRv+BX/47cE9VXs40ilss8
         L1yGbd28y93sQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Bixuan Cui <cuibixuan@huawei.com>, Hulk Robot <hulkci@huawei.com>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Sasha Levin <sashal@kernel.org>, linux-pm@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 06/28] power: reset: gpio-poweroff: add missing MODULE_DEVICE_TABLE
Date:   Sat, 10 Jul 2021 19:50:45 -0400
Message-Id: <20210710235107.3221840-6-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210710235107.3221840-1-sashal@kernel.org>
References: <20210710235107.3221840-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Bixuan Cui <cuibixuan@huawei.com>

[ Upstream commit ed3443fb4df4e140a22f65144546c8a8e1e27f4e ]

This patch adds missing MODULE_DEVICE_TABLE definition which generates
correct modalias for automatic loading of this driver when it is built
as an external module.

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/reset/gpio-poweroff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/reset/gpio-poweroff.c b/drivers/power/reset/gpio-poweroff.c
index 6a4bbb506551..97d1f58efef4 100644
--- a/drivers/power/reset/gpio-poweroff.c
+++ b/drivers/power/reset/gpio-poweroff.c
@@ -90,6 +90,7 @@ static const struct of_device_id of_gpio_poweroff_match[] = {
 	{ .compatible = "gpio-poweroff", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, of_gpio_poweroff_match);
 
 static struct platform_driver gpio_poweroff_driver = {
 	.probe = gpio_poweroff_probe,
-- 
2.30.2

