From: Wen Yang <wen.yang99@zte.com.cn>
Subject: [PATCH 0/2] fix leaked of_node references in drivers/power
Date: Wed, 17 Apr 2019 10:43:01 +0800
Message-ID: <1555468983-34952-1-git-send-email-wen.yang99@zte.com.cn>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: wang.yi59@zte.com.cn, Wen Yang <wen.yang99@zte.com.cn>, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

The call to of_get_cpu_node/of_find_compatible_node/of_parse_phandle...
returns a node pointer with refcount incremented thus it must be
explicitly decremented after the last usage.

We developed a coccinelle SmPL to detect drivers/power code and
found some issues.
This patch series fixes those issues.

Cc: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Wen Yang (2):
  power: supply: fix leaked of_node refs in ab8500_bm_of_probe
  power: supply: fix leaked of_node refs in
    power_supply_get_battery_info

 drivers/power/supply/ab8500_bmdata.c     |  1 +
 drivers/power/supply/power_supply_core.c | 24 ++++++++++++++++--------
 2 files changed, 17 insertions(+), 8 deletions(-)

-- 
2.9.5
