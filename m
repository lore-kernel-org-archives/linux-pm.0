From: Fabien Parent <fparent@baylibre.com>
Subject: [PATCH 0/3] power: supply: cros: add support for dedicated port and expose connected ports
Date: Tue, 29 May 2018 20:17:01 -0700
Message-ID: <20180530031704.18597-1-fparent@baylibre.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, eballetbo@gmail.com, gpain@baylibre.com, Fabien Parent <fparent@baylibre.com>
List-Id: linux-pm@vger.kernel.org

Dear all,

This patch series adds support for an optional dedicated port
to the ChromeOS power supply driver and adds a new property that expose
when a power supply is connected. The series was tested on ChromeOS "Fizz"
hardware.

This patch series depends on the following patch serie which adds
the ChromeOS power supply driver:
 * https://lkml.org/lkml/2018/5/2/585 [PATCH v4 0/3] mfd/power: cros_ec: add
   support for USBPD charger driver

The ChromeOS power supply driver also depends on the following patches to be
applied:
 * https://lkml.org/lkml/2018/4/23/602 ([PATCH v8 0/6] typec: tcpm: Add
   sink side support for PPS)
 * https://lkml.org/lkml/2018/4/18/229 ([RESEND PATCH v5 4/7] mfd:
   cros_ec_dev: Register cros-ec-rtc driver as a subdevice.)

Best Regards,
Fabien

Fabien Parent (3):
  mfd: cros: add charger port count command definition
  power: supply: cros: add support for dedicated port
  power: supply: cros: add property to detect connected ports

 drivers/power/supply/cros_usbpd-charger.c | 129 +++++++++++++++++++---
 include/linux/mfd/cros_ec_commands.h      |  10 ++
 2 files changed, 124 insertions(+), 15 deletions(-)

-- 
2.17.0
