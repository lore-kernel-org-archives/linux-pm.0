Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01845371051
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 16:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774800861; cv=none; b=i1h+o1Qi9pUiT7DnwHSkN/GFwXa8NdrjxekIYzpb38/gA6CpF+LWqQHSgiJoP1wUiE9rxy8NcRazsL3pYB0yms33CtoEZe771ML3PUeaS+dvVeTlmrcw62pMVfbhL862wTvEP7TZjmOD+NR9G/o91d7M2QSSfPmDPGQjKkouvjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774800861; c=relaxed/simple;
	bh=idD9jv7uFW521itEPBe4KyylCkWc7f46VoJ7nLJFmS8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=h7HX4x9VW2gIvYO10WXFAEqYBhZGbVrMsqDo+/nlDFP2dqfYNUO/D0SB3VXyr/NXIJDNpqwWCC94OZ/WQ9Va+qZI0vdy6H4grhIIB7XmsYr6CWKrad7i2UxuSCaKzps0TQyWzd4+FBlRmKWuiFlgogsBBVf9r5bs17gEuw3zOJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VJCDj2ro; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VJCDj2ro"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-43b88b7ca76so3078806f8f.3
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 09:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774800857; x=1775405657; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV1NVYu2CUk772hs5pUuIWfRYtmEoiUvAReCjlabyeY=;
        b=VJCDj2roUoflIBITOnWHn8f7qRRTzNDbgtA7mcLTxMmULV6Xs0wBMlT+g27wr1jA7u
         PFMEW5pkMDA9cHEKcTnFD+smZTA5ZdS22o2Hv5BMhpy6q1HWAOeueeoS4HvEnmZgtSqu
         3mm8uN4mKI4oGq3oI7OaHZrjAbA1p13qUGm6758hcyzqSZ570LiitC1+RId3CS92f8Un
         fv6zPoMG0Fd5LnGDtmem3DGVPsqRI0+3gxsmFVbXGEEBXq/84LpoQlUzhzXiSZDEgjRI
         JTY0qcOblSU5M+4foxbPuGgq1UaX3/KdK3m1AlblEopmxNsoVxdsMt/Gp3x0F5bhUhXe
         S+hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774800857; x=1775405657;
        h=content-transfer-encoding:cc:to:subject:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sV1NVYu2CUk772hs5pUuIWfRYtmEoiUvAReCjlabyeY=;
        b=beQV0NkVL1qDao9s0a3r4+6Cf6qijlldKukWyvZLYjagZX+hlexyG6NyyKXsg8Qj0p
         4kwnCOv88LIVMSm6L3RxQEcD9hiXCDYaUabHohdgNQe1POmkV9t+9AM1AT8gonba8yLw
         EHGe9ObTXf7lI/WZGxPeHvD4pYuURCJn++xm9HHfmIs2VxS8mu4cF+eCuGMjqAWIkAyS
         cUypIcSTeG8519ilrfD4T9PYhyNsY5oPkU50iM4bVCvPObl31M9vXv0o3NO2fsMnkhcp
         8v9MsIcXX7QcSwsI+Bkd7NanB4g44RUAX2IQ5jwcVusqLUBYFEtQf6gcXuLSYIfKHhDs
         ZQ+g==
X-Gm-Message-State: AOJu0Yz3IxWJZCQoiU9waVVioqCsQrwFiiP32D5T5lEqNZBAylfjHRZe
	E/W0krBkl+2T5aee6qVmuJrltrY7N8UNySblijTAmKQonhJpmJILeyV7
