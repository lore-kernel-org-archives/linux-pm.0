From: Nicolas Ferre <nicolas.ferre@microchip.com>
Subject: [PATCH 0/8] ARM: at91/dt: update to existing drivers for the sam9x60 SoC
Date: Wed, 16 Jan 2019 10:57:36 +0100
Message-ID: <cover.1547629763.git.nicolas.ferre@microchip.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Alexandre Belloni <alexandre.belloni@bootlin.com>, Ludovic Desroches <ludovic.desroches@microchip.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, netdev@vger.kernel.org, "David S . Miller" <davem@davemloft.net>, linux-usb@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>
List-Id: linux-pm@vger.kernel.org

Hi,

This serries collects some little modifications to DT bindings and associated
drivers changes for supporting the upcoming SAM9X60 SoC.

I took the advantage of this series for fixing some of the leftovers in DT
bindings for reset controller and Ethernet macb.

These changes touch several sub-systems but I would like that these (mostly
trivial) patches stay together for facilitating reviews, prevent breaking
dependencies and facilitating the tracking of acceptance status. However, tell
me if you think otherwise.
My intentions are that the series would enter Mainline through arm-soc tree:
sounds okay to everyone? If okay, I'm ready to collect Ack tags...

For the first batch, I send the whole series to everyone. I'll try my best to
reduce subsequent message deliveries if one part of the serries needs rework.

Best regards,
  Nicolas


Nicolas Ferre (8):
  dt-bindings: arm: atmel: add missing samx7 to reset controller
  dt-bindings: arm: atmel: add new sam9x60 reset controller binding
  dt-bindings: arm: atmel: add new sam9x60 SFR binding
  net/macb: bindings doc/trivial: fix documentation for sama5d3 10/100
    interface
  net/macb: bindings doc: add sam9x60 binding
  power: reset: at91-reset: add support for sam9x60 SoC
  USB: host: ohci-at91: add sam9x60-sfr definition for ohci
  net: macb: add sam9x60-macb compatibility string

 .../devicetree/bindings/arm/atmel-sysregs.txt       |  4 +++-
 Documentation/devicetree/bindings/net/macb.txt      |  4 ++--
 drivers/net/ethernet/cadence/macb_main.c            |  1 +
 drivers/power/reset/at91-reset.c                    | 13 +++++++++++++
 drivers/usb/host/ohci-at91.c                        |  7 +++++--
 5 files changed, 24 insertions(+), 5 deletions(-)

-- 
2.17.1
