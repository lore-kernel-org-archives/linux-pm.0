From: Dong Aisheng <aisheng.dong@nxp.com>
Subject: [PATCH V2 0/2] soc: imx: add scu power domain driver
Date: Wed, 26 Sep 2018 00:36:29 +0800
Message-ID: <1537893391-31084-1-git-send-email-aisheng.dong@nxp.com>
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
It depends on SCU driver.

Dong Aisheng (2):
  firmware: imx: add pm svc headfile
  firmware: imx: add SCU power domain driver

 drivers/firmware/imx/Kconfig  |   6 ++
 drivers/firmware/imx/Makefile |   3 +-
 drivers/firmware/imx/scu-pd.c | 175 ++++++++++++++++++++++++++++++++++++++++++
 include/soc/imx/scu/sci.h     |   1 +
 include/soc/imx/scu/svc/pm.h  |  85 ++++++++++++++++++++
 5 files changed, 269 insertions(+), 1 deletion(-)
 create mode 100644 drivers/firmware/imx/scu-pd.c
 create mode 100644 include/soc/imx/scu/svc/pm.h

-- 
2.7.4
