From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 3/3] RFC: spi: let SPI masters inherit suspend child ignorance
Date: Thu,  7 Apr 2016 15:20:37 +0200
Message-ID: <1460035237-12037-4-git-send-email-linus.walleij@linaro.org>
References: <1460035237-12037-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lf0-f52.google.com ([209.85.215.52]:35888 "EHLO
	mail-lf0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbcDGNVE (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 09:21:04 -0400
Received: by mail-lf0-f52.google.com with SMTP id g184so56895669lfb.3
        for <linux-pm@vger.kernel.org>; Thu, 07 Apr 2016 06:21:04 -0700 (PDT)
In-Reply-To: <1460035237-12037-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

This patch is analogous to the I2C patch preceding it
and the reasoning is the same for all slow busses
where the master device should only wake up when
messages get transferred rather than constantly
babysitting its children.

the master devices need to inherit the child ignorance
from their hardware device (whether AMBA device or
platform device etc) so that the children on the
external bus see that they are actively ignored by their
parent and can runtime_force_resume() from system suspend
without getting an error code.

Cc: Wolfram Sang <wsa@the-dreams.de>
Cc: Mark Brown <broonie@kernel.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
Mark: mostly trying to bring home a point here and fix
it in all places if possible. No SPI master seems to be
ignoring its children for the moment but I have a patch
for the spi-pl022 doing this (ignoring its children)
I just need to find a suitable test target.
---
 drivers/spi/spi.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
index de2f2f90d799..48affabd170a 100644
--- a/drivers/spi/spi.c
+++ b/drivers/spi/spi.c
@@ -1764,6 +1764,7 @@ struct spi_master *spi_alloc_master(struct device *dev, unsigned size)
 	master->num_chipselect = 1;
 	master->dev.class = &spi_master_class;
 	master->dev.parent = dev;
+	pm_suspend_inherit_ignore_children(&master->dev);
 	spi_master_set_devdata(master, &master[1]);
 
 	return master;
-- 
2.4.3

