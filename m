From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [PATCH 0/2] power_supply: Small improvements for 4.2
Date: Tue, 19 May 2015 16:16:28 +0900
Message-ID: <1432019790-5664-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.w1.samsung.com ([210.118.77.11]:14193 "EHLO
	mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752955AbbESHQo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 May 2015 03:16:44 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Hi,

I send these separately because they are not fixes for current
RC cycle.

The patch 1 could look like fix... but still this is for theoretical
race condition.

Best regards,
Krzysztof

Krzysztof Kozlowski (2):
  power_supply: Use wrappers to avoid races when registering power
    supply
  power_supply: charger-manager: Add parent for power supply

 drivers/power/charger-manager.c    | 3 ++-
 drivers/power/power_supply_leds.c  | 4 ++--
 drivers/power/power_supply_sysfs.c | 2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

-- 
1.9.1

