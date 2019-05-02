From: Phong Tran <tranmanphong@gmail.com>
Subject: [PATCH] power: supply: core: fix clang -Wunsequenced
Date: Thu,  2 May 2019 08:27:06 +0700
Message-ID: <20190502012704.12505-1-tranmanphong@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sre@kernel.org
Cc: ndesaulniers@google.com, natechancellor@gmail.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com, Phong Tran <tranmanphong@gmail.com>
List-Id: linux-pm@vger.kernel.org

The increment operator of  pointer in be32_to_cpu() is not explicitly.
It made the warning from clang:

drivers/power/supply/power_supply_core.c:674:36: error: multiple
unsequenced modifications to 'list' [-Werror,-Wunsequenced]
drivers/power/supply/power_supply_core.c:675:41: error: multiple
unsequenced modifications to 'list' [-Werror,-Wunsequenced]

Link: https://github.com/ClangBuiltLinux/linux/issues/460

Signed-off-by: Phong Tran <tranmanphong@gmail.com>
---
 drivers/power/supply/power_supply_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/power_supply_core.c b/drivers/power/supply/power_supply_core.c
index c917a8b43b2b..7cc6f5fac0d0 100644
--- a/drivers/power/supply/power_supply_core.c
+++ b/drivers/power/supply/power_supply_core.c
@@ -665,8 +665,10 @@ int power_supply_get_battery_info(struct power_supply *psy,
 		}
 
 		for (i = 0; i < tab_len; i++) {
-			table[i].ocv = be32_to_cpu(*list++);
-			table[i].capacity = be32_to_cpu(*list++);
+			table[i].ocv = be32_to_cpu(*list);
+			list++;
+			table[i].capacity = be32_to_cpu(*list);
+			list++;
 		}
 	}
 
-- 
2.21.0
