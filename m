Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04482E7F2C
	for <linux-pm@vger.kernel.org>; Thu, 13 Aug 2026 00:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786581693; cv=none; b=T6STVy7esfxI/VzWNTZEdL1Ra13dMSvOwGPo/04VKPB7imzw7UUjeGaaWjGXZJAisvoXfom9dCtTiRGa8bHx3t+byY0FDIka/NmnvyV2JjUGpturGjVQU80QSXTSUIQSF+x5fL3lbpUCHrlpFfXJoD3hlCQGnkmnDXwsKlAkMCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786581693; c=relaxed/simple;
	bh=gra1sMSV6yYCMeejvMA5gVNI1Kptv4TlwEllYa3rQ1k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sNU+kLliKGjk/JNHCk7OsgqozUEivWOdd8soplOT5GF0++76tVJ48Cg2dM1x09T3mgZ5lWKWojnMoAW6e9S46N4PJk8EmNWtLKts74Xb9uRqeMGeh+9PVCBBdpy1ErhD5LjVvzPYaPn3Me7ULthGanMz+oLpVTjmDlHXGmZRJpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vl6GghzT; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vl6GghzT"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-ca00f126b7eso168864a12.2
        for <linux-pm@vger.kernel.org>; Wed, 12 Aug 2026 17:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786581691; x=1787186491; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OZfZJJ3ks18rL3wPJ75S3YpkxlVt9q0GrbTQIG0UeZg=;
        b=Vl6GghzT2evu/NUT5v80cHDoVh4AD01gKIimJt1EDgsvjoGR1bfYZE9M2qPAacu5QP
         1IJTuxX/FaDtj9x1SkVsUQkINSxzSiR4TGWyG+KCcLDz5YmRqENtNUiZ8YR/WfU1Q9HH
         oYU4+PIrDu0N0vccJX7Zp+RtYg4vVyy8C++DK3ckGvXNn9XaCu0A7HPE58Gjggd5KVjH
         XsqpIbgyfywaHGeF7StR2HzM6KNdgix7c5ZK43kzptvJWhLqVu9PJvZ2wyEi6DAmr/y+
         lbGkik7TXuHTriB8VADLmfHrxc4+a6aJJfefXcKzBJyfxxK1IrHP1k1sMjVCM2WHzKNQ
         UEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786581691; x=1787186491;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OZfZJJ3ks18rL3wPJ75S3YpkxlVt9q0GrbTQIG0UeZg=;
        b=hvr57mkIkoaTwP4bBDnbUD6J1WdExswVFMamQxnoneWnJikevTcOKK6e/PpIO26qfZ
         BWPwom8gH0n30QsxzUgei7kSMdXSb0HG20ay4YNkgpug/AvRzVtqqCH+OVewMucOKGeB
         BupBKsKwW8HyBxewnq61E28UF9q4NnJhU6u57nJy36yN5RaUQgaZVw2r73Fcw//W+VkY
         O20pM+rGpl3I3FLDxuMCgB/p4BTE+pm3vjwab4SpiQ1IieTHt5AF50bIY44MTiWPgtX5
         j8HQM7Pk3TuMHvTf9rssE+wfQwb8rIe6+Fk9bzadJH8nI9vbCjo8wrhJ6rVdXgKzooDb
         fQxA==
X-Gm-Message-State: AOJu0YzjkhLC931kT4A8/GU234L/z//SQrboddDr56kvvAeVr6so+yHQ
	OLGvEoSNCORN1HpirzXfO2tQDP4VsDA7BE06ESpmlM96EGtElrZR1KFB
X-Gm-Gg: AR+sD11VGfnMA0LXtXuJKNWpJ01mMYa6cY9d/IhwfeILqzNfuDZFMHomztmd933A4G9
	n6tyD1rAJBIQWmrsv5dU46WDJMOyCUiJronOWUH52IsWFiAiki+kVElO5+IMEyfLuyyt19lBXwl
	P2TvP1v+F3JfzDUuZELX8SZTYtHuFa4haTR/TLmzx50n5UwcGAbCx+ap0gKo3BhMOasRUYmwr4Q
	C/li8rx2Q4ZpUwTWehOAYtmUtt5SckS0l7C7EUZVzflkAtyGJU7vP8Q+f7D7KG8qyHwDKtkjo30
	i7gs1/Y3SlbmYp8paDqw/LOiJuMU8rAGpAImSNU/AhGnhtMAOTzZ09rSwOofkYcVO5xcRXWyB8W
	qvJnwiLszjvMbpctSPdKxb7TFnhADJEM4oe7LvxhhyhbIjukYKUOJC3tEBLV7hjCXmaEGiffCc5
	1QbXH2k9RCBy48N7vAMjciQ0Htmpx6XdCKeYcEmbafY6Vt/yKme3A8dPilVymEUcuJyNT+zkA2x
	LPuz5AQp99bL1bikx7aQ2XXi1ILWetihBwMgpcVcIADLjYhMLS3mTS/xV4ARA==
X-Received: by 2002:a05:6a00:2e04:b0:82f:2b0:2809 with SMTP id d2e1a72fcca58-84fc6c84f61mr1723057b3a.1.1786581690837;
        Wed, 12 Aug 2026 17:41:30 -0700 (PDT)
