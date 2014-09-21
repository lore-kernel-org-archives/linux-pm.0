From: Heiko Stuebner <heiko@sntech.de>
Subject: [PATCH v2 0/3] gpio-charger: add devicetree support
Date: Sun, 21 Sep 2014 22:05:20 +0200
Message-ID: <1411329923-15912-1-git-send-email-heiko@sntech.de>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gloria.sntech.de ([95.129.55.99]:37226 "EHLO gloria.sntech.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751603AbaIUUGS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Sun, 21 Sep 2014 16:06:18 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com, pawel.moll@arm.com, ijc+devicetree@hellion.org.uk, galak@codeaurora.org, dianders@chromium.org, heiko@sntech.de

This series adds devicetree support to the gpio-charger and fixes a small
issue with the return value of gpio_get_value.

changes since v1:
- adapt binding example to show how the charger fits into the
  power-supplies structure

Heiko Stuebner (3):
  dt-bindings: document gpio-charger bindings
  power: gpio-charger: add device tree support
  power: gpio-charger: do not use gpio value directly

 .../bindings/power_supply/gpio-charger.txt         | 27 +++++++++
 drivers/power/gpio-charger.c                       | 68 ++++++++++++++++++++--
 2 files changed, 91 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/power_supply/gpio-charger.txt

-- 
1.9.0

