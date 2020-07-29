Return-Path: <SRS0=Xm5K=BI=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16F13C433E0
	for <linux-pm@archiver.kernel.org>; Wed, 29 Jul 2020 07:44:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0BEF2084D
	for <linux-pm@archiver.kernel.org>; Wed, 29 Jul 2020 07:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1596008639;
	bh=jKObMlOsG6jrgJGRXhXHhyX78D9kV4sDJzchO9Ukh8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=OqApd/us5Cl7+TzBZV0tsrlIDP1SdPupYkwLp/aFCxgycESUr9eqBDkJP9K3z7mbJ
	 yXczzEl2JEJATZYVWJJLN33AqKjjnGziIA1JH6tcsl0EAjJxtHVaeJ79rHgc0HfJ1R
	 lxzBe25XxySRaR+9bb7eZub+NpogQJYw14AY1+rY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727907AbgG2Hn4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 29 Jul 2020 03:43:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:57600 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726290AbgG2Hnz (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 29 Jul 2020 03:43:55 -0400
Received: from kozik-lap.mshome.net (unknown [194.230.155.213])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6FFF520838;
        Wed, 29 Jul 2020 07:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1596008635;
        bh=jKObMlOsG6jrgJGRXhXHhyX78D9kV4sDJzchO9Ukh8w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Xy7Y7WnOW2uWpC9ZlaYCwKIFV/kIyz5X6GIB7yVy1f7aXi7bm9K8CIIc8paJhdtqZ
         izh/S+M1WrPzoMOwEyd0Tn/z0rKKezVWpYLTa0D8lmr2I/NfS+mcb/7UxTBHKhWu2n
         UO0rtqzjp/j27buJIZO2wkWSPTzgAMvqYn6qFy2s=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>
Subject: [PATCH 2/2] power: supply: Fix kerneldoc of power_supply_temp2resist_simple()
Date:   Wed, 29 Jul 2020 09:43:48 +0200
Message-Id: <20200729074348.28317-2-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200729074348.28317-1-krzk@kernel.org>
References: <20200729074348.28317-1-krzk@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Fix W=1 compile warnings (invalid kerneldoc):

    drivers/power/supply/power_supply_core.c:747: warning: Function parameter or member 'temp' not described in 'power_supply_temp2resist_simple'
    drivers/power/supply/power_supply_core.c:747: warning: Excess function parameter 'ocv' description in 'power_supply_temp2resist_simple'

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/power_supply_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index 90e56736d479..ccbad435ed12 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -733,7 +733,7 @@ EXPORT_SYMBOL_GPL(power_supply_put_battery_info);
  * percent
  * @table: Pointer to battery resistance temperature table
  * @table_len: The table length
- * @ocv: Current temperature
+ * @temp: Current temperature
  *
  * This helper function is used to look up battery internal resistance percent
  * according to current temperature value from the resistance temperature table,
-- 
2.17.1

