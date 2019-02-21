From: <Claudiu.Beznea@microchip.com>
Subject: [PATCH v2 0/3] add support for SAM9X60's shutdown controller
Date: Thu, 21 Feb 2019 13:45:44 +0000
Message-ID: <1550756716-3032-1-git-send-email-claudiu.beznea@microchip.com>
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

Changes in v2:
- collect Acked-by tags
- in patch 3/3 use "optional microchip,sam9x60-shdwc properties"
  string to specify that the introduced property is only for
  microchip,sam9x60-shdwc as specified above in case of
  atmel,<chip>-shdwc shutdown controllers
- in patch 3/3 keep only the optional property introduced by
  microchip,sam9x60-shwdwc (atmel,wakeup-rtt-timer)

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
