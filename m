Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67713C433F5
	for <linux-pm@archiver.kernel.org>; Fri,  8 Apr 2022 07:59:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230300AbiDHIBX (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Fri, 8 Apr 2022 04:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230321AbiDHIBE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 8 Apr 2022 04:01:04 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF7B829341C;
        Fri,  8 Apr 2022 00:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649404726; x=1680940726;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LjlPOOL1nwB6NN3xgp5+k5dkaE5an7Nmiez6lWR6k+o=;
  b=lGZsgTGzS9MF0EAKhF4GSzPZ78iW0zpBsserV8E6i4aUImpGnw+fug4s
   nwcBBDzF5wmbeKnISp/jC/GksKCsLf+JyPLSdAZrCxI9DQIiv0kAWLt7G
   w4YNw47LYPvVQTgGuMUpvKYV7lqR27+Rw6gIEVe87kiP9rJRbswrIpK+R
   lsICjN80DrcjcAmX4d/lk01Vdnh+EeU0Ywa1xICVP+DrHWs56dNFJciI5
   rCMMGjk4ftFpNdyWjjXbq8v8BUQseni4NGCLtNdB3fBDLxM79iFNgJnJx
   gtPhNKSKktkiOOYom6c67Hk7k0Fqn/IGgK8WR6iBHO3SKOAu83PcH8eo6
   A==;
X-IronPort-AV: E=Sophos;i="5.90,244,1643698800"; 
   d="scan'208";a="91735420"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Apr 2022 00:58:45 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 8 Apr 2022 00:58:45 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Fri, 8 Apr 2022 00:58:42 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <linux@armlinux.org.uk>, <sre@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <cristian.birsan@microchip.com>, <linux-pm@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH v3 08/10] power: reset: at91-reset: add support for SAMA7G5
Date:   Fri, 8 Apr 2022 11:00:29 +0300
Message-ID: <20220408080031.2527232-9-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20220408080031.2527232-1-claudiu.beznea@microchip.com>
References: <20220408080031.2527232-1-claudiu.beznea@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add support for SAMA7G5 including reset_controller_dev support for 3 lines
(which are USB PHYs).

Signed-off-by: Claudiu Beznea <claudiu.beznea@microchip.com>
---
 drivers/power/reset/at91-reset.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/power/reset/at91-reset.c b/drivers/power/reset/at91-reset.c
index e25d8d38a2f8..80bf0c023c17 100644
--- a/drivers/power/reset/at91-reset.c
+++ b/drivers/power/reset/at91-reset.c
@@ -202,6 +202,11 @@ static const struct at91_reset_data samx7 = {
 	.reset_args = AT91_RSTC_KEY | AT91_RSTC_PROCRST,
 };
 
+static const struct at91_reset_data sama7g5 = {
+	.reset_args = AT91_RSTC_KEY | AT91_RSTC_PROCRST,
+	.n_device_reset = 3,
+};
+
 static const struct of_device_id at91_reset_of_match[] = {
 	{
 		.compatible = "atmel,at91sam9260-rstc",
@@ -223,6 +228,10 @@ static const struct of_device_id at91_reset_of_match[] = {
 		.compatible = "microchip,sam9x60-rstc",
 		.data = &samx7,
 	},
+	{
+		.compatible = "microchip,sama7g5-rstc",
+		.data = &sama7g5,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, at91_reset_of_match);
-- 
2.32.0

