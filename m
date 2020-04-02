Return-Path: <SRS0=3neH=5S=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5DFC43331
	for <linux-pm@archiver.kernel.org>; Thu,  2 Apr 2020 14:57:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0746F20757
	for <linux-pm@archiver.kernel.org>; Thu,  2 Apr 2020 14:57:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=rere.qmqm.pl header.i=@rere.qmqm.pl header.b="hoS09uFW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388921AbgDBO5E (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 2 Apr 2020 10:57:04 -0400
Received: from rere.qmqm.pl ([91.227.64.183]:31914 "EHLO rere.qmqm.pl"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388761AbgDBO5E (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Thu, 2 Apr 2020 10:57:04 -0400
Received: from remote.user (localhost [127.0.0.1])
        by rere.qmqm.pl (Postfix) with ESMTPSA id 48tR3y0BTCzHd;
        Thu,  2 Apr 2020 16:57:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=rere.qmqm.pl; s=1;
        t=1585839422; bh=8lunpxS98lM0f3PoyUteDz8Xwp4fV51FcDnCqkylrZA=;
        h=Date:In-Reply-To:References:From:Subject:To:Cc:From;
        b=hoS09uFW+GPXuh1z+aIpbT5MAjC6fnIv73IWsJ6Kx81UG0BtmCdCXIn0NpweywAKf
         DssCFHbtDscIkD5JbBxkg4+UZ+Z2b4LDO4WIDkJGu2qhusWOWh0VaXX/xGUE9KcIkm
         4L4Ig3fCovSKv1E/Bm4Zx3LSTZQ9xOVo2MzkjRG4xtvJ+tCdqKPm4/zfIcqh71dN2F
         hXugqAitTvANvZCHLlGrD2qWnUaErvnhyMPYwsac0wyZp9HwtLWzdw4vwKgVUJoWnN
         mznrqbWtMMLTTEtS+yb3T8b+jyqKFKFAnohlc8j03SnPLtnzUCPBXDKTR4oayf2Zdr
         4OcC+gLo+egYg==
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.102.2 at mail
Date:   Thu, 02 Apr 2020 16:57:01 +0200
Message-Id: <cdf9c0b02acdee77721039d4e7557e0e232d837d.1585837575.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1585837575.git.mirq-linux@rere.qmqm.pl>
References: <cover.1585837575.git.mirq-linux@rere.qmqm.pl>
From:   =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH 1/7] power: supply: core: reduce power_supply_show_usb_type()
 parameters
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     Andrey Smirnov <andrew.smirnov@gmail.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Reduce power_supply_show_usb_type() parameter count by folding
power_supply_desc dereference into the function.  This makes following
patch making usb_types const easier.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/power/supply/power_supply_sysfs.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/power/supply/power_supply_sysfs.c b/drivers/power/supply/power_supply_sysfs.c
index f37ad4eae60b..51de3f47b25d 100644
--- a/drivers/power/supply/power_supply_sysfs.c
+++ b/drivers/power/supply/power_supply_sysfs.c
@@ -78,8 +78,7 @@ static const char * const power_supply_scope_text[] = {
 };
 
 static ssize_t power_supply_show_usb_type(struct device *dev,
-					  enum power_supply_usb_type *usb_types,
-					  ssize_t num_usb_types,
+					  const struct power_supply_desc *desc,
 					  union power_supply_propval *value,
 					  char *buf)
 {
@@ -88,8 +87,8 @@ static ssize_t power_supply_show_usb_type(struct device *dev,
 	bool match = false;
 	int i;
 
-	for (i = 0; i < num_usb_types; ++i) {
-		usb_type = usb_types[i];
+	for (i = 0; i < desc->num_usb_types; ++i) {
+		usb_type = desc->usb_types[i];
 
 		if (value->intval == usb_type) {
 			count += sprintf(buf + count, "[%s] ",
@@ -163,8 +162,7 @@ static ssize_t power_supply_show_property(struct device *dev,
 			      power_supply_type_text[value.intval]);
 		break;
 	case POWER_SUPPLY_PROP_USB_TYPE:
-		ret = power_supply_show_usb_type(dev, psy->desc->usb_types,
-						 psy->desc->num_usb_types,
+		ret = power_supply_show_usb_type(dev, psy->desc,
 						 &value, buf);
 		break;
 	case POWER_SUPPLY_PROP_SCOPE:
-- 
2.20.1

