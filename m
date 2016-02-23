From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH v3 0/2] Add UCS1002 USB Port Power Controller
Date: Tue, 23 Feb 2016 08:27:03 +0100
Message-ID: <1456212425-5937-1-git-send-email-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rob Herring <robh+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Sjoerd Simons <sjoerd.simons@collabora.co.uk>, Martyn Welch <martyn.welch@collabora.com>
List-Id: linux-pm@vger.kernel.org

Dear all,

This is the third version of the UCS1002 driver, a Programmable USB Port
Power Controller with Charger Emulation.

Any comments are welcome. Thanks in advance.

Enric Balletbo i Serra (2):
  devicetree: Add UCS1002 USB Port Power Controller binding
  power: ucs1002: Add support for Programmable USB Port Power Controller

 .../devicetree/bindings/power/ucs1002.txt          |   41 +
 drivers/power/Kconfig                              |    7 +
 drivers/power/Makefile                             |    1 +
 drivers/power/ucs1002_power.c                      | 1004 ++++++++++++++++++++
 4 files changed, 1053 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/ucs1002.txt
 create mode 100644 drivers/power/ucs1002_power.c

-- 
2.1.0
