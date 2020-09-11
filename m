Return-Path: <SRS0=D55B=CU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D6E3C43461
	for <linux-pm@archiver.kernel.org>; Fri, 11 Sep 2020 16:28:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42F21221ED
	for <linux-pm@archiver.kernel.org>; Fri, 11 Sep 2020 16:28:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599841719;
	bh=SJd5CI1KP1E/Et9NZrPzsk7fHtv8JHscc1UZms8YxxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yY3iCSaYvovvMcdqaxXgWaGfKRYoghpsyEC2vxQsTThlgpECWK8R5yPd4Do8zDyi5
	 Ztx5uSdE/jYVDbXqyKghm8IkTncCpEJK4QaA9p42OcP13WWyZqf0Lz2DQp74YJ6kjn
	 iUFo1tZycK2hp7HKjb4XeG7Kv2xDoU7hS1zrt5+k=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726206AbgIKQ2a (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:28:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60726 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgIKQ1m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Sep 2020 12:27:42 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1CA2522205;
        Fri, 11 Sep 2020 16:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599841662;
        bh=SJd5CI1KP1E/Et9NZrPzsk7fHtv8JHscc1UZms8YxxA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nV1L58zRzj1EX6zIljWJ4whhcKA9+RwFeDek2GIZ4ZWCvahgQ6ct6ufy2YwEsi6Ny
         etsonevEDJ5wwqbJSiMZpwUcqVvq0nBr78j+/GscyY5avDUH1Jc3QnlOocI6A2txYo
         WPxUY+BJ7NAmori0uuS56zO8GmM+uRf/iBaA26lw=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 5/7] power: supply: rt9455: skip 'struct acpi_device_id' when !CONFIG_ACPI
Date:   Fri, 11 Sep 2020 18:27:27 +0200
Message-Id: <20200911162729.3022-5-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911162729.3022-1-krzk@kernel.org>
References: <20200911162729.3022-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since ACPI_PTR() is used to NULLify the value when !CONFIG_ACPI, the
struct acpi_device_id becomes unused:

  drivers/power/supply/rt9455_charger.c:1734:36: warning:
    'rt9455_i2c_acpi_match' defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/rt9455_charger.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/rt9455_charger.c b/drivers/power/supply/rt9455_charger.c
index 29161ae90245..594bb3b8a4d1 100644
--- a/drivers/power/supply/rt9455_charger.c
+++ b/drivers/power/supply/rt9455_charger.c
@@ -1731,11 +1731,13 @@ static const struct of_device_id rt9455_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, rt9455_of_match);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id rt9455_i2c_acpi_match[] = {
 	{ "RT945500", 0 },
 	{ }
 };
 MODULE_DEVICE_TABLE(acpi, rt9455_i2c_acpi_match);
+#endif
 
 static struct i2c_driver rt9455_driver = {
 	.probe		= rt9455_probe,
-- 
2.17.1

