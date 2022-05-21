Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98A4EC43219
	for <linux-pm@archiver.kernel.org>; Sat, 21 May 2022 11:13:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352887AbiEULNk (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Sat, 21 May 2022 07:13:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350732AbiEULMQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Sat, 21 May 2022 07:12:16 -0400
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC6D2B244;
        Sat, 21 May 2022 04:12:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=54IWCUGGCd44a/vf5yEHvwTkwcuHywIaV6YBxOe4Ots=;
  b=UBOer3vGyYfWv3LkLnVG7eUHW6KdF4NAfl//Y6Z9Kg6hNjpHTFvQk7lX
   MkofMvNN9EELZuJhQNDTk/ueTt7o5Mbn757S5rrXdjnLB2AXs1FsQ//Bv
   Vx4Krz8QdHzMbRSpvxbkjFfXx/YViuZlr2cJAiMg+4kdfbFIBT+dsVqYv
   8=;
Authentication-Results: mail3-relais-sop.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=Julia.Lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.91,242,1647298800"; 
   d="scan'208";a="14727932"
Received: from i80.paris.inria.fr (HELO i80.paris.inria.fr.) ([128.93.90.48])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2022 13:11:58 +0200
From:   Julia Lawall <Julia.Lawall@inria.fr>
To:     Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     kernel-janitors@vger.kernel.org,
        Yangtao Li <tiny.windzz@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: [PATCH] thermal: sun8i: fix typo in comment
Date:   Sat, 21 May 2022 13:10:46 +0200
Message-Id: <20220521111145.81697-36-Julia.Lawall@inria.fr>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Spelling mistake (triple letters) in comment.
Detected with the help of Coccinelle.

Signed-off-by: Julia Lawall <Julia.Lawall@inria.fr>

---
 drivers/thermal/sun8i_thermal.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/sun8i_thermal.c b/drivers/thermal/sun8i_thermal.c
index d9cd23cbb671..212c87e63a66 100644
--- a/drivers/thermal/sun8i_thermal.c
+++ b/drivers/thermal/sun8i_thermal.c
@@ -237,7 +237,7 @@ static int sun50i_h6_ths_calibrate(struct ths_device *tmdev,
 	 * The calibration data on the H6 is the ambient temperature and
 	 * sensor values that are filled during the factory test stage.
 	 *
-	 * The unit of stored FT temperature is 0.1 degreee celusis.
+	 * The unit of stored FT temperature is 0.1 degree celsius.
 	 *
 	 * We need to calculate a delta between measured and caluclated
 	 * register values and this will become a calibration offset.

