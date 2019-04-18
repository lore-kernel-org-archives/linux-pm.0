Return-Path: <SRS0=JVBr=SU=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BC79C10F0E
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 16:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1BDCF20643
	for <linux-pm@archiver.kernel.org>; Thu, 18 Apr 2019 16:37:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gn2XTdb0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388299AbfDRQhj (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 18 Apr 2019 12:37:39 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:36477 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733067AbfDRQhj (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2019 12:37:39 -0400
Received: by mail-qt1-f196.google.com with SMTP id s15so2863098qtn.3
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2019 09:37:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=tHbYk6MxaillgOP+/nGA7bQ7Ha1/NadZMer7j1cGAHQ=;
        b=gn2XTdb0f3fWM/1VnLYnesohfx1oOByRDmewVdfyylWpdChOEH+AJvkP2tXTXB28Ic
         bUoWPpDEdi+lEETPvp1bVdKel7/4bXSN5s95mQEfTt7pZqY6iUHbmoKAnGyIKgew/vj6
         zdmdoBhUTFT0Hrvfjj0Yo1B6nmN0vTFA0V/k9c32GshwZQJaLBTlMcKSIjjvZo9uUqd4
         CxbIk4zTEkVJtYS931QYMjhFwfzKPuTcnoXGKxQk3mKHx9N8qoEvvqZSqaOC1rKC5wHP
         29cF0liH7v+nW0y4EqI73AtRw7WJlZTkVkEoB323iFzvE5j0V0a1iI3O9JFkDdzlvxz4
         UX6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=tHbYk6MxaillgOP+/nGA7bQ7Ha1/NadZMer7j1cGAHQ=;
        b=szPJE0K1rclV7kT04geqlbg26BekJ3/JXjbC/TqnhywgN/UWvPJrMf5sdNnLuvp8He
         TBzCSkHMt3XZqsYCC2u3HvVA/NwUn0n9yrAIAINR4F4YwFaZs3WSZd2+T+YC7qNH6ONb
         npzjpN3YtLfUwShnR6hNBRdJ7kz/q7mElBy+vBMHInepAp/knsrRbmsv5u6Suw4ta55Q
         j5ic2wMyTpU/II88fzku0Xp9GrCWXL7JlNWu2OpT2rib42jBQtK7XgmuN9CeHLGMBtFz
         0y0Z5MpiR7ZlgWgPnJAp3DWFAcCsCnACKhjSZGkQagIZkqvhT2j8GC3xBcF3UQcPnK3N
         uChw==
X-Gm-Message-State: APjAAAVlxWRlgMt+IgwOZAxOHlvrlrDbiNBMPu6z7BK5Mcz0YK7UnVom
        v3jPccgSIUjmmyI64SKbUK8SkyNxmaSvLw==
X-Google-Smtp-Source: APXvYqwIG+s8ky3gEYJPBDf3Mzac2XsInoWYNrtvBmQ2lu+x1WSa7zMK9kcjgEc9+2Qk4j9Uw2ZMpw==
X-Received: by 2002:ac8:1119:: with SMTP id c25mr75139491qtj.165.1555605458295;
        Thu, 18 Apr 2019 09:37:38 -0700 (PDT)
Received: from jfddesk.Sonatest.net (ipagstaticip-d73c7528-4de5-0861-800b-03d8b15e3869.sdsl.bell.ca. [174.94.156.236])
        by smtp.gmail.com with ESMTPSA id k41sm1622394qtc.89.2019.04.18.09.37.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Apr 2019 09:37:37 -0700 (PDT)
From:   Jean-Francois Dagenais <jeff.dagenais@gmail.com>
To:     linux-pm@vger.kernel.org
Cc:     daniel.lezcano@linaro.org, edubezval@gmail.com,
        rui.zhang@intel.com,
        Jean-Francois Dagenais <jeff.dagenais@gmail.com>
Subject: [PATCH 1/2] thermal: generic-adc: make lookup table optional
Date:   Thu, 18 Apr 2019 12:37:32 -0400
Message-Id: <20190418163733.17414-1-jeff.dagenais@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Certain ADC channels, such as the xilinx-ams temperature channels, give
milliCelcius already when read with iio_read_channel_processed.

Rather than having to provide a 1:1 dummy lookup table, simply allow to
bypass the mechanism.

Signed-off-by: Jean-Francois Dagenais <jeff.dagenais@gmail.com>
---
 drivers/thermal/thermal-generic-adc.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/thermal/thermal-generic-adc.c b/drivers/thermal/thermal-generic-adc.c
index e22fc60ad36d..deb244f12de4 100644
--- a/drivers/thermal/thermal-generic-adc.c
+++ b/drivers/thermal/thermal-generic-adc.c
@@ -29,6 +29,9 @@ static int gadc_thermal_adc_to_temp(struct gadc_thermal_info *gti, int val)
 	int temp, temp_hi, temp_lo, adc_hi, adc_lo;
 	int i;
 
+	if (!gti->lookup_table)
+		return val;
+
 	for (i = 0; i < gti->nlookup_table; i++) {
 		if (val >= gti->lookup_table[2 * i + 1])
 			break;
@@ -81,9 +84,9 @@ static int gadc_thermal_read_linear_lookup_table(struct device *dev,
 
 	ntable = of_property_count_elems_of_size(np, "temperature-lookup-table",
 						 sizeof(u32));
-	if (ntable < 0) {
-		dev_err(dev, "Lookup table is not provided\n");
-		return ntable;
+	if (ntable <= 0) {
+		dev_notice(dev, "no lookup table, assuming DAC channel returns milliCelcius\n");
+		return 0;
 	}
 
 	if (ntable % 2) {
-- 
2.11.0

