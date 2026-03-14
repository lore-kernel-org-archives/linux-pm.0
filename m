Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7CE12D46B2
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773450344; cv=none; b=SGNSq+4ES2KYfnj7411y+BcP4m2wFlZ0on8LNc12bPuC/zmC2dFe3ABXpVNKAqMKPf3zeQ/NE6f+xZoxSY/Gum12ALksM0m9f6yIrBvSnHmeDz0TWHGfufIeBkbPOQK8tGdsyLCQ6VUX76Lb0zkbMpNfNGyHlFuPRHBY9wpX5wY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773450344; c=relaxed/simple;
	bh=5UruTDQYwRhP8yhzakmYIDCojVLLfICF8nWe8oykZsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZI5cbs3dBWfHGDvtm0DXdMvhKaRcMCGESIMWU/v70Uim1iUVZk5o6UVbYYc8TEoA5t8k3YiPnaXBr8fMOOfhZSg77ctw8x3iTRgOHcENJPljN5XAhvfESjxbUDmlTDvYq+lvCLvJ709yJzpEyLFpfednmExfv3Dc7FpF8V+y2cM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B+bls5o6; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B+bls5o6"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439ce3605ecso2128298f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 18:05:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773450341; x=1774055141; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pPTsETiep3NOBpBHAgOsX9uFP2vJQ7HjGOgXPWAlTNU=;
        b=B+bls5o69SBh1RyM72tpLB/isfmTFWYJl2O/0vJjqxRN8oVGal2+szUQ10tJmvRf2D
         NJLRTIQYKzDFJvonPENKrfU82U22Paja1WHT1TgjRio3WxBZEpJ8e+aGHqbamr1Y95df
         JIDbh1+VIBigH4FJo9Y2PeB1ZE3LMesjEC3drbEkNqzezM5SYydMjpbwPAYNoZ7exVcl
         SJgOa2mTbY7FBU5xedBV8kuY/yXCOuxLalA7qKqqrM7xVJ4EjpyF+MznRsTzQDNh1B60
         83Q+5n3CGxscmq+N0+5IKrvwf8muLIGBFFJD3VpfqrLUU8PYZennPHjqeoq76JUwU40a
         Jyeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773450341; x=1774055141;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pPTsETiep3NOBpBHAgOsX9uFP2vJQ7HjGOgXPWAlTNU=;
        b=b/dJ8ckHDB7MXSbtd0lEHU957Gk3pHIkfoxXoszZeqsBCUDGzlHYtwQwyp/DDer8eB
         /5ORVtrqkbdF7Lfk3U+9NQsRUsmXqpZk8OdL6po+YFp67juAe+ENYqTj7M7gMRtujgIN
         +ecWLFqSdAP/ikbAhKOIAa2CrWrxgKgKMLuloiWGng6N/cYpuOnV00PqSM25OnZ4seVC
         Hdr+k1tQhHUknDvk1xqCkRh/lEU+2ni7ADpznxM2bCEzBKaEKVrgrG9Pk6xJGKBmLISZ
         jAiC5gxDdYK8rR6ub3go3Gpz3Q46FIFMUx9X+20DpiysMTjPKlLz3OkoBAL4WDcLQ7v0
         SS8g==
X-Forwarded-Encrypted: i=1; AJvYcCXHouem85Jp6z5/9IaeMpORCmiZKLm2fn9JFfVLQ7qPyZBqIZhycJMDviJON7CHQo+UvVpZoaxjmQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVMYg2doTgBvklti+BtGZQ4G9Vdt5q+xzGTfCN0j47adO8Cf+n
	d/5AIM23PNOnF2pfkTv0LNH/YL/38La9W9H3grU8MhjN98c9K748B7I=
