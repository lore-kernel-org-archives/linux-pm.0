From: Karl-Heinz Schneider <karl-heinz@schneider-inet.de>
Subject: [PATCH v3 0/2] Add support for Smart Battery System Manager
Date: Tue, 12 Jul 2016 20:48:13 +0200
Message-ID: <1468349295-4935-1-git-send-email-karl-heinz@schneider-inet.de>
References: <1bIiDr-0004G1-0P>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from schneider-inet.de ([85.214.76.205]:43724 "EHLO
	h1714509.stratoserver.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751112AbcGLSuv (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 12 Jul 2016 14:50:51 -0400
In-Reply-To: <1bIiDr-0004G1-0P>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: devicetree@vger.kernel.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org, linux-i2c@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Peter Rosin <peda@axentia.se>, Phil Reid <preid@electromag.com.au>, Karl-Heinz Schneider <karl-heinz@schneider-inet.de>

This patch series adds support for Smart Battery System Manager.
A SBSM is a device listening at I2C/SMBus address 0x0a and is capable of
communicating up to four I2C smart battery devices. All smart battery
devices are listening at address 0x0b, so the SBSM muliplexes between
them. The driver makes use of the I2C-Mux framework to allow smart
batteries to be bound via device tree, i.e. the sbs-battery driver.

Via sysfs interface the online state and charge type are presented. If
the driver is bound as ltc1760 (a Dual Smart Battery System Manager)
the charge type can also be changed from trickle to fast.

Changes:
V2:
* Fixed sample node names and compatible strings in binding documentaton.
* Removed optional property "sbsm,i2c-retry-count"
* Retry count hardcoded. Removed no longer needed OF readout function
* Rebased onto v4.7rc-5

V3:
* Changed enumeration sheme
* Rebased onto v4.7rc-7

Karl-Heinz Schneider (2):
  Documentation: Add sbs-manager device tree node documentation
  power: Adds support for Smart Battery System Manager

 .../devicetree/bindings/power/sbs,sbs-manager.txt  |  52 ++++
 drivers/power/Kconfig                              |  13 +
 drivers/power/Makefile                             |   1 +
 drivers/power/sbs-manager.c                        | 325 +++++++++++++++++++++
 4 files changed, 391 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/sbs,sbs-manager.txt
 create mode 100644 drivers/power/sbs-manager.c

--
1.9.1
