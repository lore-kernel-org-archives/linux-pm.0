From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH v4 0/2] Allow imx6qp PU domain off in suspend
Date: Fri, 26 Apr 2019 21:38:13 +0000
Message-ID: <cover.1556313614.git.leonard.crestez@nxp.com>
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
To: Ulf Hansson <ulf.hansson@linaro.org>, Lucas Stach <l.stach@pengutronix.de>, Viresh Kumar <viresh.kumar@linaro.org>
Cc: Aisheng Dong <aisheng.dong@nxp.com>, Anson Huang <anson.huang@nxp.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Arulpandiyan Vadivel <Arulpandiyan_Vadivel@mentor.com>, "kernel@pengutronix.de" <kernel@pengutronix.de>, Fabio Estevam <fabio.estevam@nxp.com>, Robin Gong <yibin.gong@nxp.com>, Shawn Guo <shawnguo@kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, dl-linux-imx <linux-imx@nxp.com>
List-Id: linux-pm@vger.kernel.org

On imx6qp power gating on the PU domain is disabled because of errata
ERR009619. However power gating during suspend/resume can still be
performed.

Implemented with a new core flag because otherwise distinguishing
between "runtime off" and "suspend off" is very complicated.

Link to v3 for previous attempt: https://lkml.org/lkml/2018/7/6/698

The imx vendor tree has been doing this for a many years but it uses
direct calls from platform suspend to GPC driver.

Link to v1 for similar attempt: https://lkml.org/lkml/2018/7/2/357

Leonard Crestez (2):
  PM / Domains: Add GENPD_FLAG_NO_RUNTIME_OFF flag
  soc: imx: gpc: Use GENPD_FLAG_NO_RUNTIME_OFF for ERR009619

 drivers/base/power/domain.c |  8 ++++++--
 drivers/soc/imx/gpc.c       | 13 +++++++++++--
 include/linux/pm_domain.h   |  4 ++++
 3 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.17.1
