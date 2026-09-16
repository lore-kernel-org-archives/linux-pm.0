Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86CDD3EEAE1
	for <linux-pm@vger.kernel.org>; Wed, 16 Sep 2026 06:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789541374; cv=none; b=NA5zc+bWYXiRhXR1vPEvT9Sxmzo0EoboKYdb8LYEFDwi+tVwsDysqVGb13SGAcn7U4M4zJVR/DoPNS2Y5qgb4Kz5cLnkLoASXfl30aJGCa4O+kPJQ8ibDjoHeLp36xjVUXOi0p/qH9jVWsxMRk8XEdwB9a+XqRj/Ubmg+nfq4wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789541374; c=relaxed/simple;
	bh=akLPT6yY8agmJBPovgfnlqb0xXWcyHVezTplJgD3ibo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DTsmKJl/kTT/tBlOT+09Qw916EK9Qja6fXqUYaBVoQewmPUV9wfXGEwZGHxLyzafMriPi46j4VG9ywnloHFC8QEdCNBXvtXNvK74CLPwIO31TxzVOAY/Na6+WzX9MI8/KBMe5PcWxY41q34KEySD1l4kjxHrWwFr6liWK648+jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AVs8+zBU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AVs8+zBU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B9901F00898;
	Wed, 16 Sep 2026 06:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789541371;
	bh=oFbIfXDDvMU5XnkjonxuUgoSYwbvS2sHSqQqACX3euU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=AVs8+zBUEOWMPqoqUM6cLERCh+6GP0lfB+fvmO6Qx81jnITwhMqhKAiOwmexEOmZK
	 /PHt89PlPfvxCmNIs+1wkPgNEcMALZ9BmGhgMkwZ4PK6KhNe4v+VvL6X6j++lTX1Oy
	 JEjimDNQRglgTeE77GcJ/AsYvRTxz+HvOt4aoRvgPd4TfSPJ4+hJRhEbsE0rrasj/6
	 rSXdhSAvBAkEJno/MAhYbXEW7JSRF5Fr5fqwJtmDnjfaTXCJIj+Cb4r1IPuJKe6+1e
	 plgeCDkU5XreUMWyNqSEQw/awAFicAtjq1MeutfqZY+wd42se9UG5HbF8m8KqibmuP
	 RtHSmOS7hmh0g==
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 08:49:26 +0200
Subject: [PATCH 04/15] power: supply: ab8500_fg: Drop nonexistent AB8505
 controls
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260916-ab8500-charging-v1-4-e986ed321cc6@kernel.org>
References: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
In-Reply-To: <20260916-ab8500-charging-v1-0-e986ed321cc6@kernel.org>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.14.3

The AB8505 RTC register map has no register at offset 0x15, but
the fuel-gauge driver initializes and exposes that offset as a
power-cut flag-time control. PcutCtlAndStatus bit 4, exposed as
powercut_flag, is reserved as well.

Remove both nonexistent controls and their internal configuration
field so the driver no longer accesses reserved hardware locations.

Assisted-by: LLM
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/power/supply/ab8500-bm.h     |  3 --
 drivers/power/supply/ab8500_bmdata.c |  1 -
 drivers/power/supply/ab8500_fg.c     | 85 ------------------------------------
 3 files changed, 89 deletions(-)

diff --git a/drivers/power/supply/ab8500-bm.h b/drivers/power/supply/ab8500-bm.h
index b73fccdc76d2..209744c77c3d 100644
--- a/drivers/power/supply/ab8500-bm.h
+++ b/drivers/power/supply/ab8500-bm.h
@@ -245,7 +245,6 @@ enum bup_vch_sel {
 #define AB8505_RTC_PCUT_CTL_STATUS_REG	0x12
 #define AB8505_RTC_PCUT_TIME_REG	0x13
 #define AB8505_RTC_PCUT_MAX_TIME_REG	0x14
-#define AB8505_RTC_PCUT_FLAG_TIME_REG	0x15
 #define AB8505_RTC_PCUT_RESTART_REG	0x16
 #define AB8505_RTC_PCUT_DEBOUNCE_REG	0x17
 
@@ -286,7 +285,6 @@ struct ab8500_fg;
  *				battery full while in maintenance, in per cent
  * @pcut_enable:			Enable power cut feature in ab8505
  * @pcut_max_time:		Max time threshold
- * @pcut_flag_time:		Flagtime threshold
  * @pcut_max_restart:		Max number of restarts
  * @pcut_debounce_time:		Sets battery debounce time
  */
@@ -307,7 +305,6 @@ struct ab8500_fg_parameters {
 	int maint_thres;
 	bool pcut_enable;
 	u8 pcut_max_time;
-	u8 pcut_flag_time;
 	u8 pcut_max_restart;
 	u8 pcut_debounce_time;
 };
diff --git a/drivers/power/supply/ab8500_bmdata.c b/drivers/power/supply/ab8500_bmdata.c
index 19ed52852804..d7fd2d313ff1 100644
--- a/drivers/power/supply/ab8500_bmdata.c
+++ b/drivers/power/supply/ab8500_bmdata.c
@@ -98,7 +98,6 @@ static const struct ab8500_fg_parameters fg = {
 	.user_cap_limit = 15,
 	.pcut_enable = 1,
 	.pcut_max_time = 127,
-	.pcut_flag_time = 112,
 	.pcut_max_restart = 15,
 	.pcut_debounce_time = 2,
 };
diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab8500_fg.c
index c5eaa32c4a2d..70e29c9e8108 100644
--- a/drivers/power/supply/ab8500_fg.c
+++ b/drivers/power/supply/ab8500_fg.c
@@ -2355,14 +2355,6 @@ static int ab8500_fg_init_hw_registers(struct ab8500_fg *di)
 			goto out;
 		}
 
