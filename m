From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH - resend 2/3] thermal/drivers/cpu_cooling: Add Software Package Data Exchange (SPDX)
Date: Sun, 28 Apr 2019 11:51:04 +0200
Message-ID: <20190428095106.5171-2-daniel.lezcano@linaro.org>
References: <20190428095106.5171-1-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190428095106.5171-1-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com, rui.zhang@intel.com
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Philippe Ombredanne <pombredanne@nexb.com>, Amit Daniel Kachhap <amit.kachhap@gmail.com>, Javi Merino <javi.merino@kernel.org>
List-Id: linux-pm@vger.kernel.org

For license auditing purpose, let's add the SPDX tag.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Acked-by: Philippe Ombredanne <pombredanne@nexb.com>
---
 drivers/thermal/cpu_cooling.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index 42aeb9087cab..b9d152a5f7ba 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -1,3 +1,4 @@
+// SPDX-License-Identifier: GPL-2.0
 /*
  *  linux/drivers/thermal/cpu_cooling.c
  *
@@ -8,21 +9,6 @@
  *  Authors:	Amit Daniel <amit.kachhap@linaro.org>
  *		Viresh Kumar <viresh.kumar@linaro.org>
  *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; version 2 of the License.
- *
- *  This program is distributed in the hope that it will be useful, but
- *  WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
- *  General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License along
- *  with this program; if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA 02111-1307 USA.
- *
- * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  */
 #include <linux/module.h>
 #include <linux/thermal.h>
-- 
2.17.1
