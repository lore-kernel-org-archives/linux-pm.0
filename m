From: Leonard Crestez <leonard.crestez@nxp.com>
Subject: [PATCH 0/2] soc: imx: gpc: Power off PU domain in suspend/resume on 6qp
Date: Mon,  2 Jul 2018 14:52:33 +0300
Message-ID: <cover.1530530881.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>, Andrey Smirnov <andrew.smirnov@gmail.com>, Shawn Guo <shawnguo@kernel.org>
Cc: Fabio Estevam <fabio.estevam@nxp.com>, Dong Aisheng <aisheng.dong@nxp.com>, Anson Huang <Anson.Huang@nxp.com>, Robin Gong <yibin.gong@nxp.com>, linux-imx@nxp.com, kernel@pengutronix.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Tested by doing `rtcwake -s 5 -m mem` while running glxgears on etnaviv.

The first patch is required because otherwise it is not easy to reach pgc
domains from the gpc itself when using new-style bindings. It's also
easier to understand.

The use of dynamic allocation in this driver is strange. Since there is
only one GPC physically present in each soc my impulse would be to make
most things global and delete imx_gpc_driver.remove entirely.

With current code (even without my patches) attempting to dynamically
remove/probe the GPC fils since since the per-pgc platform_device
instances are not removed. I'm trying something like this:

echo 130000.gpu > /sys/bus/platform/drivers/etnaviv-gpu/unbind
echo 134000.gpu > /sys/bus/platform/drivers/etnaviv-gpu/unbind
echo 20dc000.gpc  > /sys/bus/platform/drivers/imx-gpc/unbind
echo 20dc000.gpc  > /sys/bus/platform/drivers/imx-gpc/bind

But is there any usecase for dynamically removing the GPC? Instead of
trying to fix it I'd rather delete imx_gpc_driver.remove, just like
for gpcv2. Would anyone object to a patch doing this?

This series is not very pretty, constructive suggestions is welcome.
NXP internal tree has quite a lot of changes in gpc code and this causes
a lot of trouble when doing upgrades so I am trying to push some of the
internal features upstream.

Maybe instead of direct calls from mach-imx the gpc could implement
SLEEP_PM_OPS instead? It would still need a way to access the pgc
devices directly.

Leonard Crestez (2):
  soc: imx: gpc: Use static platform_device instances
  soc: imx: gpc: Power off PU domain in suspend/resume on 6qp

 arch/arm/mach-imx/gpc.c | 10 +++++
 drivers/soc/imx/gpc.c   | 93 ++++++++++++++++++++++++++---------------
 2 files changed, 70 insertions(+), 33 deletions(-)

-- 
2.17.1
