Return-Path: <SRS0=f5dP=7M=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D855CC433E0
	for <linux-pm@archiver.kernel.org>; Sat, 30 May 2020 16:40:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A86AA207D5
	for <linux-pm@archiver.kernel.org>; Sat, 30 May 2020 16:40:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728998AbgE3Qkf (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 30 May 2020 12:40:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:33181 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728797AbgE3Qke (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Sat, 30 May 2020 12:40:34 -0400
IronPort-SDR: IMgn3zVL4j5nhkKM+rwJS/3BnvAWGmhqNXVTiVyxZH72cn9HF4+dvspdywb+I2oudAJ3MhCx1y
 wKbOxLTsBt9Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2020 09:40:34 -0700
IronPort-SDR: pBcmbwceL4vwrd0iFMvcBWa5H2aGsaXCl1JwbUHAjEBTHsIaKWch7Nrg4sbyqK3CntVWtV82T8
 Mg8Lekmca+uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,452,1583222400"; 
   d="scan'208";a="256812472"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 30 May 2020 09:40:32 -0700
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 6B2AEBD; Sat, 30 May 2020 19:40:31 +0300 (EEST)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tobias Schrammm <t.schramm@manjaro.org>, linux-pm@vger.kernel.org,
        Sebastian Reichel <sre@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        kbuild test robot <lkp@intel.com>
Subject: [PATCH v1] power: supply: cw2015: Attach OF ID table to the driver
Date:   Sat, 30 May 2020 19:40:30 +0300
Message-Id: <20200530164030.47884-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

It appears that OF ID table was hanging around without being attached
to the driver. Attach it properly.

Fixes: b4c7715c10c1 ("power: supply: add CellWise cw2015 fuel gauge driver")
Reported-by: kbuild test robot <lkp@intel.com>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/power/supply/cw2015_battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/cw2015_battery.c b/drivers/power/supply/cw2015_battery.c
index 19f62ea957ee..0146f1bfc29b 100644
--- a/drivers/power/supply/cw2015_battery.c
+++ b/drivers/power/supply/cw2015_battery.c
@@ -734,6 +734,7 @@ MODULE_DEVICE_TABLE(of, cw2015_of_match);
 static struct i2c_driver cw_bat_driver = {
 	.driver = {
 		.name = "cw2015",
+		.of_match_table = cw2015_of_match,
 		.pm = &cw_bat_pm_ops,
 	},
 	.probe_new = cw_bat_probe,
-- 
2.27.0.rc2

