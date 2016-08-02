From: Baole Ni <baolex.ni@intel.com>
Subject: [PATCH 0131/1285] Replace numeric parameter like 0444 with macro
Date: Tue,  2 Aug 2016 18:43:00 +0800
Message-ID: <20160802104300.22482-1-baolex.ni@intel.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, kyungmin.park@samsung.com, davem@davemloft.net, hpa@zytor.com, x86@kernel.org
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, chuansheng.liu@intel.com, baolex.ni@intel.com, peter@korsgaard.com, lee.jones@linaro.org
List-Id: linux-pm@vger.kernel.org

I find that the developers often just specified the numeric value
when calling a macro which is defined with a parameter for access permission.
As we know, these numeric value for access permission have had the corresponding macro,
and that using macro can improve the robustness and readability of the code,
thus, I suggest replacing the numeric parameter with the macro.

Signed-off-by: Chuansheng Liu <chuansheng.liu@intel.com>
Signed-off-by: Baole Ni <baolex.ni@intel.com>
---
 drivers/devfreq/governor_userspace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/devfreq/governor_userspace.c b/drivers/devfreq/governor_userspace.c
index 35de6e8..07e3d4b 100644
--- a/drivers/devfreq/governor_userspace.c
+++ b/drivers/devfreq/governor_userspace.c
@@ -82,7 +82,7 @@ static ssize_t show_freq(struct device *dev, struct device_attribute *attr,
 	return err;
 }
 
-static DEVICE_ATTR(set_freq, 0644, show_freq, store_freq);
+static DEVICE_ATTR(set_freq, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH, show_freq, store_freq);
 static struct attribute *dev_entries[] = {
 	&dev_attr_set_freq.attr,
 	NULL,
-- 
2.9.2
