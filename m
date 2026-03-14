Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B5D269CE6
	for <linux-pm@vger.kernel.org>; Sat, 14 Mar 2026 01:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773450341; cv=none; b=dOpgKJlix71kKd+DB3efKHc/zMOW8I1EdrCzNo0SJolgEpm53ur6yX0dNeU4+ic1fW2AdwDC0AolA5X+Ei+jB/B9CzxgDLlz2RMR0VrPcJI/Tl3GqYvZvYT0dPK7pZP4jYa6vK+jtgH8B9c6TWxL5pcI3K0b2gNYUSC4g3BMLm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773450341; c=relaxed/simple;
	bh=U5owSX045Ib0ahybg1me7g+qoWpff+IWRo4y6Hv88vU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ih+1LtbJ1rqcO122sEZO23DneRmrpc9pmm5oppD2Bn4fKMsFGxGvAIzkGm8Q4ZOuhpxLA9HWVZ/VTDcWWS4seWDXwCxpYSESUH7IRpZT1TGHIjCPfOkdrk6jNt8CXrSTm1rb2TYTlm4KK1NWreBDThxzhzF+g/9mOiOqnU6UHrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+TlrZy+; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+TlrZy+"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-439d8dc4ae4so2893066f8f.2
        for <linux-pm@vger.kernel.org>; Fri, 13 Mar 2026 18:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773450339; x=1774055139; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fflG4TjEG/VcWRgaf7Cfa5vhuhGA88Qlq712W7KoR88=;
        b=P+TlrZy+GLDArdUWYw92xXv3myzp/rURD+mL+itUpk9CCqzuXf2ISlB2imV6dXtm2a
         7Tu1/XEAc0u8q6lW7o2eG1guSRYr7CP9bRdd8nESt9UCkurRJydap2oo70gahrhUi81o
         kziP7eSUYBwsaUHPrABFBuvRAWw2YJOvn3aUn4yNWuj6DhQ3xTFz/8J+OUK3Fftzm+iS
         GuWp0naKpydF/rFJLnflbNmoEC3aY+0UCU5HGlrVwcbVTFNUpJF30t/FbJyS5K/jWDOW
         lxyvo6ZkxPqWAp5znnN0N3sq2s8GBaUyC0z92ryWaBRbsqurVAt9QSe0EtTLzcxtb3zn
         zA7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773450339; x=1774055139;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fflG4TjEG/VcWRgaf7Cfa5vhuhGA88Qlq712W7KoR88=;
        b=Cr9HknrDkBPzpx1t0iIOefFnkA4H+6x4Ty1GfJQmOavaqxrft01VtH7MTG/VkMeJIf
         LzQv6MC8diLraPxOKUPdwmR9yW2S+8GuyRGRPoGvdbT/WmlLszlYa5inYs4RFRztqaOd
         6ou8IVPDlx5g/CyTx2y870i6AACHk7eZbIUGnknrnZPgRe39hwWalEtj0X4n0mpru5Cg
         sPdww9t4NF+g8OenNyVU4QroAO4jpW+Gs1vuoJOBdC0J504krOppHm4tTc7clcC/zXN5
         xJnQQ8VXTdH28F7xfBVjKQ169xo6Ltva/v2oofKHwhzCL7i6OLl+mEsoY0BvgkLrUvqF
         hVIA==
X-Forwarded-Encrypted: i=1; AJvYcCX+QDe/erKKsDh4/JBS6E+1JDquLmhhxw1kijQq1Q7vwrtzAicQqIPvU9aPxkeRKygv3U2uFubIDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxPlQ4+XcVituwySQLBDvbBMGuZRU3yr5zYAmGDUIXnylbzgDHD
	hYMfwktwGRT9HN4Tm3JS7YtQ/Qi2PUlrnE3lZLEa+mta3ZKECNba91M=
X-Gm-Gg: ATEYQzwPu09q5JrIojP4G3w4tp6GlxzwDoWkeHB+OXugAOV9XARqpqMVYJ+lV4+xGk6
	a2C4FIPT/NsTfUD9ToxA14Kwk7YuwgTUYWmvPrzlsp13DLzH8iHFK7zmfu3WmQaZtR7nTrPjzgV
	Chsjznv6f3sVuKVtghQh1pr62QaCjhN7JzAA3koRsZGo4zXX+cVb6ICsK22UsFVcNsL9acycbbX
	AO84pYsZzuEAEeB3sA0t7ohN+xvRtZj/CvqvxcIsWjZ14UEgszYRzJPbesJ8+PV2CDyOkDLjvTF
	vnHzFzB5XC053Zu3GXDO7gLom373DJRVIcSpplcZpKrtd6Xi9iOa0IiN7dstRO7hRCI+hpnfWS4
	xYahBeZOTCk/GeKrYfjrYX7siNUABKFTfYVBDP8L/LNYdIxGl4E3I7dKH+QpEWSMP/L6PVBWDtV
	fwiAwcnlmQQ/fKjohwF8tRjS29EBWfioFc9IaSiy+k4qqRpP7xGKg5x150zlva6PxtcrETSNqnW
	daFplW+/DUKiTgf6uV1z2K0elOFE7Q1PjKFR/YgAJfXpE7t6ldFEGXF08dyG5hKlGVswLMpJg94
	mP1FZcd8iz0AfrA=
