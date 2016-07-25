From: Phil Reid <preid@electromag.com.au>
Subject: [PATCH v2 0/4] power: sbs-battery fixup gpio detect irq handling
Date: Mon, 25 Jul 2016 10:42:56 +0800
Message-ID: <1469414580-14121-1-git-send-email-preid@electromag.com.au>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from 203-59-230-133.perm.iinet.net.au ([203.59.230.133]:48260 "EHLO
	preid-centos7.electromag.com.au" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752628AbcGYCnJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 24 Jul 2016 22:43:09 -0400
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

Changes from V1:
- Fix sbs_of_populate_pdata params for non OF builds.
- Fix title of summary message.

Phil Reid (4):
  power: sbs-battery: Use devm_kzalloc to alloc data
  power: sbs-battery: Request threaded irq and fix dev callback cookie
  power: sbs-battery: Use devm_power_supply_register
  power: sbs-battery: Use gpio_desc and sleeping calls for battery
    detect

 drivers/power/sbs-battery.c | 147 ++++++++++++++++++++------------------------
 1 file changed, 65 insertions(+), 82 deletions(-)

-- 
1.8.3.1

