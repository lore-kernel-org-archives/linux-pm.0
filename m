Return-Path: <SRS0=qROV=C2=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E02E7C43463
	for <linux-pm@archiver.kernel.org>; Thu, 17 Sep 2020 22:19:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E82A2087D
	for <linux-pm@archiver.kernel.org>; Thu, 17 Sep 2020 22:19:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="lw+95kv3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726291AbgIQWTw (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Thu, 17 Sep 2020 18:19:52 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:43580 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgIQWTw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Thu, 17 Sep 2020 18:19:52 -0400
X-Greylist: delayed 8453 seconds by postgrey-1.27 at vger.kernel.org; Thu, 17 Sep 2020 18:19:51 EDT
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 08HJb4ms083250;
        Thu, 17 Sep 2020 14:37:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1600371424;
        bh=PuHAdFzwcqXTe4XCKgS8dF6ODA+2CGDDLeSuQPpzMgo=;
        h=From:To:CC:Subject:Date;
        b=lw+95kv3YGHw7xeoHWhIKzYz8vSdjCJCDHHFkBfW/FnxX6caL40nBX90o7bu39pGo
         8htNZgvX4QqiLOGxhyFfcgVIq4YVBRHoS1x7yrRyd8dnMla0NEfm9ieRrK0eydkPyR
         aA0CH9ijzkhqeYcMGuzc5lfsdxEfxCtKJn5HGefA=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 08HJb2kt027086
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Sep 2020 14:37:04 -0500
Received: from DFLE106.ent.ti.com (10.64.6.27) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3; Thu, 17
 Sep 2020 14:37:03 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1979.3 via
 Frontend Transport; Thu, 17 Sep 2020 14:37:03 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 08HJb3bP098744;
        Thu, 17 Sep 2020 14:37:03 -0500
From:   Dan Murphy <dmurphy@ti.com>
To:     <sre@kernel.org>, <sumit.semwal@linaro.org>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-media@vger.kernel.org>, Dan Murphy <dmurphy@ti.com>
Subject: [PATCH] MAINTAINERS: Remove Andrew F Davis from list
Date:   Thu, 17 Sep 2020 14:37:02 -0500
Message-ID: <20200917193702.31347-1-dmurphy@ti.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Andrews TI email is no longer valid and he indicated that it is
OK to remove him from the MAINTAINERS file for the DMA HEAPS FRAMEWORK.

For the BQ27xxx list I replaced Andrews email with mine.

Signed-off-by: Dan Murphy <dmurphy@ti.com>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index d746519253c3..334352e09a74 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5213,7 +5213,6 @@ F:	kernel/dma/
 
 DMA-BUF HEAPS FRAMEWORK
 M:	Sumit Semwal <sumit.semwal@linaro.org>
-R:	Andrew F. Davis <afd@ti.com>
 R:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
 R:	Liam Mark <lmark@codeaurora.org>
 R:	Laura Abbott <labbott@redhat.com>
@@ -17268,7 +17267,7 @@ S:	Maintained
 F:	drivers/thermal/ti-soc-thermal/
 
 TI BQ27XXX POWER SUPPLY DRIVER
-R:	Andrew F. Davis <afd@ti.com>
+R:	Dan Murphy <dmurphy@ti.com>
 F:	drivers/power/supply/bq27xxx_battery.c
 F:	drivers/power/supply/bq27xxx_battery_i2c.c
 F:	include/linux/power/bq27xxx_battery.h
-- 
2.28.0

