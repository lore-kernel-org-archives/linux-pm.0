Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=94.231.106.230
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794149173;
	b=W/YmdnFNUuFOSguJcxvctx7E7bDcx0F3tG8pfYYcvaNMxeXwlhPSwvH+tOMvPk4qi05M
	 8bMyabMBeD+TqK8iRl5hzu6FcpCyTitVK6ggC91NEjrLkfE1lLyIIWXR3/TuY76j4ZMH/
	 UorhTX41A88MJem0Zyh/yM3PfbmP5p1IZha4LEsc9A5wI3MICK86P02mTakmvbOKH76/G
	 UX6dMcTHO9r1qVK2DgdOUa85QHFoH1ncTxsmhq43qzwkOWQP6jIgMGnksr9AMuSOhFogB
	 J1tAyw063U9fNhnwnX7dd39ep4XK9tdxLIeXVSEcDOBevui6xi2uqh1Bz/M3I7jBy5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794149173;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=nmp6Lbf1nnvmYYW5XeUYcFIn65F/XzSZsGXYhfjdLPU=;
	b=bHv09pYuewyHtE6IBplu4QoFK+SmcZ4+tjpIZjVLfq2OGlWnMZiWdsE6txxpvH+mat1t
	 QrImIQcAQsJzQYHYvnuFH21XoMacBd1AMXSOXCabxUN9SLOzb2TtZQm5KnKD/YWOvzdXc
	 UxcyO447CzDypByf0O0Cp/k6oPJ6HH/oNaUaPtwd6ZBIflo90p8rJ+ad4ig65iGE0RQUx
	 8LqLaG120cxPXBNU+7bDjjEFtelagj6IwzEl78r24WCIH+q/bxkVE68c7i+XfYkFyFpR8
	 NhG9oMvmaCpjCHwlEIBRB5ycVZSUVBhZVpKLAx5n5HOWMVkv9YksBVHM8vTN8uNPe0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=klattorp.se;
	spf=pass smtp.mailfrom=klattorp.se;
	dkim=pass header.d=klattorp.se header.i=@klattorp.se header.a=rsa-sha256 header.s=simplycom2 header.b=ZGUhGtpt;
	arc=none smtp.remote-ip=94.231.106.230
Received: from smtp-out2.simply.com (smtp-out2.simply.com [94.231.106.230])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2285606A320
	for <linux-pm@vger.kernel.org>; Sun,  8 Nov 2026 14:46:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2285606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=klattorp.se
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=klattorp.se
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=klattorp.se header.i=@klattorp.se header.a=rsa-sha256 header.s=simplycom2 header.b=ZGUhGtpt
Received: from localhost.localdomain (81-228-203-110-no2102.tbcn.telia.com [81.228.203.110])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4jMwhb3CSHz1DR2Z;
	Sun,  8 Nov 2026 15:46:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=klattorp.se; s=simplycom2;
	t=1794149167;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nmp6Lbf1nnvmYYW5XeUYcFIn65F/XzSZsGXYhfjdLPU=;
	b=ZGUhGtptvQ6TwDOsWO4S2g8igH5rgQrS8IfmpaNIh+rTJTTMc3q56xpXSGi9WU52qJw94b
	zF696Y0fGiwFGJtFXGK1carvom4C+3KoDk9smsU2cTlrP+ALlrAd71UdggfIKMKpBdrUGv
	i0EX0IuI/O54tHDaa9TSk4xZ0qY6l7vLsTdTrNw9EMCHN0ZEaW5G7KMf5FuA2bE90ZM7F5
	faczd44N8GqFtyRcbpgbj7qSidmstv+8unfj8MLNJadiVe7T3GX3v6QsNafF45vPkT3XY1
	UM+7gzfIrkLWoNvi53+rBFR7g+ONLHDknFDKNoZ4a+UOkiRL6a4YK0nrLO+g7A==
From: Hugo Karlsson <huggek@klattorp.se>
To: sre@kernel.org
Cc: linux-pm@vger.kernel.org,
	matheus@castello.eng.br,
	Hugo Karlsson <huggek@klattorp.se>
Subject: [PATCH 1/3] power: supply: max17040: pass the device fwnode to the power supply core
Date: Sun,  8 Nov 2026 15:45:46 +0100
Message-ID: <20261108144548.190622-2-huggek@klattorp.se>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20261108144548.190622-1-huggek@klattorp.se>
References: <20261108144548.190622-1-huggek@klattorp.se>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit f4b782af61ae ("power: max17040: pass status property from
supplier") the driver forwards POWER_SUPPLY_PROP_STATUS to its supplier,
and the DT binding documents a power-supplies property for naming that
supplier. The driver never passes its device node to
devm_power_supply_register(), however, so the power supply core cannot
parse power-supplies and the battery never gets a supplier from
firmware. The status lookup then always returns -ENODEV and userspace
sees POWER_SUPPLY_STATUS_UNKNOWN.

Set psy_cfg.fwnode the way max17042_battery and cw2015_battery already
do.

Fixes: f4b782af61ae ("power: max17040: pass status property from supplier")
Assisted-by: Claude:claude-opus-5-5 [Claude Code]
Signed-off-by: Hugo Karlsson <huggek@klattorp.se>
---
 drivers/power/supply/max17040_battery.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/power/supply/max17040_battery.c b/drivers/power/supply/max17040_battery.c
index 16e42de284..4cb26eca56 100644
--- a/drivers/power/supply/max17040_battery.c
+++ b/drivers/power/supply/max17040_battery.c
@@ -499,6 +499,7 @@ static int max17040_probe(struct i2c_client *client)
 
 	i2c_set_clientdata(client, chip);
 	psy_cfg.drv_data = chip;
+	psy_cfg.fwnode = dev_fwnode(&client->dev);
 
 	/* Switch to devm_iio_channel_get_optional when available  */
 	chip->channel_temp = devm_iio_channel_get(&client->dev, "temp");
-- 
2.55.0.windows.5

