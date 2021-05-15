Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DEFC433ED
	for <linux-pm@archiver.kernel.org>; Sat, 15 May 2021 11:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06CD6613DF
	for <linux-pm@archiver.kernel.org>; Sat, 15 May 2021 11:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhEOLRM (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 15 May 2021 07:17:12 -0400
Received: from 64.52.23.98.static.skysilk.com ([64.52.23.98]:36922 "EHLO
        mail.noureddine.xyz" rhost-flags-OK-FAIL-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhEOLRM (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 15 May 2021 07:17:12 -0400
X-Greylist: delayed 370 seconds by postgrey-1.27 at vger.kernel.org; Sat, 15 May 2021 07:17:12 EDT
Received: from [192.168.1.102] (unknown [102.101.210.212])
        by mail.noureddine.xyz (Postfix) with ESMTPSA id 621AB140537;
        Sat, 15 May 2021 11:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=noureddine.xyz;
        s=mail; t=1621076987;
        bh=1pHFjZiWAzK6MmPit73cftvbDQ1+eCR8GNQDo1VmIEA=;
        h=To:Cc:From:Subject:Date:From;
        b=1sSaSZFQ78GkEecYw84fdp1ikLG/dT18ByqNXy3yL/3U3ytc9q1w0jQsO/z8PJkAh
         hHIyKjWZjT8HLs/ET42SviZXIITa3OeqbECXLeON1MY8AezWK95ibvz/I6+bmCwwJw
         ibcuea3I/wpUGRTjEXye3Po15Qi2WPUvluXTAwRkZ4KVMrKEaiG+jV5aHdVTHR/eOP
         I0VmllMUDkguP+P1MkNAyUaHV109TAzdWvtOBhwsEg7tx37lEX8IUWElp+mhE3z8iK
         EBBxW2uu92ur1NB+L+yImKYy12sOp5bP2z1oTng+25SgxwCvmwOPCNuBUpqh5/hVLl
         Zd2uqOGCrkd2g==
To:     sre@kernel.org, matti.vaittinen@fi.rohmeurope.com
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-power@fi.rohmeurope.com
From:   Nour-eddine Taleb <contact@noureddine.xyz>
Subject: [PATCH] power: supply: code cleanup
Message-ID: <31d85698-0fc0-6dcc-d3fc-41151f79a9cb@noureddine.xyz>
Date:   Sat, 15 May 2021 11:09:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

replace declarations like:
	char *foo = "bar";
with:
	char foo[] = "bar"
because the first declaration creates two variables, one for the string,
and the second for the pointer to the string.
while the second declaration create just one variable for the string,
which makes smaller bin.

Signed-off-by: Nour-eddine Taleb <contact@noureddine.xyz>
---
  drivers/power/supply/act8945a_charger.c | 4 ++--
  drivers/power/supply/bd70528-charger.c  | 4 ++--
  2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/power/supply/act8945a_charger.c 
b/drivers/power/supply/act8945a_charger.c
index e9b5f4283772..d7002b30e74c 100644
--- a/drivers/power/supply/act8945a_charger.c
+++ b/drivers/power/supply/act8945a_charger.c
@@ -15,8 +15,8 @@
  #include <linux/regmap.h>
  #include <linux/gpio/consumer.h>

-static const char *act8945a_charger_model = "ACT8945A";
-static const char *act8945a_charger_manufacturer = "Active-semi";
+static const char act8945a_charger_model[] = "ACT8945A";
+static const char act8945a_charger_manufacturer[] = "Active-semi";

  /*
   * ACT8945A Charger Register Map
diff --git a/drivers/power/supply/bd70528-charger.c 
b/drivers/power/supply/bd70528-charger.c
index 7c1f0b99c71b..0b7575ed80d5 100644
--- a/drivers/power/supply/bd70528-charger.c
+++ b/drivers/power/supply/bd70528-charger.c
@@ -87,8 +87,8 @@
  #define CHG_STAT_TSD_TOPOFF	0x22
  #define CHG_STAT_BAT_ERR	0x7f

-static const char *bd70528_charger_model = "BD70528";
-static const char *bd70528_charger_manufacturer = "ROHM Semiconductors";
+static const char bd70528_charger_model[] = "BD70528";
+static const char bd70528_charger_manufacturer[] = "ROHM Semiconductors";

  #define BD_ERR_IRQ_HND(_name_, _wrn_)					\
  static irqreturn_t bd0528_##_name_##_interrupt(int irq, void *arg)	\
-- 
2.30.2

