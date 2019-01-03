From: Wei Ni <wni@nvidia.com>
Subject: [PATCH v7 0/3] Fixes for Tegra soctherm
Date: Thu, 3 Jan 2019 18:12:46 +0800
Message-ID: <1546510369-28491-1-git-send-email-wni@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: daniel.lezcano@linaro.org, edubezval@gmail.com
Cc: thierry.reding@gmail.com, linux-tegra@vger.kernel.org, rui.zhang@intel.com, srikars@nvidia.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Wei Ni <wni@nvidia.com>
List-Id: linux-pm@vger.kernel.org

This series fixed some issues for Tegra soctherm,
and add get_trend().

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

Wei Ni (3):
  thermal: tegra: remove unnecessary warnings
  thermal: tegra: fix memory allocation
  thermal: tegra: add get_trend ops

 drivers/thermal/tegra/soctherm.c | 40 +++++++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

-- 
2.7.4
