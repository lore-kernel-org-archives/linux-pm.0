Return-Path: <SRS0=7Ybf=ZM=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B59EC432C0
	for <linux-pm@archiver.kernel.org>; Wed, 20 Nov 2019 13:40:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43132224FC
	for <linux-pm@archiver.kernel.org>; Wed, 20 Nov 2019 13:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1574257210;
	bh=gODEx76Ed9QTo8+mw4gtehtNr8EfEtmE6YTKtUT0X18=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=1pEXfsiuhJ+5jF6Afa0jwWH5P7bCiLwu4QPjOSBEIO+l9Pe/9cN/cGOsavtf7RiJ/
	 hlMl3cYk6YVmAekm3DirX9IXafw4uhI9lkCHOOAgQUO1dml/c9F2nlgIIHY4YdTNLF
	 TeZjD69OCPFZEJfAcui6af1HrmE4QhZ1HwiXibOQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbfKTNkJ (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Wed, 20 Nov 2019 08:40:09 -0500
Received: from mail.kernel.org ([198.145.29.99]:47950 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728799AbfKTNkJ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Wed, 20 Nov 2019 08:40:09 -0500
Received: from localhost.localdomain (unknown [118.189.143.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6BF4D224FC;
        Wed, 20 Nov 2019 13:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1574257208;
        bh=gODEx76Ed9QTo8+mw4gtehtNr8EfEtmE6YTKtUT0X18=;
        h=From:To:Cc:Subject:Date:From;
        b=BiSAuPEHtpYe9RlnjTcpEXx1d18tdkLXXFBi335K4NJSDk77oBhPXdeVeSTycFkAA
         yRX1Zj4cgb4KtlV0L7LqhyUjRb9aTruVVNuvHSXCawvH0MKM3uica51d4vFm8Adwm9
         0M0O/IKDPX3AmfE0x9sHpWC29gsJltvlzTqyoUNk=
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzk@kernel.org>,
        Kevin Hilman <khilman@kernel.org>, Nishanth Menon <nm@ti.com>,
        linux-pm@vger.kernel.org
Subject: [PATCH] power: avs: Fix Kconfig indentation
Date:   Wed, 20 Nov 2019 21:40:04 +0800
Message-Id: <20191120134004.14167-1-krzk@kernel.org>
X-Mailer: git-send-email 2.17.1
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Adjust indentation from spaces to tab (+optional two spaces) as in
coding style with command like:
	$ sed -e 's/^        /\t/' -i */Kconfig

Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
---
 drivers/power/avs/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/power/avs/Kconfig b/drivers/power/avs/Kconfig
index b5a217b828dc..089b6244b716 100644
--- a/drivers/power/avs/Kconfig
+++ b/drivers/power/avs/Kconfig
@@ -13,9 +13,9 @@ menuconfig POWER_AVS
 	  Say Y here to enable Adaptive Voltage Scaling class support.
 
 config ROCKCHIP_IODOMAIN
-        tristate "Rockchip IO domain support"
-        depends on POWER_AVS && ARCH_ROCKCHIP && OF
-        help
-          Say y here to enable support io domains on Rockchip SoCs. It is
-          necessary for the io domain setting of the SoC to match the
-          voltage supplied by the regulators.
+	tristate "Rockchip IO domain support"
+	depends on POWER_AVS && ARCH_ROCKCHIP && OF
+	help
+	  Say y here to enable support io domains on Rockchip SoCs. It is
+	  necessary for the io domain setting of the SoC to match the
+	  voltage supplied by the regulators.
-- 
2.17.1