Received: from bloom.localdomain ([2604:3d09:178e:e100::6868])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84fc4565c6bsm207084b3a.3.2026.08.12.17.41.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 17:41:30 -0700 (PDT)
From: Ivy Lopez <skunkolee@gmail.com>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ivy Lopez <skunkolee@gmail.com>
Subject: [PATCH v2] power: supply: ds2760_battery: convert to devm-managed workqueue and pm_notifier
Date: Wed, 12 Aug 2026 18:41:12 -0600
Message-ID: <20260813004113.29943-1-skunkolee@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260808214458.201324-1-skunkolee@gmail.com>
References: <20260808214458.201324-1-skunkolee@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Following review feedback, convert the driver to use devm-managed
resources instead of manual cleanup in w1_ds2760_remove_slave():

- devm_alloc_ordered_workqueue() for the monitor workqueue
- devm_delayed_work_autocancel() for the monitor delayed work
- devm_add_action_or_reset() to unregister the pm_notifier

This removes the need for w1_ds2760_remove_slave() entirely, along
with the NULL checks it required to safely handle a partially
initialized di on an add_slave() failure path.

Fixes: bf4973553737 ("power: supply: ds2760_battery: merge ds2760 supply driver with its w1 slave companion")
Suggested-by: Sebastian Reichel <sre@kernel.org>
Signed-off-by: Ivy Lopez <skunkolee@gmail.com>
---
 drivers/power/supply/ds2760_battery.c | 54 +++++++++++----------------
 1 file changed, 21 insertions(+), 33 deletions(-)

diff --git a/drivers/power/supply/ds2760_battery.c b/drivers/power/supply/ds2760_battery.c
index 3c2433f6b5e9..901aaaf916c4 100644
--- a/drivers/power/supply/ds2760_battery.c
+++ b/drivers/power/supply/ds2760_battery.c
@@ -23,6 +23,7 @@
 #include <linux/param.h>
 #include <linux/jiffies.h>
 #include <linux/workqueue.h>
+#include <linux/devm-helpers.h>
 #include <linux/pm.h>
 #include <linux/slab.h>
 #include <linux/platform_device.h>
@@ -621,6 +622,11 @@ static int ds2760_pm_notifier(struct notifier_block *notifier,
 	return NOTIFY_DONE;
 }
 
+static void ds2760_battery_unregister_pm_notifier(void *notifier)
+{
+	unregister_pm_notifier(notifier);
+}
+
 static int w1_ds2760_add_slave(struct w1_slave *sl)
 {
 	struct power_supply_config psy_cfg = {};
@@ -631,10 +637,8 @@ static int w1_ds2760_add_slave(struct w1_slave *sl)
 	char status;
 
 	di = devm_kzalloc(dev, sizeof(*di), GFP_KERNEL);
-	if (!di) {
-		retval = -ENOMEM;
-		goto di_alloc_failed;
-	}
+	if (!di)
+		return -ENOMEM;
 
 	snprintf(name, sizeof(name), "ds2760-battery.%d", dev->id);
 
@@ -695,41 +699,26 @@ static int w1_ds2760_add_slave(struct w1_slave *sl)
 	di->bat = devm_power_supply_register(dev, &di->bat_desc, &psy_cfg);
 	if (IS_ERR(di->bat)) {
 		dev_err(di->dev, "failed to register battery\n");
-		retval = PTR_ERR(di->bat);
-		goto batt_failed;
+		return PTR_ERR(di->bat);
 	}
 
-	INIT_DELAYED_WORK(&di->monitor_work, ds2760_battery_work);
-	di->monitor_wqueue = alloc_ordered_workqueue(name, WQ_MEM_RECLAIM);
-	if (!di->monitor_wqueue) {
-		retval = -ESRCH;
-		goto workqueue_failed;
-	}
+	di->monitor_wqueue = devm_alloc_ordered_workqueue(dev, name, WQ_MEM_RECLAIM);
+	if (!di->monitor_wqueue)
+		return -ESRCH;
+
+	retval = devm_delayed_work_autocancel(dev, &di->monitor_work,
+						 ds2760_battery_work);
+	if (retval)
+		return retval;
+
 	queue_delayed_work(di->monitor_wqueue, &di->monitor_work, HZ * 1);
 
 	di->pm_notifier.notifier_call = ds2760_pm_notifier;
 	register_pm_notifier(&di->pm_notifier);
 
-	goto success;
-
-workqueue_failed:
-batt_failed:
-di_alloc_failed:
-success:
-	return retval;
-}
-
-static void w1_ds2760_remove_slave(struct w1_slave *sl)
-{
-	struct ds2760_device_info *di = sl->family_data;
-
-	if (!di)
-		return;
-
-	unregister_pm_notifier(&di->pm_notifier);
-	cancel_delayed_work_sync(&di->monitor_work);
-	if (di->monitor_wqueue)
-		destroy_workqueue(di->monitor_wqueue);
+	return devm_add_action_or_reset(dev,
+					   ds2760_battery_unregister_pm_notifier,
+					   &di->pm_notifier);
 }
 
 #ifdef CONFIG_OF
@@ -741,7 +730,6 @@ static const struct of_device_id w1_ds2760_of_ids[] = {
 
 static const struct w1_family_ops w1_ds2760_fops = {
 	.add_slave	= w1_ds2760_add_slave,
-	.remove_slave	= w1_ds2760_remove_slave,
 	.groups		= w1_ds2760_groups,
 };
 
-- 
2.55.0