X-Gm-Gg: ATEYQzy2phf/EdRitaCJgKhOdlQDuXMOsWS1/tv8AaWdQVicv7EtfVreleG5wvqY3cv
	HOfm0+ln5xJZehz6JhGW+bw52kzAO/d3yg0gi6zIOyv0EvEXFVZyQoUf9bIRv3qOVjkL9zkMYo4
	azxxLLR4v3Nh8Y/Ewo+rzXSn8708e1G6W6E/MkGK0E0LT3X9J71o7Px+QzmF7h8JzYUSuxIH1pi
	CYg6/Dsd9UCye3ZuMi1sENSwbzCVxQB/XlqKLp5nE4adNVk663TkZUKGZ09T023YlxlsXdku7FD
	C03qNWlKlNXaB5AfcGEDk9EfqCQYHlGK8s/5uCk8JuCAivcL5pDzmlMTaHvkQnag5T5tZZt+5XC
	qbBtsDon0er6in+l+qKtVoONy2Q/0WKs2vcgAAjc/ePhMDcNlSUMFNytG43B+tU/5WQKG5DlgBY
	XC51TdQqljrru1mE9vvQZDaEISVpAGp2Z6MX1zj7A94hCDWdFwAZHNF4p83CDEJobc0fHEb0xPY
	kuMii3KZTSeMDP3Scd+mvxppj/obeoSeiEPFkT4vXoM/9TcMxORi1t2XLUBsyuQoonnDrgp9RW4
	JOArxTGLwgZ+aKU=
X-Received: by 2002:a05:6000:4283:b0:439:df17:b037 with SMTP id ffacd0b85a97d-43a04d780f9mr9727413f8f.12.1773450341141;
        Fri, 13 Mar 2026 18:05:41 -0700 (PDT)
Received: from sissix.lzampier.com (92.40.172.137.threembb.co.uk. [92.40.172.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a03cfd18fsm13059963f8f.36.2026.03.13.18.05.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 18:05:40 -0700 (PDT)
From: Lucas Zampieri <lcasmz54@gmail.com>
To: linux-input@vger.kernel.org
Cc: Lucas Zampieri <lcasmz54@gmail.com>,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH v7 3/3] HID: input: Add support for multiple batteries per device
Date: Sat, 14 Mar 2026 01:05:30 +0000
Message-ID: <20260314010533.110278-4-lcasmz54@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260314010533.110278-1-lcasmz54@gmail.com>
References: <20260314010533.110278-1-lcasmz54@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for HID devices that report multiple batteries, each
identified by its report ID.

The hid_device->battery pointer is replaced with a batteries list.
Batteries are named using the pattern hid-{uniq}-battery-{report_id}.
The hid_get_battery() helper returns the first battery in the list for
backwards compatibility with single-battery drivers.

Signed-off-by: Lucas Zampieri <lcasmz54@gmail.com>
---
 drivers/hid/hid-core.c  |  4 ++++
 drivers/hid/hid-input.c | 44 ++++++++++++++++++++++++++++-------------
 include/linux/hid.h     | 11 ++++++++---
 3 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index da57cbf0a..58a31ee07 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -2995,6 +2995,10 @@ struct hid_device *hid_allocate_device(void)
 	mutex_init(&hdev->ll_open_lock);
 	kref_init(&hdev->ref);
 
+#ifdef CONFIG_HID_BATTERY_STRENGTH
+	INIT_LIST_HEAD(&hdev->batteries);
+#endif
+
 	ret = hid_bpf_device_init(hdev);
 	if (ret)
 		goto out_err;
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index b5d34658b..8fff185fe 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -507,6 +507,18 @@ static int hidinput_get_battery_property(struct power_supply *psy,
 	return ret;
 }
 
+static struct hid_battery *hidinput_find_battery(struct hid_device *dev,
+						 int report_id)
+{
+	struct hid_battery *bat;
+
+	list_for_each_entry(bat, &dev->batteries, list) {
+		if (bat->report_id == report_id)
+			return bat;
+	}
+	return NULL;
+}
+
 static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 				  struct hid_field *field, bool is_percentage)
 {
@@ -517,13 +529,15 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	s32 min, max;
 	int error;
 
-	if (dev->battery)
-		return 0;	/* already initialized? */
+	/* Check if battery for this report ID already exists */
+	if (hidinput_find_battery(dev, field->report->id))
+		return 0;
 
 	quirks = find_battery_quirk(dev);
 
-	hid_dbg(dev, "device %x:%x:%x %d quirks %d\n",
-		dev->bus, dev->vendor, dev->product, dev->version, quirks);
+	hid_dbg(dev, "device %x:%x:%x %d quirks %d report_id %d\n",
+		dev->bus, dev->vendor, dev->product, dev->version, quirks,
+		field->report->id);
 
 	if (quirks & HID_BATTERY_QUIRK_IGNORE)
 		return 0;
@@ -538,9 +552,11 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 		goto err_free_bat;
 	}
 
