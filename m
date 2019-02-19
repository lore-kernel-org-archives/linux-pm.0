From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v8 0/3] Fixes for Tegra soctherm
Date: Tue, 19 Feb 2019 12:27:01 +0800
Message-ID: <1550550424-7979-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, edubezval@gmail.com, linux-tegra@vger.kernel.org
Cc: thierry.reding@gmail.com, rui.zhang@intel.com, srikars@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

This series fixed some issues for Tegra soctherm,
and add get_trend().

Main changes from v7:
1. use READ_ONCE to get temperature in get_trend()

Main changes from v6:
1. Per Eduardo's comment, we can remove the change:
"thermal: tegra: parse sensor id before sensor register"

Main changes from v5:
1. Move the get_trend() patch https://lkml.org/lkml/2018/11/20/643
into this serial.

Main changes from v4:
1. fixed for the parsing sensor id.
2. keep warning for missing critical trips.

Main changes from v3:
1. updated codes for parsing sensor id, per Thierry's comments

Main changes from v2:
1. add codes to parse sensor id to avoid registration
failure.

Main changes from v1:
1. Acked by Thierry Reding <treding@nvidia.com> for the patch
"thermal: tegra: fix memory allocation".
2. Print out the sensor name when register failed.
2. Remove patch "thermal: tegra: fix coverity defect"


*** BLURB HERE ***

Wei Ni (3):
  thermal: tegra: remove unnecessary warnings
  thermal: tegra: fix memory allocation
  thermal: tegra: add get_trend ops

 drivers/thermal/tegra/soctherm.c | 38 +++++++++++++++++++++++++++++++++++---
 1 file changed, 35 insertions(+), 3 deletions(-)

-- 
2.7.4