X-Received: by 2002:a5d:5849:0:b0:439:ca1f:3929 with SMTP id ffacd0b85a97d-43a04dc0e02mr9324311f8f.48.1773450338480;
        Fri, 13 Mar 2026 18:05:38 -0700 (PDT)
Received: from sissix.lzampier.com (92.40.172.137.threembb.co.uk. [92.40.172.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43a03cfd18fsm13059963f8f.36.2026.03.13.18.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 18:05:37 -0700 (PDT)
From: Lucas Zampieri <lcasmz54@gmail.com>
To: linux-input@vger.kernel.org
Cc: Lucas Zampieri <lcasmz54@gmail.com>,
	linux-kernel@vger.kernel.org,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	Sebastian Reichel <sre@kernel.org>,
	Bastien Nocera <hadess@hadess.net>,
	linux-pm@vger.kernel.org
Subject: [PATCH v7 1/3] HID: input: Convert battery code to devm_*
Date: Sat, 14 Mar 2026 01:05:28 +0000
Message-ID: <20260314010533.110278-2-lcasmz54@gmail.com>
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

Convert the HID battery code to use devm_* managed resource APIs for
the power_supply_desc allocation, battery name string, and power supply
registration.

The error path uses devm_kfree() to clean up allocated memory if
devm_power_supply_register() fails, preventing memory waste on repeated
setup attempts. The hidinput_cleanup_battery() function is removed as
devm handles cleanup automatically.

Signed-off-by: Lucas Zampieri <lcasmz54@gmail.com>
---
 drivers/hid/hid-input.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 395138372..7e0f971ef 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -526,13 +526,13 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	if (quirks & HID_BATTERY_QUIRK_IGNORE)
 		return 0;
 
-	psy_desc = kzalloc_obj(*psy_desc);
+	psy_desc = devm_kzalloc(&dev->dev, sizeof(*psy_desc), GFP_KERNEL);
 	if (!psy_desc)
 		return -ENOMEM;
 
-	psy_desc->name = kasprintf(GFP_KERNEL, "hid-%s-battery",
-				   strlen(dev->uniq) ?
-					dev->uniq : dev_name(&dev->dev));
+	psy_desc->name = devm_kasprintf(&dev->dev, GFP_KERNEL, "hid-%s-battery",
+					strlen(dev->uniq) ?
+						dev->uniq : dev_name(&dev->dev));
 	if (!psy_desc->name) {
 		error = -ENOMEM;
 		goto err_free_mem;
@@ -574,7 +574,7 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 
 	dev->battery_present = (quirks & HID_BATTERY_QUIRK_DYNAMIC) ? false : true;
 
-	dev->battery = power_supply_register(&dev->dev, psy_desc, &psy_cfg);
+	dev->battery = devm_power_supply_register(&dev->dev, psy_desc, &psy_cfg);
 	if (IS_ERR(dev->battery)) {
 		error = PTR_ERR(dev->battery);
 		hid_warn(dev, "can't register power supply: %d\n", error);
@@ -585,27 +585,13 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	return 0;
 
 err_free_name:
-	kfree(psy_desc->name);
+	devm_kfree(&dev->dev, psy_desc->name);
 err_free_mem:
-	kfree(psy_desc);
+	devm_kfree(&dev->dev, psy_desc);
 	dev->battery = NULL;
 	return error;
 }
 
-static void hidinput_cleanup_battery(struct hid_device *dev)
-{
-	const struct power_supply_desc *psy_desc;
-
-	if (!dev->battery)
-		return;
-
-	psy_desc = dev->battery->desc;
-	power_supply_unregister(dev->battery);
-	kfree(psy_desc->name);
-	kfree(psy_desc);
-	dev->battery = NULL;
-}
-
 static bool hidinput_update_battery_charge_status(struct hid_device *dev,
 						  unsigned int usage, int value)
 {
@@ -660,10 +646,6 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	return 0;
 }
 
-static void hidinput_cleanup_battery(struct hid_device *dev)
-{
-}
-
 static void hidinput_update_battery(struct hid_device *dev, unsigned int usage,
 				    int value)
 {
@@ -2393,8 +2375,6 @@ void hidinput_disconnect(struct hid_device *hid)
 {
 	struct hid_input *hidinput, *next;
 
-	hidinput_cleanup_battery(hid);
-
 	list_for_each_entry_safe(hidinput, next, &hid->inputs, list) {
 		list_del(&hidinput->list);
 		if (hidinput->registered)
-- 
2.53.0

