From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH 0/3] add support for SAM9X60's shutdown controller
Date: Thu, 14 Feb 2019 11:24:00 +0000
Message-ID: <1550143407-26109-1-git-send-email-claudiu.beznea@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: robh+dt@kernel.org, mark.rutland@arm.com, Nicolas.Ferre@microchip.com, alexandre.belloni@bootlin.com, Ludovic.Desroches@microchip.com, sre@kernel.org
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Claudiu.Beznea@microchip.com
List-Id: linux-pm@vger.kernel.org

From: Claudiu Beznea <claudiu.beznea@microchip.com>

Hi,

This series adapt SAMA5D2's shutdown controller driver to work for
SAM9X60's shutdown controller. The difference is that SAM9X60 have
option for RTT timer wakeup.

Thank you,
Claudiu Beznea

Claudiu Beznea (3):
  power: reset: at91-poweroff: add RTT wakeup capability
  power: reset: at91-poweroff: add support for SAM9X60
  dt-bindings: arm: atmel: add binding for SAM9X60 shutdown controller

 .../devicetree/bindings/arm/atmel-sysregs.txt      |  6 +++++-
 drivers/power/reset/at91-sama5d2_shdwc.c           | 25 ++++++++++++++++++=
++++
 2 files changed, 30 insertions(+), 1 deletion(-)

--=20
2.7.4
