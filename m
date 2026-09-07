Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B37C408626
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 06:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763200; cv=none; b=bTPSGSjyI3HmCP44ekA7grEbmfc9XCya6EE7oApunGDq3QdUV7a7c+qhQ8oryYk77o1GK3SHEOIs5DjRd9I6+hpniUcfuAj9wjNYuXQKUl07xWU2gHORAKzLE+eTenRzgFERe/iSc30G6hzuPcvekDNxFOoyMVKQfZsWL5zq2co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763200; c=relaxed/simple;
	bh=qbYkVw5ZlLOmqC/yALZS/LvtnUt9HSZ5uJyAxidykJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q2zDayEN7dwgfPtkUd3kVxhHmvSgW7UrRL3xi9DD38OFdqi5NE1xhxal+SID4Ok25oZRoO0xkNKm00/IFgu22g/LnlJgtjM5Kp8fJJT+k2hY6gO4yRbsESHufQLWhcXZKoLsnqbHlkTK8nMtjXvPMEBx00kj5mJPwWXfDmN/cy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LH4ppR7B; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LH4ppR7B"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-395cf2535acso3352035a91.1
        for <linux-pm@vger.kernel.org>; Sun, 06 Sep 2026 23:39:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763198; x=1789367998; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ofZ9t07j1+4nY5D4sCxFgwBdyt3aoyCBOa165p4ZC9U=;
        b=LH4ppR7Ba04INMavr32P147337slXjWzwfUS+LHiTazTb8X8R7Qc0nwnKkAuIABBZb
         VApbSxQGFo5/tYnG3va5bmIrFNh4tKl4BrISCtLh9U3Lq029OLVrnDOS0bgbTrckxVks
         C6xDnpxM4PtYRjeZp91OPWUG8ocbqnh84qxo3sxFMnQfm/VSPYFx0RJrSFCMvm8F+JWX
         y3rSPKpzdF7T0kysVzGyzsTZqJM4/rfLDMz+s5g/k/1GbMONSNxN8QHGAlbYwK0sDGRT
         GLy0LMpHzjBCJNZ7zMjumDXD6e0QWaygvtidVSX5LKCWwhtKqZqRdvfB/yn6LtuL33a0
         Q7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763198; x=1789367998;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ofZ9t07j1+4nY5D4sCxFgwBdyt3aoyCBOa165p4ZC9U=;
        b=Xg2M3IgYtICvjvlOkRRpxHMS1zpSYc567k2+rTZ7JeYgZWQdS3B/GJtJnpe/mjmbod
         JXecnYLk9Io7u7skwZKogrYGBBiQkJWnH+5HZHtagalSACAu5S7w34qwHjumk2cR16K2
         lNopdjIFSv9Ccs721qUDOhduwPcXJ8LsyqEhDk/Ga7VOPlXI9PqTw79woIAAjrFi8Otm
         49ZILSQTvwhA4SH1T3IDhhhU5YhxCgA+yc0nhFnLfS+Y+gtwlby5Y2A5OtaoFsd+H56/
         DbIcveXNE9Iu36kHNxbFNuj0QbPNAi5A3lJg/XsW5MBIVUA7IlM2M88JYJN7tfUecMpY
         K1wA==
X-Gm-Message-State: AFuF++lziskUcsp+zKkz7ZFHQTmvBm7nTbc93cvCi42H5TbBmb2X4ajn
	x1nawOMtbgCQ3FAfqtgEVMrU9IxJzUqWM7VJk36NJnsS8wAsJHd5vLiJ
X-Gm-Gg: AYBFou10aL4gQnmkXr1Nv1bCEJYzNesFiS8kj4Jo0Yp7nmj7nbJ8cQ+CqCDvKpSD7JH
	kXZpJO4qSGXO9jQcLyVC2SIK5G7zexsWFuaaLgm8yr6GLY5Qtz9myh0bBSQe4M+YDFdsNlCf/d+
	NVVW3EjprPTqjh5uqLn01gyIj5MwOHcmwT81/m+Vv0X0DK8J+trRL2HzopQdwn2a1W1gYufNxxw
	8mSEcrHTHjFP30tuplzCVO3Y7uKlmIFepL8/bsdYrq2B4x/ZdQdJ6wsdgy9E5Q75re4QlaRLkPI
	4SyGXbHXrTJY7r+CysMzZT/V+5SEniAcPQtxWSkrW0/1hjan4G5PuT8qPUu5CLWHcQHw4/3T0uB
	7/uX62yUxQt8kcrqCa6MkivsSa26XcyPTmY5PDUjvXvPiQ2EKN7agNu0ayQiRZ+gjOR02YyAFRG
	lyGqZARFs1blgMcW04BHuNsxhR/HIg62frUDgbNURF6riWgAWlFtbzlgSVXIIp/yrbJuQ4Rne5B
	gyrg4WiEAMqNA==
X-Received: by 2002:a17:90b:2e46:b0:38f:a81:15b1 with SMTP id 98e67ed59e1d1-39b08653554mr33771219a91.19.1788763197553;
        Sun, 06 Sep 2026 23:39:57 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm25345322eec.19.2026.09.06.23.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:39:57 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] power: supply: fix typos in comments
