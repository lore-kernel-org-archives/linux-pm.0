From: Roger Lu <roger.lu@mediatek.com>
Subject: PM / AVS: SVS: Introduce SVS engine
Date: Tue, 30 Apr 2019 19:20:09 +0800
Message-ID: <20190430112012.4514-1-roger.lu@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>
Cc: Mark Rutland <mark.rutland@arm.com>, Nishanth Menon <nm@ti.com>, Kevin Hilman <khilman@kernel.org>, Roger Lu <roger.lu@mediatek.com>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The SVS (Smart Voltage Scaling) engine is a piece of hardware which is
used to calculate optimized voltage values of several power domains, e.g.
CPU/GPU/CCI, according to chip process corner, temperatures, and other
factors. Then DVFS driver could apply those optimized voltage values to
reduce power consumption.

Roger Lu (3):
  dt-bindings: soc: add mtk svs dt-bindings
  arm64: dts: mt8183: add svs device information
  PM / AVS: SVS: Introduce SVS engine

 .../devicetree/bindings/power/mtk-svs.txt     |   70 +
 arch/arm64/boot/dts/mediatek/mt8183-evb.dts   |   16 +
 arch/arm64/boot/dts/mediatek/mt8183.dtsi      |   46 +
 drivers/power/avs/Kconfig                     |   10 +
 drivers/power/avs/Makefile                    |    1 +
 drivers/power/avs/mtk_svs.c                   | 2084 +++++++++++++++++
 include/linux/power/mtk_svs.h                 |   23 +
 7 files changed, 2250 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/mtk-svs.txt
 create mode 100644 drivers/power/avs/mtk_svs.c
 create mode 100644 include/linux/power/mtk_svs.h

--
2.18.0