X-Gm-Gg: ATEYQzwHrGvNFB07wMoHtHfu8xAfE4TKZ9vtm/0trppJ3gcJ2mHG+XShHSZRkyG211K
	rJML5hs5NVV+hcxVXVviioYRxfaknyDbr9nJW1g4xh9GrD9VS/qtCOInr62/Fv4LYBpuTO0LO7h
	SDbIb+LWHIQ01EDejnYSzrzRIfVvEo6SqqXqzuhoXcWL4qw8e8riZ2B66OuwqD5JjLeDbUtsR6B
	JdKMxyKG0K4MvZTopY2nYy+pvXgMUa4YCJEinLvtKRphk9ilkyUzXx60UESwnxxykF4heEOW1ch
	2WnrDezabw3/wbrqEjdCgANPIMEwmJaxET+aiImRGiW14XjfwacxpAL+0RnCfmzQnVKAcTjV+SQ
	bFGm6mjm2A8pUV40USEj4vpHCD5x9qepSwC9Gp56QUcJTvy4XdcFFhIvlFVFORAo4zfYCpowOIn
	0Dg+wce7214EXIN+gjERk/Z8Xh7rU729y/lmQagxRtQA1GxvJbuxPSP1na/KQ4tPFidX8RlIWkx
	Pf6BJMaWmxZqalrLl6LS/SNhQvwzo6f0PodI1zSJael6lgA6Mk4fC3MLPM+o2X8/g==
X-Received: by 2002:a05:6000:18a3:b0:43c:fe66:43fb with SMTP id ffacd0b85a97d-43cfe66466emr1830837f8f.17.1774800856677;
        Sun, 29 Mar 2026 09:14:16 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f09:ff00:e94a:abd6:53f0:1fe4? (p200300ea8f09ff00e94aabd653f01fe4.dip0.t-ipconnect.de. [2003:ea:8f09:ff00:e94a:abd6:53f0:1fe4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf1db08e6sm20250282f8f.0.2026.03.29.09.14.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 09:14:16 -0700 (PDT)
Message-ID: <0fe1b679-ab28-4505-b0db-14e7ac3ba749@gmail.com>
Date: Sun, 29 Mar 2026 18:14:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Subject: [PATCH] PM / wakeup: Allocate class wakeup_class statically
To: "Rafael J. Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
 Len Brown <lenb@kernel.org>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Danilo Krummrich <dakr@kernel.org>
Cc: Linux PM <linux-pm@vger.kernel.org>, driver-core@lists.linux.dev
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Allocating wakeup_class statically avoids a little runtime overhead.
Define groups and device release function as part of the class, so that
we don't have to repeat this for each class device.
Whilst at it, constify wakeup_source_attrs[].

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/base/power/wakeup_stats.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/base/power/wakeup_stats.c b/drivers/base/power/wakeup_stats.c
index 308f8bde9..72beb8fce 100644
--- a/drivers/base/power/wakeup_stats.c
+++ b/drivers/base/power/wakeup_stats.c
@@ -18,8 +18,6 @@
 
 #include "power.h"
 
-static struct class *wakeup_class;
-
 #define wakeup_attr(_name)						\
 static ssize_t _name##_show(struct device *dev,				\
 			    struct device_attribute *attr, char *buf)	\
@@ -114,7 +112,7 @@ static ssize_t prevent_suspend_time_ms_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(prevent_suspend_time_ms);
 
-static struct attribute *wakeup_source_attrs[] = {
+static const struct attribute *const wakeup_source_attrs[] = {
 	&dev_attr_name.attr,
 	&dev_attr_active_count.attr,
 	&dev_attr_event_count.attr,
@@ -135,6 +133,12 @@ static void device_create_release(struct device *dev)
 	kfree(dev);
 }
 
+static const struct class wakeup_class = {
+	.name = "wakeup",
+	.dev_release = device_create_release,
+	.dev_groups = wakeup_source_groups,
+};
+
 static struct device *wakeup_source_device_create(struct device *parent,
 						  struct wakeup_source *ws)
 {
@@ -149,10 +153,8 @@ static struct device *wakeup_source_device_create(struct device *parent,
 
 	device_initialize(dev);
 	dev->devt = MKDEV(0, 0);
-	dev->class = wakeup_class;
+	dev->class = &wakeup_class;
 	dev->parent = parent;
-	dev->groups = wakeup_source_groups;
-	dev->release = device_create_release;
 	dev_set_drvdata(dev, ws);
 	device_set_pm_not_required(dev);
 
@@ -212,8 +214,6 @@ void wakeup_source_sysfs_remove(struct wakeup_source *ws)
 
 static int __init wakeup_sources_sysfs_init(void)
 {
-	wakeup_class = class_create("wakeup");
-
-	return PTR_ERR_OR_ZERO(wakeup_class);
+	return class_register(&wakeup_class);
 }
 postcore_initcall(wakeup_sources_sysfs_init);
-- 
2.53.0

