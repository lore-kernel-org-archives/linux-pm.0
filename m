From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: [PATCH 1/8] thermal/drivers/cpu_cooling: Fixup the header and copyright
Date: Tue, 23 Jan 2018 16:34:24 +0100
Message-ID: <1516721671-16360-2-git-send-email-daniel.lezcano@linaro.org>
References: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1516721671-16360-1-git-send-email-daniel.lezcano@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: edubezval@gmail.com
Cc: kevin.wangtao@linaro.org, leo.yan@linaro.org, vincent.guittot@linaro.org, amit.kachhap@gmail.com, viresh.kumar@linaro.org, linux-kernel@vger.kernel.org, Javi Merino <javi.merino@kernel.org>, Zhang Rui <rui.zhang@intel.com>, "open list:THERMAL/CPU_COOLING" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

The copyright format does not conform to the format requested by
Linaro: https://wiki.linaro.org/Copyright

Fix it.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/thermal/cpu_cooling.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/cpu_cooling.c b/drivers/thermal/cpu_cooling.c
index dc63aba..988fc55 100644
--- a/drivers/thermal/cpu_cooling.c
+++ b/drivers/thermal/cpu_cooling.c
@@ -2,9 +2,11 @@
  *  linux/drivers/thermal/cpu_cooling.c
  *
  *  Copyright (C) 2012	Samsung Electronics Co., Ltd(http://www.samsung.com)
- *  Copyright (C) 2012  Amit Daniel <amit.kachhap@linaro.org>
  *
- *  Copyright (C) 2014  Viresh Kumar <viresh.kumar@linaro.org>
+ *  Copyright (C) 2018 Linaro Limited.
+ *
+ *  Authors:	Amit Daniel <amit.kachhap@linaro.org>
+ *		Viresh Kumar <viresh.kumar@linaro.org>
  *
  * ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  *  This program is free software; you can redistribute it and/or modify
-- 
2.7.4
