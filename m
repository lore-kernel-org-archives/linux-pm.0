From: Henry Chen <henryc.chen@mediatek.com>
Subject: [RFC RESEND PATCH 0/7] Add driver for dvfsrc and add support for active state of scpsys on mt8183
Date: Wed, 2 Jan 2019 22:09:51 +0800
Message-ID: <1546438198-1677-1-git-send-email-henryc.chen@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <vireshk@kernel.org>, Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Fan Chen <fan.chen@mediatek.com>, Weiyi Lu <weiyi.lu@mediatek.com>, James Liao <jamesjj.liao@mediatek.com>, Kees Cook <keescook@chromium.org>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The patchsets add support for MediaTek hardware module named DVFSRC
(dynamic voltage and frequency scaling resource collector). The DVFSRC is
a HW module which is used to collect all the requests from both software
and hardware and turn into the decision of minimum operating voltage and
minimum DRAM frequency to fulfill those requests.

So, This series is to implement the dvfsrc driver to collect all the
requests of operating voltage or DRAM bandwidth from other device drivers
likes GPU/Camera through 2 frameworks basically:

1. PM_QOS_MEMORY_BANDWIDTH from PM QOS: to aggregate the bandwidth
   requirements from different clients
2. Active state management of power domains[1]: to handle the operating
   voltage opp requirement from different power domains

[1] https://lwn.net/Articles/744047/

Henry Chen (7):
  dt-bindings: soc: Add DVFSRC driver bindings
  dt-bindings: soc: Add opp table on scpsys bindings
  soc: mediatek: add support for the performance state
  arm64: dts: mt8183: add performance state support of scpsys
  soc: mediatek: add header for mediatek SIP interface
  soc: mediatek: add MT8183 dvfsrc support
  arm64: dts: mt8183: add dvfsrc related nodes

 Documentation/devicetree/bindings/opp/mtk-opp.txt  |  24 ++
 .../devicetree/bindings/soc/mediatek/dvfsrc.txt    |  26 ++
 .../devicetree/bindings/soc/mediatek/scpsys.txt    |  42 ++
 arch/arm64/boot/dts/mediatek/mt8183.dtsi           |  29 ++
 drivers/soc/mediatek/Kconfig                       |  15 +
 drivers/soc/mediatek/Makefile                      |   1 +
 drivers/soc/mediatek/mtk-dvfsrc.c                  | 473 +++++++++++++++++++++
 drivers/soc/mediatek/mtk-scpsys.c                  |  60 +++
 drivers/soc/mediatek/mtk-scpsys.h                  |  22 +
 include/dt-bindings/soc/mtk,dvfsrc.h               |  18 +
 include/soc/mediatek/mtk_sip.h                     |  17 +
 11 files changed, 727 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/opp/mtk-opp.txt
 create mode 100644 Documentation/devicetree/bindings/soc/mediatek/dvfsrc.txt
 create mode 100644 drivers/soc/mediatek/mtk-dvfsrc.c
 create mode 100644 drivers/soc/mediatek/mtk-scpsys.h
 create mode 100644 include/dt-bindings/soc/mtk,dvfsrc.h
 create mode 100644 include/soc/mediatek/mtk_sip.h

-- 
1.9.1
