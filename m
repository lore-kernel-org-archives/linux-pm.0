From: Eric Anholt <eric@anholt.net>
Subject: [PATCH v4 1/4] ARM: bcm2835: Define two new packets from the latest firmware.
Date: Wed, 16 Dec 2015 16:26:46 -0800
Message-ID: <1450312009-1791-2-git-send-email-eric@anholt.net>
References: <1450312009-1791-1-git-send-email-eric@anholt.net>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gabe.freedesktop.org ([131.252.210.177]:41970 "EHLO
	gabe.freedesktop.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932601AbbLQA0v (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 16 Dec 2015 19:26:51 -0500
In-Reply-To: <1450312009-1791-1-git-send-email-eric@anholt.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-rpi-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Stephen Warren <swarren@wwwdotorg.org>, Lee Jones <lee@kernel.org>, Florian Fainelli <f.fainelli@gmail.com>, Kevin Hilman <khilman@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Alexander Aring <alex.aring@gmail.com>, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Eric Anholt <eric@anholt.net>

These packets give us direct access to the firmware's power management
code, as opposed to GET/SET_POWER_STATE packets that only had a couple
of domains implemented.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 include/soc/bcm2835/raspberrypi-firmware.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/soc/bcm2835/raspberrypi-firmware.h b/include/soc/bcm2835/raspberrypi-firmware.h
index c07d74a..3fb3571 100644
--- a/include/soc/bcm2835/raspberrypi-firmware.h
+++ b/include/soc/bcm2835/raspberrypi-firmware.h
@@ -72,10 +72,12 @@ enum rpi_firmware_property_tag {
 	RPI_FIRMWARE_SET_ENABLE_QPU =                         0x00030012,
 	RPI_FIRMWARE_GET_DISPMANX_RESOURCE_MEM_HANDLE =       0x00030014,
 	RPI_FIRMWARE_GET_EDID_BLOCK =                         0x00030020,
+	RPI_FIRMWARE_GET_DOMAIN_STATE =                       0x00030030,
 	RPI_FIRMWARE_SET_CLOCK_STATE =                        0x00038001,
 	RPI_FIRMWARE_SET_CLOCK_RATE =                         0x00038002,
 	RPI_FIRMWARE_SET_VOLTAGE =                            0x00038003,
 	RPI_FIRMWARE_SET_TURBO =                              0x00038009,
+	RPI_FIRMWARE_SET_DOMAIN_STATE =                       0x00038030,
 
 	/* Dispmanx TAGS */
 	RPI_FIRMWARE_FRAMEBUFFER_ALLOCATE =                   0x00040001,
-- 
2.6.2

