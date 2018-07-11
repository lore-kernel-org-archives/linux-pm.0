From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v3 0/2] Fix imx6sl display power domain
Date: Wed, 11 Jul 2018 15:11:15 +0300
Message-ID: <cover.1531310547.git.leonard.crestez@nxp.com>
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
To: Ulf Hansson <ulf.hansson@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-imx@nxp.com, kernel@pengutronix.de, Fabio Estevam <fabio.estevam@nxp.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Changes since v2:
 * Don't mistakenly include IMX6SL_CLK_IPG in pd_disp
 * Use GENPD_FLAG_ALWAYS_ON, as suggested by Ulf

Errata workaround could be refined later, however the power savings are
small and it would require a lot of testing. So push the safest fix
first to get basic hardware support.

Link to v2: https://lkml.org/lkml/2018/7/9/447

Leonard Crestez (2):
  soc: imx: gpc: Disable 6sl display power gating for ERR006287
  ARM: dts: imx6sl: Convert gpc to new bindings

 arch/arm/boot/dts/imx6sl.dtsi | 35 +++++++++++++++++++++++++++++++----
 drivers/soc/imx/gpc.c         | 10 ++++++++++
 2 files changed, 41 insertions(+), 4 deletions(-)

-- 
2.17.1
