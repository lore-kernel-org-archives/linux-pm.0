From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH 0/2] soc: imx: add scu power domain driver
Date: Sat, 28 Apr 2018 02:51:01 +0800
Message-ID: <1524855063-14996-1-git-send-email-aisheng.dong@nxp.com>
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
To: linux-arm-kernel@lists.infradead.org
Cc: Dong Aisheng <aisheng.dong@nxp.com>, ulf.hansson@linaro.org, dongas86@gmail.com, khilman@kernel.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-imx@nxp.com, kernel@pengutronix.de, fabio.estevam@nxp.com, shawnguo@kernel.org
List-Id: linux-pm@vger.kernel.org

This patch set adds the scu based power domain driver.
It depends on SCU APIs patch set.

Dong Aisheng (2):
  dt-bindings: power: add i.MX SCU power domains binding doc
  soc: imx: add SCU power domains driver

 .../devicetree/bindings/power/nxp,imx-pd-scu.txt   |  84 ++++++++++++
 drivers/soc/imx/Kconfig                            |   4 +
 drivers/soc/imx/Makefile                           |   1 +
 drivers/soc/imx/sc-pd.c                            | 151 +++++++++++++++++++++
 4 files changed, 240 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/power/nxp,imx-pd-scu.txt
 create mode 100644 drivers/soc/imx/sc-pd.c

-- 
2.7.4
