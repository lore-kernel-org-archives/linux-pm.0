From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH 0/4] devfreq: exynos4: Support dt and use common ppmu driver
Date: Wed, 12 Mar 2014 20:47:58 +0900
Message-ID: <1394624882-2989-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com
Cc: rafael.j.wysocki@intel.com, nm@ti.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patchset support devicetree and use common ppmu driver instead of
individual code of exynos4_bus.c to remove duplicate code. Also this patchset
get the resources for busfreq from dt data by using DT helper function.
- PPMU register address
- PPMU clock
- Regulator for INT/MIF block

This patchset use SET_SYSTEM_SLEEP_PM_OPS macro intead of legacy method.
To remove power-leakage in suspend state, before entering suspend state,
disable ppmu clocks.

Chanwoo Choi (4):
  devfreq: exynos4: Support devicetree to get device id of Exynos4 SoC
  devfreq: exynos4: Use common ppmu driver and get ppmu address from dt data
  devfreq: exynos4: Add ppmu's clock control and code clean about regulator control
  devfreq: exynos4: Use SET_SYSTEM_SLEEP_PM_OPS macro instead of legacy method

 drivers/devfreq/exynos/exynos4_bus.c | 396 ++++++++++++++++++++++++-----------
 1 file changed, 271 insertions(+), 125 deletions(-)

-- 
1.8.0
