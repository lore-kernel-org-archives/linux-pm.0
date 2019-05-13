From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v4 0/5] cpufreq: Add imx-cpufreq-dt driver for speed grading
Date: Mon, 13 May 2019 11:01:37 +0000
Message-ID: <cover.1557742902.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
Content-ID: <13C41D9609273F49A77AE0DA0AB8AA6B@eurprd04.prod.outlook.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Shawn Guo <shawnguo@kernel.org>, Rob Herring <robh+dt@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Aisheng Dong <aisheng.dong@nxp.com>, Jacky Bai <ping.bai@nxp.com>, Anson Huang <anson.huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Abel Vesa <abel.vesa@nxp.com>
List-Id: linux-pm@vger.kernel.org

Right now in upstream imx8m cpufreq support just lists a common subset
of OPPs because the higher ones should only be attempted after checking
speed grading in fuses.

Driver reads from nvmem and calls dev_pm_opp_set_supported_hw before
registering cpufreq-dt.

Changes since v3:
 * Drop default m entirely (Viresh)
Link to v3: https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=114685

Changes since v2:
 * Minor reformatting in Kconfig (Viresh)
 * Open-code imx_cpufreq_dt_match_node (Viresh)
 * Add mkt_segment bits to supported_hw and update .dtsi to match after
reviewing latest datasheets.
 * Add devicetree list (keep forgetting dts needs to be reviewed)
Link to v2: https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=113163

Link to v1 (RFC): https://patchwork.kernel.org/patch/10916769/

Driver is built as a module. It depends on nvmem-imx which can also be a
module.

I never noticed anything wrong with going above the fused speed grading
however it's technically unsafe so the cpufreq code changes should go in
before DT changes.

Leonard Crestez (5):
  cpufreq: Add imx-cpufreq-dt driver
  dt-bindings: imx-cpufreq-dt: Document opp-supported-hw usage
  arm64: dts: imx8mm: Add cpu speed grading and all OPPs
  arm64: dts: imx8mq: Add cpu speed grading and all OPPs
  arm64: defconfig: ARM_IMX_CPUFREQ_DT=m

 .../bindings/cpufreq/imx-cpufreq-dt.txt       | 37 +++++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 17 +++-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 26 ++++-
 arch/arm64/configs/defconfig                  |  1 +
 drivers/cpufreq/Kconfig.arm                   |  9 ++
 drivers/cpufreq/Makefile                      |  1 +
 drivers/cpufreq/cpufreq-dt-platdev.c          |  3 +
 drivers/cpufreq/imx-cpufreq-dt.c              | 96 +++++++++++++++++++
 drivers/soc/imx/soc-imx8.c                    |  3 +
 9 files changed, 191 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/imx-cpufreq-dt.txt
 create mode 100644 drivers/cpufreq/imx-cpufreq-dt.c

-- 
2.17.1
