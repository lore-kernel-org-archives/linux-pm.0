Return-Path: <linux-pm-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41145C001DB
	for <linux-pm@archiver.kernel.org>; Sat,  2 Sep 2023 19:33:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjIBTdm (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 2 Sep 2023 15:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjIBTdk (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 2 Sep 2023 15:33:40 -0400
Received: from relmlie6.idc.renesas.com (relmlor2.renesas.com [210.160.252.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 518BCCE0;
        Sat,  2 Sep 2023 12:33:36 -0700 (PDT)
X-IronPort-AV: E=Sophos;i="6.02,223,1688396400"; 
   d="scan'208";a="178511804"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie6.idc.renesas.com with ESMTP; 03 Sep 2023 04:33:35 +0900
Received: from localhost.localdomain (unknown [10.226.92.16])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 538674003890;
        Sun,  3 Sep 2023 04:33:33 +0900 (JST)
From:   Biju Das <biju.das.jz@bp.renesas.com>
To:     Sebastian Reichel <sre@kernel.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH 0/2] Match data improvements for bq24257_charger driver
Date:   Sat,  2 Sep 2023 20:33:29 +0100
Message-Id: <20230902193331.83672-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

This patch series aims to add match data improvements for bq24257_charger
driver.

This patch series is only compile tested.

Biju Das (2):
  power: supply: bq24257_charger: Make chip type and name in sync
  power: supply: bq24257_charger: Some cleanups

 drivers/power/supply/bq24257_charger.c | 76 +++++++++++++-------------
 1 file changed, 38 insertions(+), 38 deletions(-)

-- 
2.25.1

