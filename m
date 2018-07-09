From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v2 0/2] Fix imx6sl display power domain
Date: Mon,  9 Jul 2018 15:23:00 +0300
Message-ID: <cover.1531138446.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>
Cc: Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de
List-Id: linux-pm@vger.kernel.org

Right now the imx6sl display power domain is automatically shut down
during boot so lcd doesn't work at all. This has been broken for a while
with old gpc bindings, since nobody noticed fix by converting to new
bindings.

Link to v1: https://lkml.org/lkml/2018/6/5/689

There is also a nasty errata here, treat it like on 6qp.

Previous version included a patch to improve lcdif power management, but
since ERR006287 effectively disables runtime PM for display it is no
longer strictly required.

This doesn't depend on other GPC patches I sent either, it's an
unrelated fix.

Leonard Crestez (2):
  soc: imx: gpc: Disable 6sl display power gating for ERR006287
  ARM: dts: imx6sl: Convert gpc to new bindings

 arch/arm/boot/dts/imx6sl.dtsi | 36 +++++++++++++++++++++++++++++++----
 drivers/soc/imx/gpc.c         | 10 ++++++++++
 2 files changed, 42 insertions(+), 4 deletions(-)

-- 
2.17.1
