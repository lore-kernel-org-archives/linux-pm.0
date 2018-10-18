From: "A.s. Dong" <aisheng.dong@nxp.com>
Subject: [PATCH V7 0/3] soc: imx: add scu power domain driver
Date: Thu, 18 Oct 2018 17:25:52 +0000
Message-ID: <1539883285-7990-1-git-send-email-aisheng.dong@nxp.com>
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
To: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Cc: "A.s. Dong" <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>
List-Id: linux-pm@vger.kernel.org

This patch set adds the scu based power domain driver.
It depends on SCU driver.

Change Log:
v6->v7:
 * keep "fsl,scu-pd" as fall back compatible string
v5->v6:
 * only compatible string name updated from fsl,scu-pd to fsl,imx8qxp-scu-pd
   accordingly
v4->v5:
 * some minor improvements according to Sascha's suggestion
   Note: did not use dev_* print functions due to we already have proper
         prefix by redefining pr_fmt. So it seems not quite neccesary
	 to pass in a struct device * pointer for debug purpose only in
	 each functions.
v3->v4:
 * only scu headfile path update

v2->v3:
 * structure and enums name update
 * api usage update

Dong Aisheng (3):
  dt-bindings: fsl: scu: make power domain compatible string SoC
    specific
  firmware: imx: add pm svc headfile
  firmware: imx: add SCU power domain driver

 .../devicetree/bindings/arm/freescale/fsl,scu.txt  |   6 +-
 drivers/firmware/imx/Kconfig                       |   6 +
 drivers/firmware/imx/Makefile                      |   3 +-
 drivers/firmware/imx/scu-pd.c                      | 164 +++++++++++++++++++++
 include/linux/firmware/imx/sci.h                   |   1 +
 include/linux/firmware/imx/svc/pm.h                |  85 +++++++++++
 6 files changed, 262 insertions(+), 3 deletions(-)
 create mode 100644 drivers/firmware/imx/scu-pd.c
 create mode 100644 include/linux/firmware/imx/svc/pm.h

-- 
2.7.4
