Return-Path: <linux-pm-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C96C4332F
	for <linux-pm@archiver.kernel.org>; Tue,  5 Apr 2022 12:57:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241989AbiDEMze (ORCPT <rfc822;linux-pm@archiver.kernel.org>);
        Tue, 5 Apr 2022 08:55:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382353AbiDEMO5 (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 5 Apr 2022 08:14:57 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69A5DA66F2;
        Tue,  5 Apr 2022 04:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649157925; x=1680693925;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7o0sgXENCg/Y0DQNqjlqJ8tcLEzSZooqtxoe6odT57w=;
  b=OlowTSPa/+lLozdO8uYyB/+3AFwapNAMGM8gfIHj9NPI5jOftu0LEdgW
   ONRtAvSK552/0xS8q+6sSTQNQUO78Z5N4Y+fLo35P9QWW+SC/aZ0q09/7
   A82hZp6BDsmkkXuJ7/eqxXQbZAfteRqhxokaytYrBXNhgDdvD70r1HzL4
   U/gDt2sPdb/CplHhvQAfQnfiSB7WlgWDhLZHuhH/7JEzzYAqw5zAVbemE
   F0ff5WxoX9hO/OwvfOsQh/z/wUN8Uei2U0+GZ/lNIpgUpoOBo8Dwb1qgK
   vaFmIPsexTDa4ePSePRLzIHHLSJWQn14kR2gMxhYZh1YstTmQMnagUo36
   A==;
X-IronPort-AV: E=Sophos;i="5.90,236,1643698800"; 
   d="scan'208";a="159346885"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Apr 2022 04:25:22 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Tue, 5 Apr 2022 04:25:22 -0700
Received: from localhost.localdomain (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Tue, 5 Apr 2022 04:25:20 -0700
From:   Claudiu Beznea <claudiu.beznea@microchip.com>
To:     <robh+dt@kernel.org>, <nicolas.ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <p.zabel@pengutronix.de>,
        <sre@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pm@vger.kernel.org>,
        Claudiu Beznea <claudiu.beznea@microchip.com>
Subject: [PATCH 0/8] power: reset: at91-reset: add support for sama7g5
Date:   Tue, 5 Apr 2022 14:27:16 +0300
Message-ID: <20220405112724.2760905-1-claudiu.beznea@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-pm.vger.kernel.org>
X-Mailing-List: linux-pm@vger.kernel.org

Hi,

The series adds reset controller support for SAMA7G5 SoCs. Compared with
previous version the reset controller embedded on SAMA7G5 is able to
reset individual on SoC devices (e.g. USB PHY controllers).

Among with this I took the change and converted reset controller
bindings to YAML (patch 2/8) and adapt reset controller nodes in
device tree files to comply with DT specifications (patch 1/8).

Thank you,
Claudiu Beznea

Claudiu Beznea (8):
  ARM: dts: at91: use generic name for reset controller
  dt-bindings: reset: convert Atmel/Microchip reset controller to YAML
  dt-bindings: reset: atmel,at91sam9260-reset: add sama7g5 bindings
  dt-bindings: reset: add sama7g5 definitions
  power: reset: at91-reset: add at91_reset_data
  power: reset: at91-reset: add reset_controller_dev support
  power: reset: at91-reset: add support for SAMA7G5
  ARM: dts: at91: sama7g5: add reset-controller node

 .../devicetree/bindings/arm/atmel-sysregs.txt |  15 --
 .../reset/atmel,at91sam9260-reset.yaml        |  68 +++++++++
 arch/arm/boot/dts/at91sam9260.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9261.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9263.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi            |   2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi             |   2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi             |   2 +-
 arch/arm/boot/dts/sam9x60.dtsi                |   2 +-
 arch/arm/boot/dts/sama5d2.dtsi                |   2 +-
 arch/arm/boot/dts/sama5d3.dtsi                |   2 +-
 arch/arm/boot/dts/sama5d4.dtsi                |   2 +-
 arch/arm/boot/dts/sama7g5.dtsi                |   7 +
 drivers/power/reset/at91-reset.c              | 134 ++++++++++++++++--
 include/dt-bindings/reset/sama7g5-reset.h     |  10 ++
 16 files changed, 217 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/reset/atmel,at91sam9260-reset.yaml
 create mode 100644 include/dt-bindings/reset/sama7g5-reset.h

-- 
2.32.0

