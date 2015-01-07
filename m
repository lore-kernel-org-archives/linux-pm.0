From: Todd E Brandt <todd.e.brandt@linux.intel.com>
Subject: [PATCH 0/3] X-Power AXP288 PMIC Fuel Gauge Driver
Date: Wed, 7 Jan 2015 13:23:28 -0800
Message-ID: <20150107212328.GA3440@linux.intel.com>
Reply-To: todd.e.brandt@linux.intel.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:44330 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754139AbbAGVX3 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 7 Jan 2015 16:23:29 -0500
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: jacob.jun.pan@linux.intel.com, sameo@linux.intel.com, lee.jones@linaro.org, sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, david.woodhouse@intel.com

X-Power AXP288 PMIC Fuel Gauge Driver

 new power_supply driver at driver/power
 interfaces with the axp20x mfd driver as a cell
 provides battery info and monitors for changes
 generates alerts on temperature and capacity issues

(1/3) mfd/axp20x.c: change the battery cell name to fuel_gauge
(2/3) mfd/axp20x.h: add the register defs and platform struct for fuel gauge
(3/3) power/axp288_fuel_gauge.c: axp288 fuel gauge driver

Signed-off-by: Todd Brandt <todd.e.brandt@intel.com>
----
 drivers/mfd/axp20x.c              |   10 +-
 drivers/power/Kconfig             |    9 +
 drivers/power/Makefile            |    1 +
 drivers/power/axp288_fuel_gauge.c | 1108 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/mfd/axp20x.h        |   43 ++-
 5 files changed, 1164 insertions(+), 7 deletions(-)
