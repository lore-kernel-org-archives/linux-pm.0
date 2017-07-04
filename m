From: <sean.wang@mediatek.com>
Subject: [PATCH v2 0/3] some fixups for MediaTek cpufreq driver
Date: Wed, 5 Jul 2017 02:55:27 +0800
Message-ID: <cover.1499194061.git.sean.wang@mediatek.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: viresh.kumar@linaro.org, robh+dt@kernel.org, matthias.bgg@gmail.com, mark.rutland@arm.com, jamesjj.liao@mediatek.com, p.zabel@pengutronix.de, shunli.wang@mediatek.com, erin.lo@mediatek.com, jdelvare@suse.de, devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, Sean Wang <sean.wang@mediatek.com>
List-Id: linux-pm@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Changes since v1:
- drop those patches already accepted
- refine the commit messages and Kconfig dependency
- Kconfig menu entry and file name itself are updated with more
generic name to drop "MT8173" since this driver actually supports
all MediaTek SoCs.
- generate patchset again with git format-patch -C -M --thread=shallow
- fix binding examples by replacing '@' with '-' as the OPP nodes will
never have a "reg" property.

Hi,

The purpose of the series is
- (patch 1 to 3) to fix up current Mediatek cpufreq driver
can't work with the latest tree since one required CPU clock muxer missing
would cause the driver getting the resource fails when driver probe gets
called.
- (patch 4) to enable cpufreq feature on MT2701/MT7623 platform.
- (patch 5 to 6) to update the binding document to reflect
latest driver logic and add more examples guiding people how to apply for
Mediatek cpufreq driver.

Sean Wang (3):
  cpufreq: mediatek: Add support of cpufreq to MT2701/MT7623 SoC
  dt-bindings: cpufreq: move MediaTek cpufreq dt-bindings document to
    proper place
  dt-bindings: cpufreq: enhance MediaTek cpufreq dt-binding document

 .../devicetree/bindings/clock/mt8173-cpu-dvfs.txt  |  83 -------
 .../bindings/cpufreq/cpufreq-mediatek.txt          | 247 +++++++++++++++++++++
 drivers/cpufreq/Kconfig.arm                        |   8 +-
 drivers/cpufreq/Makefile                           |   2 +-
 .../cpufreq/{mt8173-cpufreq.c => mtk-cpufreq.c}    |   2 +
 5 files changed, 254 insertions(+), 88 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/clock/mt8173-cpu-dvfs.txt
 create mode 100644 Documentation/devicetree/bindings/cpufreq/cpufreq-mediatek.txt
 rename drivers/cpufreq/{mt8173-cpufreq.c => mtk-cpufreq.c} (99%)

-- 
2.7.4
