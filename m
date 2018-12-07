From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH] thermal: uniphier: Convert to SPDX identifier
Date: Fri,  7 Dec 2018 10:06:04 +0900
Message-ID: <1544144764-17964-1-git-send-email-hayashi.kunihiko@socionext.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Eduardo Valentin <edubezval@gmail.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
List-Id: linux-pm@vger.kernel.org

This converts license boilerplate to SPDX identifier, and removes
unnecessary lines.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/thermal/uniphier_thermal.c | 13 +------------
 1 file changed, 1 insertion(+), 12 deletions(-)

diff --git a/drivers/thermal/uniphier_thermal.c b/drivers/thermal/uniphier_thermal.c
index 55477d7..bba2284 100644
--- a/drivers/thermal/uniphier_thermal.c
+++ b/drivers/thermal/uniphier_thermal.c
@@ -1,21 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0
 /**
  * uniphier_thermal.c - Socionext UniPhier thermal driver
- *
  * Copyright 2014      Panasonic Corporation
  * Copyright 2016-2017 Socionext Inc.
- * All rights reserved.
- *
  * Author:
  *	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
- *
- * This program is free software: you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2  of
- * the License as published by the Free Software Foundation.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
  */
 
 #include <linux/bitops.h>
-- 
2.7.4
