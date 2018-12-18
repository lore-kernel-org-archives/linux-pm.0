From: Aisheng Dong <aisheng.dong@nxp.com>
Subject: [PATCH 0/3] firmware: imx: scu-pd: add fallback compatible string
 support
Date: Tue, 18 Dec 2018 16:01:14 +0000
Message-ID: <1545148524-658-1-git-send-email-aisheng.dong@nxp.com>
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
Cc: Aisheng Dong <aisheng.dong@nxp.com>, "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>, "dongas86@gmail.com" <dongas86@gmail.com>, "khilman@kernel.org" <khilman@kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, dl-linux-imx <linux-imx@nxp.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>
List-Id: linux-pm@vger.kernel.org

SCU power domain can be used in the same way by IMX8QXP and IMX8QM SoCs.
Let's add a "fsl,scu-pd" fallback compatible string to allow other SoCs
to reuse the common part.

Dong Aisheng (3):
  dt-bindings: fsl: scu: add fallback compatible string for power domain
  dt-bindings: fsl: scu: add imx8qm scu power domain support
  firmware: imx: scu-pd: add fallback compatible string support

 Documentation/devicetree/bindings/arm/freescale/fsl,scu.txt | 8 ++++++--
 drivers/firmware/imx/scu-pd.c                               | 1 +
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.7.4
