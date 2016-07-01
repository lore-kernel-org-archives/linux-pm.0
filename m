From: Peter Chen <peter.chen@nxp.com>
Subject: [PATCH 0/7] add missing of_node_put after calling of_parse_phandle (1st)
Date: Fri, 1 Jul 2016 17:41:54 +0800
Message-ID: <1467366121-14120-1-git-send-email-peter.chen__31073.7855070785$1467379603$gmane$org@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: linux-renesas-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Cc: Peter Chen <peter.chen@nxp.com>
List-Id: linux-pm@vger.kernel.org

Hi all,

of_node_put needs to be called when the device node which is got
from of_parse_phandle has finished using, but there are many codes
do not follow that, this patch set fixes some of them.

Peter Chen (7):
  extcon: add missing of_node_put after calling of_parse_phandle
  arm: mach-shmobile: pm-rmobile: add missing of_node_put after calling
    of_parse_phandle
  arm: mach-u300: regulator: add missing of_node_put after calling
    of_parse_phandle
  bus: arm-cci: add missing of_node_put after calling of_parse_phandle
  bus: vexpress-config: add missing of_node_put after calling
    of_parse_phandle
  devfreq: add missing of_node_put after calling of_parse_phandle
  devfreq: exynos-bus: add missing of_node_put after calling
    of_parse_phandle

 arch/arm/mach-shmobile/pm-rmobile.c |  1 +
 arch/arm/mach-u300/regulator.c      | 12 +++++++++---
 drivers/bus/arm-cci.c               |  5 ++++-
 drivers/bus/vexpress-config.c       |  1 +
 drivers/devfreq/devfreq.c           |  2 ++
 drivers/devfreq/exynos-bus.c        |  9 ++++++---
 drivers/extcon/extcon.c             |  2 ++
 7 files changed, 25 insertions(+), 7 deletions(-)

-- 
1.9.1