Date: Mon,  7 Sep 2026 12:09:46 +0530
Message-ID: <20260907063947.34852-2-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260907063947.34852-1-hemanth.selam@gmail.com>
References: <20260907063947.34852-1-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments, reported by scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Only touches comments, no code
changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/power/supply/bq25890_charger.c  | 2 +-
 drivers/power/supply/charger-manager.c  | 2 +-
 drivers/power/supply/da9030_battery.c   | 2 +-
 drivers/power/supply/max17042_battery.c | 2 +-
 drivers/power/supply/sbs-charger.c      | 4 ++--
 drivers/power/supply/smb347-charger.c   | 4 ++--
 6 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/power/supply/bq25890_charger.c b/drivers/power/supply/bq25890_charger.c
index 741a45cc5f35..f7510ada6b73 100644
--- a/drivers/power/supply/bq25890_charger.c
+++ b/drivers/power/supply/bq25890_charger.c
@@ -1590,7 +1590,7 @@ static int bq25890_suspend(struct device *dev)
 	struct bq25890_device *bq = dev_get_drvdata(dev);
 
 	/*
-	 * If charger is removed, while in suspend, make sure ADC is diabled
+	 * If charger is removed, while in suspend, make sure ADC is disabled
 	 * since it consumes slightly more power.
 	 */
 	return bq25890_field_write(bq, F_CONV_RATE, 0);
diff --git a/drivers/power/supply/charger-manager.c b/drivers/power/supply/charger-manager.c
index fd4cd9cd2ce2..8e8c5109401a 100644
--- a/drivers/power/supply/charger-manager.c
+++ b/drivers/power/supply/charger-manager.c
@@ -904,7 +904,7 @@ static bool cm_setup_timer(void)
 }
 
 /**
- * charger_extcon_work - enable/diable charger according to the state
+ * charger_extcon_work - enable/disable charger according to the state
  *			of charger cable
  *
  * @work: work_struct of the function charger_extcon_work.
diff --git a/drivers/power/supply/da9030_battery.c b/drivers/power/supply/da9030_battery.c
index d25279c26030..8c4daec0a6b6 100644
--- a/drivers/power/supply/da9030_battery.c
+++ b/drivers/power/supply/da9030_battery.c
@@ -263,7 +263,7 @@ static void da9030_charger_check_state(struct da9030_charger *charger)
 		} else if (charger->adc.vbat_res >
 			   charger->thresholds.vbat_low) {
 			/* we are charging and passed LOW_THRESH,
-			   so upate DA9030 VBAT threshold
+			   so update DA9030 VBAT threshold
 			 */
 			da903x_write(charger->master, DA9030_VBATMON,
 				     charger->thresholds.vbat_low);
diff --git a/drivers/power/supply/max17042_battery.c b/drivers/power/supply/max17042_battery.c
index cbf3ac9c3e14..a53970af56cb 100644
--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -1080,7 +1080,7 @@ static int max17042_init_chip(struct max17042_chip *chip)
 		/* update capacity params */
 		max17042_update_capacity_regs(chip);
 
-		/* delay must be atleast 350mS to allow VFSOC
+		/* delay must be at least 350mS to allow VFSOC
 		 * to be calculated from the new configuration
 		 */
 		msleep(350);
diff --git a/drivers/power/supply/sbs-charger.c b/drivers/power/supply/sbs-charger.c
index e7b4e10dcfd5..bc40bbb429e6 100644
--- a/drivers/power/supply/sbs-charger.c
+++ b/drivers/power/supply/sbs-charger.c
@@ -2,10 +2,10 @@
 /*
  * Copyright (c) 2016, Prodys S.L.
  *
- * This adds support for sbs-charger compilant chips as defined here:
+ * This adds support for sbs-charger compliant chips as defined here:
  * http://sbs-forum.org/specs/sbc110.pdf
  *
- * Implemetation based on sbs-battery.c
+ * Implementation based on sbs-battery.c
  */
 
 #include <linux/init.h>
diff --git a/drivers/power/supply/smb347-charger.c b/drivers/power/supply/smb347-charger.c
index c1b67dac8ef6..72dfa15b3d80 100644
--- a/drivers/power/supply/smb347-charger.c
+++ b/drivers/power/supply/smb347-charger.c
@@ -149,7 +149,7 @@
  * @pre_charge_current: current (in uA) to use in pre-charging phase
  * @termination_current: current (in uA) used to determine when the
  *			 charging cycle terminates
- * @pre_to_fast_voltage: voltage (in uV) treshold used for transitioning to
+ * @pre_to_fast_voltage: voltage (in uV) threshold used for transitioning to
  *			 pre-charge to fast charge mode
  * @mains_current_limit: maximum input current drawn from AC/DC input (in uA)
  * @usb_hc_current_limit: maximum input high current (in uA) drawn from USB
@@ -302,7 +302,7 @@ static int current_to_hw(const unsigned int *tbl, size_t size, unsigned int val)
  *
  * Function checks whether any power source is connected to the charger and
  * updates internal state accordingly. If there is a change to previous state
- * function returns %1, otherwise %0 and negative errno in case of errror.
+ * function returns %1, otherwise %0 and negative errno in case of error.
  */
 static int smb347_update_ps_status(struct smb347_charger *smb)
 {
-- 
2.48.1

