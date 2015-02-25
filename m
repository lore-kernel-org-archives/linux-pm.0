From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH v5 0/6] hwmon: thermal: Odroid U3: Provide support for Odroid
 U3 fan
Date: Wed, 25 Feb 2015 16:34:16 +0100
Message-ID: <1424878462-15511-1-git-send-email-l.majewski@samsung.com>
References: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:64530 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753341AbbBYPeh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Feb 2015 10:34:37 -0500
In-reply-to: <1418897591-18332-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Kamil Debski <k.debski@samsung.com>, Jean Delvare <jdelvare@suse.de>, Guenter Roeck <linux@roeck-us.net>, Kukjin Kim <kgene@kernel.org>
Cc: lm-sensors@lm-sensors.org, Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Kukjin Kim <kgene.kim@samsung.com>, linux-kernel@vger.kernel.org, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Abhilash Kesavan <kesavan.abhilash@gmail.com>, Abhilash Kesavan <a.kesavan@samsung.com>, Lukasz Majewski <l.majewski@samsung.com>

Presented patches add support for Odroid's U3 optional CPU FAN, which uses PWM
subsystem for low level control.

After successful probe it registers itself as a cooling device for thermal
subsystem.

This driver also supports devices without DTS specified.

To provide correct functionality, new properties to device tree description for
Exynos4412 and in particular Odroid U3 have been added.

Those patches were tested at Exynos4412 - Odroid U3 board.

Patches were applied on:
linux-soc-thermal/fixes branch (Linux v4.0-rc1)
SHA1: b71d399c7f2fe06b60b96155ec0b9ae167334e4a

Kamil Debski (1):
  ARM: dts: Add pwm-fan node to the Odroid-U3 board

Lukasz Majewski (5):
  Documentation: dts: Documentation entry to explain how to use PWM FAN
    as a cooling device
  ARM: dts: Add properties to use pwm-fan device as a cooling device in
    Odroid U3
  hwmon: pwm-fan: Extract __set_pwm() function to only modify PWM duty
    cycle
  hwmon: pwm-fan: Read PWM FAN configuration from device tree
  hwmon: pwm-fan: Code for using PWM FAN as a cooling device

 .../devicetree/bindings/hwmon/pwm-fan.txt          |  25 +++-
 arch/arm/boot/dts/exynos4.dtsi                     |   2 +-
 arch/arm/boot/dts/exynos4412-odroidu3.dts          |  43 ++++++
 drivers/hwmon/pwm-fan.c                            | 166 +++++++++++++++++++--
 4 files changed, 220 insertions(+), 16 deletions(-)

-- 
2.0.0.rc2

