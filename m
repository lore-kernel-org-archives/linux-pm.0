From: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 0/3] PM / sleep: let slow buses inherit child ignorance
Date: Thu,  7 Apr 2016 15:20:34 +0200
Message-ID: <1460035237-12037-1-git-send-email-linus.walleij@linaro.org>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f179.google.com ([209.85.217.179]:36275 "EHLO
	mail-lb0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751589AbcDGNUx (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 7 Apr 2016 09:20:53 -0400
Received: by mail-lb0-f179.google.com with SMTP id bk9so22560594lbc.3
        for <linux-pm@vger.kernel.org>; Thu, 07 Apr 2016 06:20:53 -0700 (PDT)
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Wolfram Sang <wsa@the-dreams.de>, Mark Brown <broonie@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>

I ran into a problem when using runtime_force_suspend()/resume()
on a target I2C device.

After some root causing I realized this is because slow buses create
struct device-containing masters from hardware devices, that do not
inherit the child ignorance setting, while they should.

Children on a slow message-oriented bus like I2C or SPI do not need
their I2C/SPI (etc) host to be up and running all the time in order
to go into a resumed state.

It is more customary for such busses to go online at the instant
that a driver or child signals that it want to transfer a message
on the bus.

Some drivers (such as drivers/i2c/busses/i2c-nomadik.c) have the
.ignore_children flag set properly in their main device and have
runtime PM running, but run into weird phenomena when their
children want to resume from sleep.

The most details are in the I2C patch [2/3].

The third patch is here to illustrate that the problem is present
in all slow external busses.

Linus Walleij (3):
  PM / sleep: add a helper function to inherit child ignorance
  i2c: let I2C masters inherit suspend child ignorance
  RFC: spi: let SPI masters inherit suspend child ignorance

 drivers/i2c/i2c-core.c | 1 +
 drivers/spi/spi.c      | 1 +
 include/linux/device.h | 7 +++++++
 3 files changed, 9 insertions(+)

-- 
2.4.3

