From: Laurentiu Palcu <laurentiu.palcu@intel.com>
Subject: [PATCH 0/2] Add support for BQ25890 charger chip
Date: Fri, 15 May 2015 17:06:16 +0300
Message-ID: <1431698778-29462-1-git-send-email-laurentiu.palcu@intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:49396 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422938AbbEOOJu (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 15 May 2015 10:09:50 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Sebastian Reichel <sre@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Laurentiu Palcu <laurentiu.palcu@intel.com>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Hi,

This series adds support for BQ25890 USB charger chip. Information about
the chip can be found here:

http://www.ti.com/product/bq25890

Thanks,
laurentiu

Laurentiu Palcu (2):
  Documentation: devicetree: Add TI BQ25890 bindings
  power_supply: Add support for TI BQ25890 charger chip

 .../devicetree/bindings/power/bq25890.txt          |  45 +
 drivers/power/Kconfig                              |   7 +
 drivers/power/Makefile                             |   1 +
 drivers/power/bq25890_charger.c                    | 998 +++++++++++++++++++++
 4 files changed, 1051 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/bq25890.txt
 create mode 100644 drivers/power/bq25890_charger.c

-- 
1.9.1

