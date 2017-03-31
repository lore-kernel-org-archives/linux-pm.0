From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH 0/5] ARM: imx: Set LDO regulator supply
Date: Fri, 31 Mar 2017 22:25:35 +0300
Message-ID: <cover.1490987945.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>, Mark Brown <broonie@kernel.org>
Cc: Leonard Crestez <leonard.crestez@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Irina Tirdea <irina.tirdea@nxp.com>, linux-pm@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Octavian Purdila <octavian.purdila@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>, linux-arm-kernel@lists.infradead.org, Lucas Stach <l.stach@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

Setting the LDO regulator parent is optional but beneficial. It will cause
the PMIC output voltage to be dynamically set to the minimum input for the
LDOs, this should be more efficient.

This propagation was introduced by:
commit fc42112c0eaa ("regulator: core: Propagate voltage changes to supply
regulators")

In this case it is desirable that the parent regulator sets the minimum
voltage for it's consumers. It's not clear if this behavior from the
regulator core is entirely intentional. If it's not then perhaps it should
be made configurable through DT somehow?

This makes probe order more complicated, fix that in patches 1 and 2.

It can also break suspend because cpufreq voltage switches can end up
talking to a PMIC via I2C which is already suspended. This is fixed in
patch 3.

It's good to have these issues fixed upstream because they might affect
other complex configurations.

These changes are required for LDO bypass but they are also useful
standalone. Here's a link to the that other discussion:
https://lkml.org/lkml/2017/3/22/640

Irina Tirdea (1):
  cpufreq: imx6q: Fix handling EPROBE_DEFER from regulator

Leonard Crestez (4):
  ARM: imx: gpc: Do not print error message for EPROBE_DEFER
  cpufreq: imx6q: Set max suspend_freq to avoid changes during suspend
  ARM: dts: imx6qdl-sabresd: Set LDO regulator supply
  ARM: dts: imx6qp-sabresd: Set reg_arm regulator supply

 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 12 ++++++++++++
 arch/arm/boot/dts/imx6qp-sabresd.dts   |  4 ++--
 arch/arm/mach-imx/gpc.c                |  6 +++++-
 drivers/cpufreq/imx6q-cpufreq.c        |  9 +++++++++
 4 files changed, 28 insertions(+), 3 deletions(-)

-- 
2.7.4
