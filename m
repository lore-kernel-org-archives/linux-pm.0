From: Tao Wang <kevin.wangtao@hisilicon.com>
Subject: [PATCH] thermal/drivers/hisi: disable multi alarm support for hi3660 SoC
Date: Wed, 18 Oct 2017 17:15:50 +0800
Message-ID: <1508318150-108444-1-git-send-email-kevin.wangtao@hisilicon.com>
References: <20171017043941.GE7954@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:8937 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934204AbdJRJXr (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Wed, 18 Oct 2017 05:23:47 -0400
In-Reply-To: <20171017043941.GE7954@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: daniel.lezcano@linaro.org, edubezval@gmail.com
Cc: rui.zhang@intel.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, sunzhaosheng@hisilicon.com, gengyanping@hisilicon.com, Kevin Wangtao <kevin.wangtao@linaro.org>

From: Kevin Wangtao <kevin.wangtao@linaro.org>

multi alarm interrupt forced a re-trigger of power_allocator_throttle
which changes the PID's actual sampling rate, this isn't optimal for
IPA, it is best to disable multi alarm support now and sort out this
issue later.

Signed-off-by: Kevin Wangtao <kevin.wangtao@linaro.org>
---
 drivers/thermal/hisi_thermal.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/thermal/hisi_thermal.c b/drivers/thermal/hisi_thermal.c
index 133238a..3b74c12 100644
--- a/drivers/thermal/hisi_thermal.c
+++ b/drivers/thermal/hisi_thermal.c
@@ -360,7 +360,6 @@ static int hi3660_thermal_enable_sensor(struct hisi_thermal_data *data)
 
 	/* set interrupt threshold */
 	value = hi3660_thermal_temp_to_step(sensor->thres_temp[0]);
-	value |= hi3660_thermal_temp_to_step(sensor->thres_temp[1]) << 10;
 	hi3660_thermal_alarm_set(data->regs, sensor->id, value);
 
 	/* enable interrupt */
-- 
2.8.1
