From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH 0/3] mfd: cros_ec: add support for USBPD charger driver.
Date: Wed, 17 Jan 2018 18:59:29 +0100
Message-ID: <20180117175932.20636-1-enric.balletbo@collabora.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:39962 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753669AbeAQR7m (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 17 Jan 2018 12:59:42 -0500
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>, Sebastian Reichel <sre@kernel.org>
Cc: Gwendal Grignou <gwendal@chromium.org>, Benson Leung <bleung@chromium.org>, Guenter Roeck <groeck@chromium.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

Dear all,

These patches introduces the ChromeOS EC USBPD charger driver, the
driver has been used on Chromebooks kernels and ported to mainline. The
patches were tested succesfully with a Samsung Chromebook Plus device
but depends on the for-next Benson Leung branch [1] to apply cleanly.
This branch is supposed to be merged in next merge window.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/bleung/chrome-platform.git/log/?h=for-next

Best regards,
 Enric

Sameer Nanda (3):
  mfd: cros_ec: Add USBPD charger commands and struct definitions.
  power: supply: add cros-ec USB PD charger driver.
  mfd: cros_ec_dev: Register cros_usbpd-charger driver as a subdevice.

 drivers/mfd/cros_ec_dev.c                 |  25 +
 drivers/power/supply/Kconfig              |  11 +
 drivers/power/supply/Makefile             |   1 +
 drivers/power/supply/cros_usbpd-charger.c | 953 ++++++++++++++++++++++++++++++
 include/linux/mfd/cros_ec.h               |   3 +
 include/linux/mfd/cros_ec_commands.h      | 135 ++++-
 6 files changed, 1124 insertions(+), 4 deletions(-)
 create mode 100644 drivers/power/supply/cros_usbpd-charger.c

-- 
2.15.1