-		ret = abx500_set_register_interruptible(di->dev, AB8500_RTC,
-			AB8505_RTC_PCUT_FLAG_TIME_REG, di->bm->fg_params->pcut_flag_time);
-
-		if (ret) {
-			dev_err(di->dev, "%s write failed AB8505_RTC_PCUT_FLAG_TIME_REG\n", __func__);
-			goto out;
-		}
-
 		ret = abx500_set_register_interruptible(di->dev, AB8500_RTC,
 			AB8505_RTC_PCUT_RESTART_REG, di->bm->fg_params->pcut_max_restart);
 
@@ -2569,56 +2561,6 @@ static int ab8500_fg_sysfs_init(struct ab8500_fg *di)
 	return ret;
 }
 
-static ssize_t ab8505_powercut_flagtime_read(struct device *dev,
-			     struct device_attribute *attr,
-			     char *buf)
-{
-	int ret;
-	u8 reg_value;
-	struct power_supply *psy = dev_to_psy(dev);
-	struct ab8500_fg *di = power_supply_get_drvdata(psy);
-
-	ret = abx500_get_register_interruptible(di->dev, AB8500_RTC,
-		AB8505_RTC_PCUT_FLAG_TIME_REG, &reg_value);
-
-	if (ret < 0) {
-		dev_err(dev, "Failed to read AB8505_RTC_PCUT_FLAG_TIME_REG\n");
-		goto fail;
-	}
-
-	return sysfs_emit(buf, "%d\n", (reg_value & 0x7F));
-
-fail:
-	return ret;
-}
-
-static ssize_t ab8505_powercut_flagtime_write(struct device *dev,
-				  struct device_attribute *attr,
-				  const char *buf, size_t count)
-{
-	int ret;
-	int reg_value;
-	struct power_supply *psy = dev_to_psy(dev);
-	struct ab8500_fg *di = power_supply_get_drvdata(psy);
-
-	if (kstrtoint(buf, 10, &reg_value))
-		goto fail;
-
-	if (reg_value > 0x7F) {
-		dev_err(dev, "Incorrect parameter, echo 0 (1.98s) - 127 (15.625ms) for flagtime\n");
-		goto fail;
-	}
-
-	ret = abx500_set_register_interruptible(di->dev, AB8500_RTC,
-		AB8505_RTC_PCUT_FLAG_TIME_REG, (u8)reg_value);
-
-	if (ret < 0)
-		dev_err(dev, "Failed to set AB8505_RTC_PCUT_FLAG_TIME_REG\n");
-
-fail:
-	return count;
-}
-
 static ssize_t ab8505_powercut_maxtime_read(struct device *dev,
 			     struct device_attribute *attr,
 			     char *buf)
@@ -2815,30 +2757,6 @@ static ssize_t ab8505_powercut_write(struct device *dev,
 	return count;
 }
 
-static ssize_t ab8505_powercut_flag_read(struct device *dev,
-					 struct device_attribute *attr,
-					 char *buf)
-{
-
-	int ret;
-	u8 reg_value;
-	struct power_supply *psy = dev_to_psy(dev);
-	struct ab8500_fg *di = power_supply_get_drvdata(psy);
-
-	ret = abx500_get_register_interruptible(di->dev, AB8500_RTC,
-						AB8505_RTC_PCUT_CTL_STATUS_REG,  &reg_value);
-
-	if (ret < 0) {
-		dev_err(dev, "Failed to read AB8505_RTC_PCUT_CTL_STATUS_REG\n");
-		goto fail;
-	}
-
-	return sysfs_emit(buf, "%d\n", ((reg_value & 0x10) >> 4));
-
-fail:
-	return ret;
-}
-
 static ssize_t ab8505_powercut_debounce_read(struct device *dev,
 					     struct device_attribute *attr,
 					     char *buf)
@@ -2913,8 +2831,6 @@ static ssize_t ab8505_powercut_enable_status_read(struct device *dev,
 }
 
 static struct device_attribute ab8505_fg_sysfs_psy_attrs[] = {
-	__ATTR(powercut_flagtime, (S_IRUGO | S_IWUSR | S_IWGRP),
-		ab8505_powercut_flagtime_read, ab8505_powercut_flagtime_write),
 	__ATTR(powercut_maxtime, (S_IRUGO | S_IWUSR | S_IWGRP),
 		ab8505_powercut_maxtime_read, ab8505_powercut_maxtime_write),
 	__ATTR(powercut_restart_max, (S_IRUGO | S_IWUSR | S_IWGRP),
@@ -2924,7 +2840,6 @@ static struct device_attribute ab8505_fg_sysfs_psy_attrs[] = {
 		ab8505_powercut_restart_counter_read, NULL),
 	__ATTR(powercut_enable, (S_IRUGO | S_IWUSR | S_IWGRP),
 		ab8505_powercut_read, ab8505_powercut_write),
-	__ATTR(powercut_flag, S_IRUGO, ab8505_powercut_flag_read, NULL),
 	__ATTR(powercut_debounce_time, (S_IRUGO | S_IWUSR | S_IWGRP),
 		ab8505_powercut_debounce_read, ab8505_powercut_debounce_write),
 	__ATTR(powercut_enable_status, S_IRUGO,

-- 
2.55.0

