From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH 0/4] thermal: imx: Add nvmem-cells binding on imx6sx
Date: Thu, 6 Jul 2017 16:20:40 +0300
Message-ID: <cover.1499347157.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, =?UTF-8?q?Lothar=20Wa=C3=9Fmann?= <LW@KARO-electronics.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Bai Ping <ping.bai@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On imx6sx accessing OCOTP directly is wrong because the ocotp clock needs to be
enabled first. Fix this by adding a nvmem-cells binding and using it on imx6sx,
imx6ul and imx6ull.

The existing binding is kept around because it works fine on imx6qdl.

This was initially reported by Lothar Waßmann <LW@KARO-electronics.de> in reply
to a mail adding imx6ul/ull support:

Link: https://lkml.org/lkml/2017/6/9/578

A previous attempt just reinterpreted the fsl,tempmon-data phandle as nvmem.
Code was actually written to use nvmem-cells first but I thought that
reinterpreting existing devicetree properties would be interesting.

Link: https://lkml.org/lkml/2017/6/19/333

Leonard Crestez (4):
  thermal: imx: Add nvmem-cells alternate binding for OCOTP access
  thermal: imx: Add support for reading OCOTP through nvmem
  ARM: dts: imx6sx: Use nvmem-cells for tempmon
  ARM: dts: imx6ul: Add imx6ul-tempmon

 .../devicetree/bindings/thermal/imx-thermal.txt    |   7 ++
 arch/arm/boot/dts/imx6sx.dtsi                      |  11 +-
 arch/arm/boot/dts/imx6ul.dtsi                      |  17 +++
 drivers/thermal/imx_thermal.c                      | 131 ++++++++++++++++-----
 4 files changed, 135 insertions(+), 31 deletions(-)

-- 
2.7.4
