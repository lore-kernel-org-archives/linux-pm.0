Return-Path: <SRS0=HULK=SS=vger.kernel.org=linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B15FC10F13
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 06:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F1EC92073F
	for <linux-pm@archiver.kernel.org>; Tue, 16 Apr 2019 06:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555396833;
	bh=lOzywWALribrXhpc6VCkS+xzIjb4WGjuVTb9YCTs1MQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=KmJMxQeH1v21sUUEi1mmTL5v0ktsLGUAs4qL/KCRyphwgf6dgeGdxwjQefJ6G95kE
	 eJL7XYJFGfYrqnFq9q8iMVd2XSAMXfdRyGnNLfYU/Xhz3qalpkSereyHnaLNQuFQVj
	 srYIc4kAXR7JCc7m6j8E3MeqNxeHyhuLCveDS81Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728494AbfDPGkb (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 16 Apr 2019 02:40:31 -0400
Received: from mirror2.csie.ntu.edu.tw ([140.112.30.76]:34018 "EHLO
        wens.csie.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728391AbfDPGkb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 16 Apr 2019 02:40:31 -0400
Received: by wens.csie.org (Postfix, from userid 1000)
        id AA79B602D3; Tue, 16 Apr 2019 14:40:25 +0800 (CST)
From:   Chen-Yu Tsai <wens@kernel.org>
To:     Maxime Ripard <maxime.ripard@bootlin.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Quentin Schulz <quentin.schulz@bootlin.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com, Hans de Goede <hdegoede@redhat.com>,
        Chen-Yu Tsai <wens@csie.org>
Subject: [PATCH v4 6/7] ARM: dtsi: axp81x: add USB power supply node
Date:   Tue, 16 Apr 2019 14:40:23 +0800
Message-Id: <20190416064024.20414-7-wens@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190416064024.20414-1-wens@kernel.org>
References: <20190416064024.20414-1-wens@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pm-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190416064023.AsGQvuuDXaFTjwzjXoJ981Y2Et3OczSVIrQKIpQ9u5s@z>

From: Quentin Schulz <quentin.schulz@bootlin.com>

The AXP813/818 has a VBUS power input. Add a device node for it, now
that we support it.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
[wens@csie.org: Add commit message]
Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/axp81x.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
index bd83962d3627..1dfeeceabf4c 100644
--- a/arch/arm/boot/dts/axp81x.dtsi
+++ b/arch/arm/boot/dts/axp81x.dtsi
@@ -171,4 +171,8 @@
 			status = "disabled";
 		};
 	};
+
+	usb_power_supply: usb-power-supply {
+		compatible = "x-powers,axp813-usb-power-supply";
+	};
 };
-- 
2.20.1

