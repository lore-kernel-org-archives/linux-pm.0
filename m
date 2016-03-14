From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v4 0/2] Add UCS1002 USB Port Power Controller
Date: Mon, 14 Mar 2016 10:24:43 +0100
Message-ID: <1457947485-14140-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bhuna.collabora.co.uk ([46.235.227.227]:40985 "EHLO
	bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934024AbcCNJY4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 14 Mar 2016 05:24:56 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Martyn Welch <martyn.welch@collabora.com>

Dear all,

This is the fourth version of the UCS1002 driver, a Programmable USB Port
Power Controller with Charger Emulation.

Any comments are welcome. Thanks in advance.

Enric Balletbo i Serra (2):
  devicetree: Add UCS1002 USB Port Power Controller binding
  power: ucs1002: Add support for Programmable USB Port Power Controller

 .../devicetree/bindings/power/ucs1002.txt          |   41 +
 drivers/power/Kconfig                              |    9 +
 drivers/power/Makefile                             |    1 +
 drivers/power/ucs1002_power.c                      | 1004 ++++++++++++++++++++
 4 files changed, 1055 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/ucs1002.txt
 create mode 100644 drivers/power/ucs1002_power.c

-- 
2.1.0

