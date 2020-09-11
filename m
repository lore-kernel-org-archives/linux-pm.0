Return-Path: <SRS0=D55B=CU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA66C43461
	for <linux-pm@archiver.kernel.org>; Fri, 11 Sep 2020 16:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB8C322224
	for <linux-pm@archiver.kernel.org>; Fri, 11 Sep 2020 16:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599841711;
	bh=qu+lbVaMlZCIg+s7vOyGDHOqZHqP4+Sau/I820OhUno=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=CCzJOolxZICUnprJQkUAXk6rkX+LrAF6v5hUq2IboZC3wBIrkvuGjkxzodQh7v1lK
	 5djVZ389yKTl8sK0BLQ2+oW9JFMSCpUI3PNVIA0FxUpgfX2lXNkpBGZOvzKvNbr+KN
	 zyv1Guk352+c+YvgYojNfX4gqYnrLZGl2w2e9Qm0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726421AbgIKQ2a (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:28:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:60714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726481AbgIKQ1m (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Fri, 11 Sep 2020 12:27:42 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B42322206;
        Fri, 11 Sep 2020 16:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599841660;
        bh=qu+lbVaMlZCIg+s7vOyGDHOqZHqP4+Sau/I820OhUno=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fyC9Um+D3EbXx++28IJIl9VkAIkDYBRn0b1idBw7TJumHowiEvXc5YMUiAlJLffuM
         gPM5VPUVu/zm2fgJsE5jF+DiXqHrXpCof9EMcWm0LcvecvTDs2IbDZeifFHLgyXvWu
         AkoR0w8cdrLLr7Hvj9lv7JSxu9vTc6bLlgKW9XpQ=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>,
        Jonathan Bakker <xc-racer2@live.ca>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 4/7] power: supply: goldfish: skip 'struct acpi_device_id' when !CONFIG_ACPI
Date:   Fri, 11 Sep 2020 18:27:26 +0200
Message-Id: <20200911162729.3022-4-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200911162729.3022-1-krzk@kernel.org>
References: <20200911162729.3022-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Since ACPI_PTR() is used to NULLify the value when !CONFIG_ACPI, the
struct acpi_device_id becomes unused:

  drivers/power/supply/goldfish_battery.c:269:36: warning:
    'goldfish_battery_acpi_match' defined but not used [-Wunused-const-variable=]

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/goldfish_battery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/supply/goldfish_battery.c b/drivers/power/supply/goldfish_battery.c
index c2644a9fe80f..bf1754355c9f 100644
--- a/drivers/power/supply/goldfish_battery.c
+++ b/drivers/power/supply/goldfish_battery.c
@@ -266,11 +266,13 @@ static const struct of_device_id goldfish_battery_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, goldfish_battery_of_match);
 
+#ifdef CONFIG_ACPI
 static const struct acpi_device_id goldfish_battery_acpi_match[] = {
 	{ "GFSH0001", 0 },
 	{ },
 };
 MODULE_DEVICE_TABLE(acpi, goldfish_battery_acpi_match);
+#endif
 
 static struct platform_driver goldfish_battery_device = {
 	.probe		= goldfish_battery_probe,
-- 
2.17.1

