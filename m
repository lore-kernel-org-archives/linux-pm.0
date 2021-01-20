Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED790C433DB
	for <linux-pm@archiver.kernel.org>; Wed, 20 Jan 2021 16:25:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3460233E2
	for <linux-pm@archiver.kernel.org>; Wed, 20 Jan 2021 16:25:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403847AbhATQY6 (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 20 Jan 2021 11:24:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:44802 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403892AbhATQYt (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Jan 2021 11:24:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8665233E2;
        Wed, 20 Jan 2021 16:24:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1611159849;
        bh=6COFAQYnu6SJXLKE0L2k76zBofhuzJj5oz2aJcEQ2KA=;
        h=From:To:Cc:Subject:Date:From;
        b=ASABBDnAXoiC5F4SQ8CLdy1Yp22+ti76lenTsyj7a0bubNufBVmpUYOAFAk6kCEMD
         UWPzNBNQfIkaKmVsS4HMENOgjwNFmsJbTuVOQfaQuZg912Xs1gMuUuqU0E/7l36o3b
         hr6XiCJ5jtrSB0cnFxJV86qu2a6PlarEmh1KCler6V8bWZpqAh7Z/zOs9r3sHD8OOP
         HKvuDtB9xbEYJCeGABRgXbmEH9j12V2OgmC8T3LzLHDhnT871rtl7zVkQ24TCimVmw
         vxciQIeSWZ2dLmWiNqf5lzHDSYs9wBG49h1FuFW03r0OzulkzLZuSMiNDIE1pWmvJw
         PUacNOMrHiNSg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH 0/2] thermal: remove obsolete drivers
Date:   Wed, 20 Jan 2021 17:23:58 +0100
Message-Id: <20210120162400.4115366-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

A few Arm platforms are getting removed in v5.12, this removes
the corresponding thermal drivers.

Link: https://lore.kernel.org/linux-arm-kernel/20210120124812.2800027-1-arnd@kernel.org/T/


Arnd Bergmann (2):
  thermal: remove tango driver
  thermal: remove zx driver

 .../bindings/thermal/tango-thermal.txt        |  17 --
 .../bindings/thermal/zx2967-thermal.txt       | 116 --------
 drivers/thermal/Kconfig                       |  17 --
 drivers/thermal/Makefile                      |   2 -
 drivers/thermal/tango_thermal.c               | 126 ---------
 drivers/thermal/zx2967_thermal.c              | 256 ------------------
 6 files changed, 534 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/tango-thermal.txt
 delete mode 100644 Documentation/devicetree/bindings/thermal/zx2967-thermal.txt
 delete mode 100644 drivers/thermal/tango_thermal.c
 delete mode 100644 drivers/thermal/zx2967_thermal.c

-- 
2.29.2