-	psy_desc->name = devm_kasprintf(&dev->dev, GFP_KERNEL, "hid-%s-battery",
+	psy_desc->name = devm_kasprintf(&dev->dev, GFP_KERNEL,
+					"hid-%s-battery-%d",
 					strlen(dev->uniq) ?
-						dev->uniq : dev_name(&dev->dev));
+						dev->uniq : dev_name(&dev->dev),
+					field->report->id);
 	if (!psy_desc->name) {
 		error = -ENOMEM;
 		goto err_free_desc;
@@ -593,7 +609,7 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	}
 
 	power_supply_powers(bat->ps, &dev->dev);
-	dev->battery = bat;
+	list_add_tail(&bat->list, &dev->batteries);
 	return 0;
 
 err_free_name:
@@ -602,7 +618,6 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	devm_kfree(&dev->dev, psy_desc);
 err_free_bat:
 	devm_kfree(&dev->dev, bat);
-	dev->battery = NULL;
 	return error;
 }
 
@@ -620,12 +635,13 @@ static bool hidinput_update_battery_charge_status(struct hid_battery *bat,
 	return false;
 }
 
-static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
-				    int value)
+static void hidinput_update_battery(struct hid_device *dev, int report_id,
+				    unsigned int usage, int value)
 {
-	struct hid_battery *bat = dev->battery;
+	struct hid_battery *bat;
 	int capacity;
 
+	bat = hidinput_find_battery(dev, report_id);
 	if (!bat)
 		return;
 
@@ -661,8 +677,8 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	return 0;
 }
 
-static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
-				    int value)
+static void hidinput_update_battery(struct hid_device *dev, int report_id,
+				    unsigned int usage, int value)
 {
 }
 #endif	/* CONFIG_HID_BATTERY_STRENGTH */
@@ -1546,7 +1562,7 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		return;
 
 	if (usage->type == EV_PWR) {
-		hidinput_update_battery(hid, usage->hid, value);
+		hidinput_update_battery(hid, report->id, usage->hid, value);
 		return;
 	}
 
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 71beff003..442a80d79 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -648,6 +648,7 @@ enum hid_battery_status {
  * @avoid_query: if true, avoid querying battery (e.g., for stylus)
  * @present: if true, battery is present (may be dynamic)
  * @ratelimit_time: rate limiting for battery reports
+ * @list: list node for linking into hid_device's battery list
  */
 struct hid_battery {
 	struct hid_device *dev;
@@ -662,6 +663,7 @@ struct hid_battery {
 	bool avoid_query;
 	bool present;
 	ktime_t ratelimit_time;
+	struct list_head list;
 };
 
 struct hid_driver;
@@ -700,9 +702,10 @@ struct hid_device {
 #ifdef CONFIG_HID_BATTERY_STRENGTH
 	/*
 	 * Power supply information for HID devices which report
-	 * battery strength. battery is non-NULL if successfully registered.
+	 * battery strength. Each battery is tracked separately in the
+	 * batteries list.
 	 */
-	struct hid_battery *battery;
+	struct list_head batteries;
 #endif
 
 	unsigned long status;						/* see STAT flags above */
@@ -767,7 +770,9 @@ static inline void hid_set_drvdata(struct hid_device *hdev, void *data)
 #ifdef CONFIG_HID_BATTERY_STRENGTH
 static inline struct hid_battery *hid_get_battery(struct hid_device *hdev)
 {
-	return hdev->battery;
+	if (list_empty(&hdev->batteries))
+		return NULL;
+	return list_first_entry(&hdev->batteries, struct hid_battery, list);
 }
 #endif
 
-- 
2.53.0

