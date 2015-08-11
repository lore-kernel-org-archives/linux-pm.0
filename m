From: Lukasz Majewski <l.majewski@samsung.com>
Subject: [PATCH RESEND v6 0/3] dts: thermal: Odroid U3: Provide support for
 Odroid U3 fan
Date: Tue, 11 Aug 2015 15:07:17 +0200
Message-ID: <1439298440-15882-1-git-send-email-l.majewski@samsung.com>
References: <1425470624-25793-1-git-send-email-l.majewski@samsung.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:35754 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964968AbbHKNHd (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 11 Aug 2015 09:07:33 -0400
In-reply-to: <1425470624-25793-1-git-send-email-l.majewski@samsung.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>
Cc: Linux PM list <linux-pm@vger.kernel.org>, "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>, devicetree@vger.kernel.org, Lukasz Majewski <l.majewski@majess.pl>, Lukasz Majewski <l.majewski@samsung.com>

Presented patches add support for Odroid's U3 optional CPU FAN, which uses PWM
subsystem for low level control.

This patch is a resend of previously send series:
https://lkml.org/lkml/2015/3/4/726

The "hwmon" part of this series has been already added to upstream.
Unfortunately, the DTS files for Odroid U3 device have NOT been added to 
mainline repository.

Those patches were tested at Exynos4412 - Odroid U3 board.

Patches were applied on:
kernel_samsung -> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git

kernel_samsung/for-next (Linux v4.2-rc1)
SHA1: 366c21fdd7b1e71a47a6fa969f2e9a014c981aff

Kamil Debski (1):
  ARM: dts: Add pwm-fan node to the Odroid-U3 board

Lukasz Majewski (2):
  Documentation: dts: Documentation entry to explain how to use PWM FAN
    as a cooling device
  ARM: dts: Add properties to use pwm-fan device as a cooling device in
    Odroid U3

 .../devicetree/bindings/hwmon/pwm-fan.txt          | 29 ++++++++++++++-
 arch/arm/boot/dts/exynos4412-odroidu3.dts          | 43 ++++++++++++++++++++++
 2 files changed, 70 insertions(+), 2 deletions(-)

-- 
2.0.0.rc2

