From: Beomho Seo <beomho.seo@samsung.com>
Subject: [PATCH v2 0/2] power: max17042-battery: Modify max17042 battery driver
Date: Fri, 03 Apr 2015 17:26:07 +0900
Message-ID: <1428049570-3295-1-git-send-email-beomho.seo@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org, k.kozlowski@samsung.com
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cw00.choi@samsung.com, inki.dae@samsung.com, sangbae90.lee@samsung.com, Beomho Seo <beomho.seo@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch modify max17042-battery.c fuel gauge driver for use max77843 fuel
gauge. and then, fix minor cording style issue.

This patchset is written based on recently battery git tree.

Changes in v2
- Remove Ncked patcheset.
- Remove reg_type.
- Fix patch description.
- Add Reviewed-by label.

Beomho Seo (2):
  power: max17042_battery: Use reg type instead of chip type
  power: max17042_battery: add missed blank

 drivers/power/max17042_battery.c       |   35 +++++++++++---------------------
 include/linux/power/max17042_battery.h |    9 +++++++-
 2 files changed, 20 insertions(+), 24 deletions(-)

-- 
1.7.9.5
