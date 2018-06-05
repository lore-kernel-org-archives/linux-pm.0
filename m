From: Enric Balletbo i Serra <enric.balletbo@collabora.com>
Subject: [PATCH] power: supply: tps65217: Switch to SPDX identifier.
Date: Tue,  5 Jun 2018 12:00:21 +0200
Message-ID: <20180605100021.3789-1-enric.balletbo@collabora.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: kernel@collabora.com, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Adopt the SPDX license identifier headers to ease license compliance
management.

Signed-off-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
---

 drivers/power/supply/tps65217_charger.c | 22 +++++-----------------
 1 file changed, 5 insertions(+), 17 deletions(-)

diff --git a/drivers/power/supply/tps65217_charger.c b/drivers/power/supply/tps65217_charger.c
index 1f5234098aaf..814c2b81fdfe 100644
--- a/drivers/power/supply/tps65217_charger.c
+++ b/drivers/power/supply/tps65217_charger.c
@@ -1,20 +1,8 @@
-/*
- * Battery charger driver for TI's tps65217
- *
- * Copyright (c) 2015, Collabora Ltd.
-
- * This program is free software; you can redistribute it and/or modify it
- * under the terms and conditions of the GNU General Public License,
- * version 2, as published by the Free Software Foundation.
-
- * This program is distributed in the hope it will be useful, but WITHOUT
- * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
- * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
- * more details.
-
- * You should have received a copy of the GNU General Public License
- * along with this program.  If not, see <http://www.gnu.org/licenses/>.
- */
+// SPDX-License-Identifier: GPL-2.0
+// Battery charger driver for TI's tps65217
+//
+// Copyright (C) 2015 Collabora Ltd.
+// Author: Enric Balletbo i Serra <enric.balletbo@collabora.com>
 
 /*
  * Battery charger driver for TI's tps65217
-- 
2.17.1
