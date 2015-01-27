From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: [RFT PATCH 0/4] Check return value of power_supply_register
Date: Tue, 27 Jan 2015 12:30:17 +0100
Message-ID: <1422358221-13199-1-git-send-email-k.kozlowski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:36557 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752317AbbA0Laj (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 27 Jan 2015 06:30:39 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Dmitry Artamonow <mad_soft@inbox.ru>, Marek Belisko <marek@goldelico.com>, Cezary Jackiewicz <cezary.jackiewicz@gmail.com>, Darren Hart <dvhart@infradead.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: Krzysztof Kozlowski <k.kozlowski@samsung.com>

Hi,


During global rework of power supply register API I found possible
issues related to not checked return value.

The power_supply_register() return value was ignored and during driver
removal the power supply was always unregistered. This theoretically
could lead to invalid memory accesses. However I did not reproduce
the issue (only code analysis).

Affected drivers:
1. twl4030_madc
2. compal-laptop
3. ipaq_micro_battery

I prepared patches but DID NOT test them. Only compilation + sparse
 + smatch + coccicheck.

I am kindly asking for review and testing.


P.S. The acpi/sbs.c driver has the same issue. Before unregistering
power supply it checks if sbs->charger.dev is non-NULL... which will
be non-NULL in most error-paths. However the driver is little more
complicated so fixing this without doing tests would be very
error-prone.


Best regards,
Krzysztof


Krzysztof Kozlowski (4):
  power_supply: twl4030_madc: Check return value of
    power_supply_register
  compal-laptop: Check return value of power_supply_register
  power_supply: ipaq_micro_battery: Fix leaking workqueue
  power_supply: ipaq_micro_battery: Check return values in probe

 drivers/platform/x86/compal-laptop.c |  7 ++++++-
 drivers/power/ipaq_micro_battery.c   | 22 ++++++++++++++++++++--
 drivers/power/twl4030_madc_battery.c |  7 +++++--
 3 files changed, 31 insertions(+), 5 deletions(-)

-- 
1.9.1

