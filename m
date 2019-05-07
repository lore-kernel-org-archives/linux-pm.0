From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v3 0/4] cpufreq: Add imx-cpufreq-dt driver
Date: Tue, 7 May 2019 13:52:21 +0000
Message-ID: <cover.1557236799.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Rob Herring <robh+dt@kernel.org>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Mark Rutland <mark.rutland@arm.com>, Jacky Bai <ping.bai@nxp.com>, Anson Huang <anson.huang@nxp.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael
 J. Wysocki" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Abel Vesa <abel.vesa@nxp.com>
List-Id: linux-pm@vger.kernel.org

Right now in upstream imx8m cpufreq support just lists a common subset
of OPPs because the higher ones should only be attempted after checking
speed grading in fuses.

Driver reads from nvmem and calls dev_pm_opp_set_supported_hw before
registering cpufreq-dt.

Changes since v2:
 * Minor reformatting in Kconfig (Viresh)
 * Open-code imx_cpufreq_dt_match_node (Viresh)
 * Add mkt_segment bits to supported_hw and update .dtsi to match after
reviewing latest datasheets.
 * Add dt-bindings like other opp-supported-hw users
 * Add devicetree mailing list (keep forgetting dts needs to be reviewed)
Link to v2: https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=113163
Link to v1 (RFC): https://patchwork.kernel.org/patch/10916769/

I never noticed anything wrong with going above the fused speed grading
however it's technically unsafe so the cpufreq code changes should go in
before DT changes.

Driver is module by default. It depends on nvmem-imx which can also be a
module.

It's a platform device registered from soc-imx8 because couldn't find
any appropriate node for MODULE_DEVICE_TABLE(of).

Leonard Crestez (4):
  cpufreq: Add imx-cpufreq-dt driver
  dt-bindings: imx-cpufreq-dt: Document opp-supported-hw usage
  arm64: dts: imx8mm: Add cpu speed grading and all OPPs
  arm64: dts: imx8mq: Add cpu speed grading and all OPPs

 .../bindings/cpufreq/imx-cpufreq-dt.txt       | 37 +++++++
 arch/arm64/boot/dts/freescale/imx8mm.dtsi     | 17 +++-
 arch/arm64/boot/dts/freescale/imx8mq.dtsi     | 26 ++++-
 drivers/cpufreq/Kconfig.arm                   | 10 ++
 drivers/cpufreq/Makefile                      |  1 +
 drivers/cpufreq/cpufreq-dt-platdev.c          |  3 +
 drivers/cpufreq/imx-cpufreq-dt.c              | 96 +++++++++++++++++++
 drivers/soc/imx/soc-imx8.c                    |  3 +
 8 files changed, 191 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/cpufreq/imx-cpufreq-dt.txt
 create mode 100644 drivers/cpufreq/imx-cpufreq-dt.c

-- 
2.17.1
