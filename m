From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v2 0/4] ARM: imx: Set LDO regulator supply
Date: Tue, 4 Apr 2017 20:04:10 +0300
Message-ID: <cover.1491324640.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-sn1nam02on0079.outbound.protection.outlook.com ([104.47.36.79]:60160
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1753452AbdDDREb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
        Tue, 4 Apr 2017 13:04:31 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Mark Brown <broonie@kernel.org>, Robin Gong <yibin.gong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Octavian Purdila <octavian.purdila@nxp.com>, Liam Girdwood <lgirdwood@gmail.com>, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org

Setting the LDO regulator parent is optional but beneficial. It will cause
the PMIC output voltage to be dynamically set to the minimum input for the
LDOs, this should be more efficient.

This propagation was introduced by:
commit fc42112c0eaa ("regulator: core: Propagate voltage changes to supply
regulators")

Changes since v1:
 * Drop patch 1 since it only avoids logging a warning and the gpc driver
is going through more changes.
 * Initialize cpufreq->suspend_freq based on policy->max instead.
 * Remove reference to ldo-bypass from suspend_freq patch message.

It's not clear if policy->cpuinfo.max would be preferable, at init time
they should be identical.

Link: https://lkml.org/lkml/2017/3/31/683

Irina Tirdea (1):
  cpufreq: imx6q: Fix handling EPROBE_DEFER from regulator

Leonard Crestez (3):
  cpufreq: imx6q: Set max suspend_freq to avoid changes during suspend
  ARM: dts: imx6qdl-sabresd: Set LDO regulator supply
  ARM: dts: imx6qp-sabresd: Set reg_arm regulator supply

 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/imx6qp-sabresd.dts   |  4 ++--
 drivers/cpufreq/imx6q-cpufreq.c        | 15 ++++++++++++++-
 3 files changed, 28 insertions(+), 3 deletions(-)

-- 
2.7.4
