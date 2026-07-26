Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655B137B41E
	for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2026 07:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785050531; cv=none; b=uq06KYbpk+jCRpDZvF9VNssbZlpPaAKun8kICyLsTBfdEzw3ReWqkQK0DCWZQAZhzLFkyGRC5pQZZw6obHmWS0X+5HkP3lgNT9WvEqMsB3z16JWHjZi+2nPMqAhzLKchkVNClyWxpLt/XrVPu/6r/mA8DTL15Nq6h1L9y96b7Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785050531; c=relaxed/simple;
	bh=VZqa9XeAd4NhX6cM73mF0bLWzPvOZixViX26jECVjuQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yp8TMX2eb8M2lZbd1cR6fpSZTscMf3afhKLUAhQi8Olh1fAV5jmqdrma7cjRzpWCrghfvIAFsAwZhQob9lHtoMGIFU6rwIB6v1GKWqVOT28Idqz3v3dlEw1x2C+qvz1SUPZRCluvCg8uXtwqmBJ3ZMq5OeWr275JNC2JzxOiaiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qbf2Abjk; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qbf2Abjk"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-38d489b6b71so1588566a91.0
        for <linux-pm@vger.kernel.org>; Sun, 26 Jul 2026 00:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785050528; x=1785655328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CjR+vy5fTEU4JTVfRNyKayBUu5r66+FapJQWGGIffo0=;
        b=Qbf2AbjkAAjrPll47sXx2gEXU2rZ4R4mAP5wqRrWDnMMRXXFyPf0p4m1DxJVrZ6S7t
         lyvyGe7YQHb9vGLrsU+3EE5q3QJ07LH0wygdQvqHwz1/2JBPqYcMKkZBH9w6J1OHQOA8
         0VdsfbA6d2YXUWM5c9GFJXovdh6MsQZi0oo8z1m2fSemrw9/u9JoQ/Np8WFUvms5K+af
         s64rdZpZcMzILLx6b39Irt9wSrSeHM0601Jce2OlPtK1eiS91uhwAYzUYxtsY0CZgjZY
         RwiThq0GKezUcq4JmGFfiRkXS4zj0a/SGVQkSx7C1Z4G23zTk6W62SVP3NEwqbWUJ8GM
         uw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785050528; x=1785655328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CjR+vy5fTEU4JTVfRNyKayBUu5r66+FapJQWGGIffo0=;
        b=SA82irWI5rXufP5R2KkAmR6sD73EL/aVtMkkzh9CqKHpuy/YMgcC5WdyBCs19fK9+7
         nuEFbuZRsKIlkEGid5YLA7Qvn5y8QJovBNvB+51aTNAHWAiQuDP7gE1e5yV8yQQQGYZd
         +MNERzf56sq+ZxBxAFcGqTE57mEylPeoyNWuHiTda1vcIvr0t4VSBEgsAhK2SjsKnL6X
         RvnQz7QilKr07Q2+6dd4bX5xFGvNXN5paZrYI5nslG+AFHwm1vElgbXTQ3tSIvWU151+
         KaPkfOy6pLJo+NYxwnabOaZrmMadBA3u//Lg87EpuPkeaxF9RgUNZ9uQO8zsTzIKHX1+
         Q/Gg==
X-Gm-Message-State: AOJu0Yw16pOtNsN+89hhcbHUR5fJo54pXJ6xM6dokAEABxTknqmFIB0j
	k/NxsUtJV2Qx9bIRXpvHvG6HvnVinkczk7jabV1EUINmZMv5PjKJmYbSFQnF2HAd2Rg=
