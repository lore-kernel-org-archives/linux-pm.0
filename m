From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH 0/4] power: sbs-manager fixup gpio detect irq handling
Date: Fri, 22 Jul 2016 16:42:34 +0800
Message-ID: <1469176958-69804-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 203-59-230-133.perm.iinet.net.au ([203.59.230.133]:38130 "EHLO
	preid-centos7.electromag.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751822AbcGVIwR (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jul 2016 04:52:17 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org
Cc: Phil Reid <preid@electromag.com.au>

This series switches the driver to using the devm series of calls for
resource allocation. 
Also the gpio detect and irq handling had a number of issue:
- gpio detection can now be used with gpios that don't support irqs.
- Fixup irq call back data, previously null pointer was used.

I've attempted to maintain the drivers platform_data interface. There doesn't
look to be a user of this and given the errors in there I doubt it's being used
by anyone. Code would be a bit cleaner if this could go and just rely on the
device tree. Comments?


Phil Reid (4):
  power: sbs-battery: Use devm_kzalloc to alloc data
  power: sbs-battery: Request threaded irq and fix dev callback cookie
  power: sbs-battery: Use devm_power_supply_register
  power: sbs-battery: Use gpio_desc and sleeping calls for battery
    detect

 drivers/power/sbs-battery.c | 143 +++++++++++++++++++-------------------------
 1 file changed, 63 insertions(+), 80 deletions(-)

-- 
1.8.3.1

