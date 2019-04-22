Return-Path: <SRS0=/Mn0=SY=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 794CEC282E1
	for <linux-pm@archiver.kernel.org>; Mon, 22 Apr 2019 20:43:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4800221738
	for <linux-pm@archiver.kernel.org>; Mon, 22 Apr 2019 20:43:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728631AbfDVUnE (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Mon, 22 Apr 2019 16:43:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42966 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727571AbfDVUnE (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Mon, 22 Apr 2019 16:43:04 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 019A03084212;
        Mon, 22 Apr 2019 20:43:04 +0000 (UTC)
Received: from shalem.localdomain.com (ovpn-116-58.ams2.redhat.com [10.36.116.58])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B6E855D6A6;
        Mon, 22 Apr 2019 20:43:02 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>, Chen-Yu Tsai <wens@csie.org>,
        linux-pm@vger.kernel.org, stable@vger.kernel.org
Subject: [PATCH] power: supply: axp288_fuel_gauge: Add ACEPC T8 and T11 mini PCs to the blacklist
Date:   Mon, 22 Apr 2019 22:43:01 +0200
Message-Id: <20190422204301.6233-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Mon, 22 Apr 2019 20:43:04 +0000 (UTC)
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190422204301.yZBiuiGPcnEe2ZrPG6Rlj2XtkDzX8Z8NGZqfeLqv-gI@z>

The ACEPC T8 and T11 Cherry Trail Z8350 mini PCs use an AXP288 and as PCs,
rather then portables, they does not have a battery. Still for some
reason the AXP288 not only thinks there is a battery, it actually
thinks it is discharging while the PC is running, slowly going to
0% full, causing userspace to shutdown the system due to the battery
being critically low after a while.

This commit adds the ACEPC T8 and T11 to the axp288 fuel-gauge driver
blacklist, so that we stop reporting bogus battery readings on this device.

BugLink: https://bugzilla.redhat.com/show_bug.cgi?id=1690852
Cc: stable@vger.kernel.org
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/power/supply/axp288_fuel_gauge.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/drivers/power/supply/axp288_fuel_gauge.c b/drivers/power/supply/axp288_fuel_gauge.c
index 9ff2461820d8..368281bc0d2b 100644
--- a/drivers/power/supply/axp288_fuel_gauge.c
+++ b/drivers/power/supply/axp288_fuel_gauge.c
@@ -685,6 +685,26 @@ static void fuel_gauge_init_irq(struct axp288_fg_info *info)
  * detection reports one despite it not being there.
  */
 static const struct dmi_system_id axp288_fuel_gauge_blacklist[] = {
+	{
+		/* ACEPC T8 Cherry Trail Z8350 mini PC */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "T8"),
+			/* also match on somewhat unique bios-version */
+			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
+		},
+	},
+	{
+		/* ACEPC T11 Cherry Trail Z8350 mini PC */
+		.matches = {
+			DMI_EXACT_MATCH(DMI_BOARD_VENDOR, "To be filled by O.E.M."),
+			DMI_EXACT_MATCH(DMI_BOARD_NAME, "Cherry Trail CR"),
+			DMI_EXACT_MATCH(DMI_PRODUCT_SKU, "T11"),
+			/* also match on somewhat unique bios-version */
+			DMI_EXACT_MATCH(DMI_BIOS_VERSION, "1.000"),
+		},
+	},
 	{
 		/* Intel Cherry Trail Compute Stick, Windows version */
 		.matches = {
-- 
2.21.0