X-Gm-Gg: AR+sD112LejgTkHuVCKBozZTXLxoHbIDcELkilo6EomSzD8ToEm1zcS+9BBGj4m4nXn
	Ikw7A1cEhRKpRbTeTz1aLtnAybh09QP3DfjYbPybFV5yNHOFaF/RbXbSInPzbzIDSpvhD6OnzOs
	96omTLylqZ/0/NnoTvFrohV+S75ED06egwXURPRru6OcScQfx553GWhEPgFJJMAh7z4b7icoeVK
	2jerhGOAhMrptI5q0WHZfRP2be7VlyNGVOWxmkXL8xyypJdMOiosL436/rJimWpFu2Kx4z5siZs
	e2Iy66Q/Q1Qaxnwczd1142Tpt2X+d/wz9ZOT81qufCJGVfBesqIGfmWw0N+CW7f7lEWiYhtUTJe
	hjDnwcFcynl9a+9O7b5HjCKWaF059Mgl7pNOc6XEXB5d+bj/wYkYTKZj+dLSpGWnftqnn4+Dh4/
	OuHg==
X-Received: by 2002:a17:90b:17cd:b0:38d:dfd1:7c1 with SMTP id 98e67ed59e1d1-38f293cf2ddmr4553457a91.2.1785050528186;
        Sun, 26 Jul 2026 00:22:08 -0700 (PDT)
Received: from kdev.. ([108.180.130.139])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f294e1ab1sm1489074a91.10.2026.07.26.00.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 00:22:07 -0700 (PDT)
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
To: Sebastian Reichel <sre@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Babanpreet Singh <bbnpreetsingh@gmail.com>
Subject: [PATCH 1/2] power: supply: sbs-battery: Use a per-device serial number buffer
Date: Sun, 26 Jul 2026 07:22:05 +0000
Message-ID: <20260726072206.7-2-bbnpreetsingh@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260726072206.7-1-bbnpreetsingh@gmail.com>
References: <20260726072206.7-1-bbnpreetsingh@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sbs_get_battery_serial_number() formats the battery serial number into
sbs_serial[], a single file-scope buffer shared by every sbs-battery
instance, and points val->strval at it.

Nothing restricts this driver to one instance. It binds per I2C client,
and sbs-manager registers one muxed I2C channel per supported battery
specifically so that the smart battery driver can be bound to each of
them, so several sbs-battery instances on one system is a supported
configuration.

The power supply core reads strval after the driver's get_property()
callback has returned: power_supply_show_property() fills a local
union power_supply_propval, then formats it with sysfs_emit(). Two
concurrent POWER_SUPPLY_PROP_SERIAL_NUMBER reads on different batteries
therefore race for the shared buffer - battery B's sprintf() can land
between battery A filling the buffer and the core reading it, and
battery A then reports battery B's serial number.

Move the buffer into struct sbs_info so that each battery formats into
its own storage. It is deliberately not added to the chip->strings[]
array: those entries hold the cached constant strings that
sbs_invalidate_cached_props() clears on presence changes, whereas the
serial number is re-read from its word register on every access.

Fixes: d3ab61ecbab2 ("bq20z75: Add support for more power supply properties")
Assisted-by: Claude:claude-opus-5
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
---
 drivers/power/supply/sbs-battery.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/sbs-battery.c b/drivers/power/supply/sbs-battery.c
index 017ec06be766..9bdb6c599c5f 100644
--- a/drivers/power/supply/sbs-battery.c
+++ b/drivers/power/supply/sbs-battery.c
@@ -217,6 +217,7 @@ struct sbs_info {
 	u32				flags;
 	int				technology;
 	char				strings[NR_STRING_BUFFERS][I2C_SMBUS_BLOCK_MAX + 1];
+	char				serial[5];
 };
 
 static char *sbs_get_string_buf(struct sbs_info *chip,
@@ -821,18 +822,18 @@ static int sbs_get_battery_capacity(struct i2c_client *client,
 	return 0;
 }
 
-static char sbs_serial[5];
 static int sbs_get_battery_serial_number(struct i2c_client *client,
 	union power_supply_propval *val)
 {
+	struct sbs_info *chip = i2c_get_clientdata(client);
 	int ret;
 
 	ret = sbs_read_word_data(client, sbs_data[REG_SERIAL_NUMBER].addr);
 	if (ret < 0)
 		return ret;
 
-	sprintf(sbs_serial, "%04x", ret);
-	val->strval = sbs_serial;
+	sprintf(chip->serial, "%04x", ret);
+	val->strval = chip->serial;
 
 	return 0;
 }
-- 
2.43.0

