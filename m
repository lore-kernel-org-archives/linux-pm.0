Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C6CFC43381
	for <linux-pm@archiver.kernel.org>; Wed, 10 Feb 2021 17:22:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D32D264DE3
	for <linux-pm@archiver.kernel.org>; Wed, 10 Feb 2021 17:22:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhBJRV4 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 10 Feb 2021 12:21:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:43580 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231695AbhBJRVy (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 10 Feb 2021 12:21:54 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5F2E064EAA;
        Wed, 10 Feb 2021 17:21:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1612977675;
        bh=6gU2hr0ySWdL4EzqNvCcJ94uNlFU8d5EdszufVd6c+M=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=afHBZThxamSYcna41fA4y/Ug6lI480lRsUQyNIiSrnwf77jvPxidSjmgh1aEF3zao
         Qbzb41Iga3anrTiXfpsvqPhthjB15GDvBU0SAidDD0a2P6t2uvUEtNHj6XRj9WHlId
         N+wYl+BZgsPw9k4f2uuleM7Oao5igNYkkVGCYLfFjnqgUPa+PR+fGs4ySFtvol+392
         4NGeks3IAljVqjOHF+Nj6AiRoV4OI4mSM51FsOBzp63W9xdyHhryx9NnjYuY+DL4b9
         lT0Y1QNctV0JkEQXME/MQ+3URxCiadllDQycSna0udvhYRCACuRAll5I4mWHXCnKRp
         XV778QfAsC2ZQ==
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Krzysztof Kozlowski <krzk@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 2/3] power: supply: s3c_adc_battery: add SPDX license identifier
Date:   Wed, 10 Feb 2021 18:21:07 +0100
Message-Id: <20210210172108.334896-2-krzk@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210210172108.334896-1-krzk@kernel.org>
References: <20210210172108.334896-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Add SPDX license identifier and replace license boilerplate.

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/supply/s3c_adc_battery.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/drivers/power/supply/s3c_adc_battery.c b/drivers/power/supply/s3c_adc_battery.c
index a2addc24ee8b..de98aea53a24 100644
--- a/drivers/power/supply/s3c_adc_battery.c
+++ b/drivers/power/supply/s3c_adc_battery.c
@@ -1,13 +1,8 @@
-/*
- *	iPAQ h1930/h1940/rx1950 battery controller driver
- *	Copyright (c) Vasily Khoruzhick
- *	Based on h1940_battery.c by Arnaud Patard
- *
- * This file is subject to the terms and conditions of the GNU General Public
- * License.  See the file COPYING in the main directory of this archive for
- * more details.
- *
- */
+// SPDX-License-Identifier: GPL-2.0
+//
+// iPAQ h1930/h1940/rx1950 battery controller driver
+// Copyright (c) Vasily Khoruzhick
+// Based on h1940_battery.c by Arnaud Patard
 
 #include <linux/interrupt.h>
 #include <linux/platform_device.h>
-- 
2.25.1

